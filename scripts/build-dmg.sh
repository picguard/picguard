#!/bin/zsh

set -e

if ! command -v create-dmg >/dev/null 2>&1; then
   echo "🟩 Installing create-dmg"
   HOMEBREW_NO_AUTO_UPDATE=1 brew install create-dmg
fi

create-dmg --version

test -f PicGuard.dmg && rm -f PicGuard.dmg

create-dmg \
  --volname "PicGuard" \
  --volicon "logo/logo.icns" \
  --eula "eula.rtf" \
  --window-pos 200 120 \
  --window-size 600 400 \
  --icon-size 100 \
  --icon "PicGuard.app" 200 180 \
  --hide-extension "PicGuard.app" \
  --app-drop-link 400 180 \
  "PicGuard.dmg" \
  "build/macos/Build/Products/Release-free/PicGuard.app"

exit 0
