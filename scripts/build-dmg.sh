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
  --background "images/background.png" \
  --eula "eula.rtf" \
  --window-pos 200 180 \
  --window-size 660 500 \
  --icon-size 100 \
  --icon "PicGuard.app" 180 170 \
  --hide-extension "PicGuard.app" \
  --app-drop-link 480 170 \
  "PicGuard.dmg" \
  "build/macos/Build/Products/Release-free/PicGuard.app"

exit 0
