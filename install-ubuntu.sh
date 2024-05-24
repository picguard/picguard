#!/bin/sh

set -e

if ! command -v wget >/dev/null 2>&1; then
   echo "🟩 Installing wget"
   apt install wget xz -y
fi

FLUTTER_DIR="/home/linux-arm64"

if [ ! -d "$FLUTTER_DIR" ]; then
   echo "🟩 flutter directory created"
   mkdir -p "$FLUTTER_DIR/flutter"
fi

if [ ! -f "$FLUTTER_DIR/flutter-3.19.6-aarch64.tar.xz" ]; then
   echo "🟩 Downloading Flutter"
   wget https://github.com/containerbase/flutter-prebuild/releases/download/3.19.6/flutter-3.19.6-aarch64.tar.xz -P "$FLUTTER_DIR"
fi

if [ -d "$FLUTTER_DIR/flutter" ]; then
   echo "🟩 Removing flutter directory"
   rm -rf "$FLUTTER_DIR/flutter"
fi

echo "🟩 Unzipping"
mkdir "$FLUTTER_DIR/flutter" && tar -xf flutter-3.19.6-aarch64.tar.xz -C "$FLUTTER_DIR/flutter" --strip-components 1

echo "🟩 Config $FLUTTER_DIR/flutter"
git config --global --add safe.directory "$FLUTTER_DIR/flutter"

echo "🟩 Running ls"
ls

export PATH="$PATH:$FLUTTER_DIR/flutter/bin"

exit 0
