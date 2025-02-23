#!/bin/sh

set -e

if ! command -v git >/dev/null 2>&1; then
   echo "🟩 Installing git"
   sudo apt-get install -y git
fi

FLUTTER_DIR="/home/linux-arm64"

if [ ! -d "$FLUTTER_DIR" ]; then
   echo "🟩 flutter directory created"
   mkdir -p "$FLUTTER_DIR"
fi

if [ -d "$FLUTTER_DIR/flutter" ]; then
   echo "🟩 Removing flutter directory"
   rm -rf "$FLUTTER_DIR/flutter"
fi

echo "🟩 Cloning"
mkdir -p "$FLUTTER_DIR/flutter" && git clone --depth 1 -b 3.29.0 https://github.com/flutter/flutter.git "$FLUTTER_DIR/flutter"

echo "🟩 Config $FLUTTER_DIR/flutter"
git config --global --add safe.directory "$FLUTTER_DIR/flutter"

exit 0
