#!/bin/sh

set -e

FLUTTER_DIR="$(pwd)/flutter-distro"

if [ -d "$FLUTTER_DIR" ]; then
   echo "🟩 Removing flutter directory"
   rm -rf "$FLUTTER_DIR"
fi

echo "🟩 Get Flutter to $FLUTTER_DIR"
git clone --depth 1 -b 3.24.3 https://github.com/flutter/flutter.git $FLUTTER_DIR

echo "🟩 Config $FLUTTER_DIR"
git config --global --add safe.directory "$FLUTTER_DIR"

echo "🟩 Running ls"
ls -la

exit 0
