#!/usr/bin/env bash

# Convert the archive of the Flutter app to a Flatpak.


# Exit if any command fails
set -e

# Echo all commands for debug purposes
set -x


# No spaces in project name.
projectName=PicGuard
projectId=com.kjxbyz.PicGuard
executableName=picguard

buildDir=build/linux/x64/release/bundle


# ------------------------------- Build Flatpak ----------------------------- #

# Copy the portable app to the Flatpak-based location.
cp -r $buildDir /app/
chmod +x /app/$buildDir/$executableName
mkdir -p /app/bin
ln -s /app/$buildDir/$executableName /app/bin/$executableName

# Install the icon.
iconDir=/app/share/icons/hicolor/scalable/apps
mkdir -p $iconDir
cp -r flatpak/$projectId.png $iconDir/

# Install the desktop file.
desktopFileDir=/app/share/applications
mkdir -p $desktopFileDir
cp -r flatpak/$projectId.desktop $desktopFileDir/

# Install the AppStream metadata file.
metadataDir=/app/share/metainfo
mkdir -p $metadataDir
cp -r flatpak/$projectId.metainfo.xml $metadataDir/
