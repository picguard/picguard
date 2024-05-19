#!/bin/zsh

set -e

# https://gist.github.com/GuillaumeFalourd/4efc73f1a6014b791c0ef223a023520a
THIRD_PARTY_MAC_DEVELOPER_INSTALLER=$1
export "THIRD_PARTY_MAC_DEVELOPER_INSTALLER=$THIRD_PARTY_MAC_DEVELOPER_INSTALLER"

signFile() {
  filename=$1
  echo "Signing FILE: $filename"
  /usr/bin/codesign -s "$THIRD_PARTY_MAC_DEVELOPER_INSTALLER" --force --timestamp --entitlements macos/Runner/AppStore-Release.entitlements --options runtime "$filename" -v
}

export -f signFile
if [ -d "build/macos/Build/Products/AppStore-Release/PicGuard.app" ]; then
    find build/macos/Build/Products/AppStore-Release/PicGuard.app -exec bash -c 'signFile "{}"' \;
else
  echo "Directory (build/macos/Build/Products/AppStore-Release/PicGuard.app) does not exist!"
  exit 1
fi

exit 0
