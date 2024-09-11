#!/bin/sh

set -e

if ! command -v sudo >/dev/null 2>&1; then
   echo "🟩 Installing sudo"
   apt install sudo -y
fi

if ! command -v wget >/dev/null 2>&1; then
   echo "🟩 Installing wget"
   sudo apt install wget xz-utils -y
fi

if ! command -v git >/dev/null 2>&1; then
   echo "🟩 Installing git"
   sudo apt install git -y
fi

FLUTTER_DIR="/home/flutter"

if [ ! -d "$FLUTTER_DIR" ]; then
   echo "🟩 flutter directory created"
   mkdir -p "$FLUTTER_DIR"
fi

if [ ! -f "$FLUTTER_DIR/flutter_linux_3.24.2-stable.tar.xz" ]; then
   echo "🟩 Downloading Flutter"
   wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.2-stable.tar.xz -P "$FLUTTER_DIR"
fi

if [ -d "$FLUTTER_DIR/flutter" ]; then
   echo "🟩 Removing flutter directory"
   rm -rf "$FLUTTER_DIR/flutter"
fi

echo "🟩 Unzipping"
mkdir "$FLUTTER_DIR/flutter" && tar -xf "$FLUTTER_DIR/flutter_linux_3.24.2-stable.tar.xz" -C "$FLUTTER_DIR/flutter" --strip-components 1

echo "🟩 Config $FLUTTER_DIR/flutter"
git config --global --add safe.directory "$FLUTTER_DIR/flutter"

echo "🟩 Running ls"
ls

exit 0
