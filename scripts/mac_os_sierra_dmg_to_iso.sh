#!/bin/bash

# Props to: https://gist.github.com/wrossmck/20858f8393d3bb9158a1
# taken from http://www.insanelymac.com/forum/topic/308533-how-to-create-a-bootable-el-capitan-iso-fo-vmware/

# Mount the installer image
hdiutil attach /Applications/Install\ macOS\ Sierra.app/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app

# Create the Sierra ISO Image of 7316mb with a Single Partition - Apple Partition Map
hdiutil create -o /tmp/Sierra.cdr -size 7316m -layout SPUD -fs HFS+J

# Mount the Sierra Blank ISO Image
hdiutil attach /tmp/Sierra.cdr.dmg -noverify -nobrowse -mountpoint /Volumes/install_build

# Restore the Base System into the Sierra Blank ISO Image
asr restore -source /Volumes/install_app/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase

# Remove Package link and replace with actual files
rm /Volumes/OS\ X\ Base\ System/System/Installation/Packages
cp -rp /Volumes/install_app/Packages /Volumes/OS\ X\ Base\ System/System/Installation/

# Copy Sierra installer dependencies
cp -rp /Volumes/install_app/BaseSystem.chunklist /Volumes/OS\ X\ Base\ System/BaseSystem.chunklist
cp -rp /Volumes/install_app/BaseSystem.dmg /Volumes/OS\ X\ Base\ System/BaseSystem.dmg

# Unmount the installer image
hdiutil detach /Volumes/install_app

# Unmount the Sierra ISO Image
hdiutil detach /Volumes/OS\ X\ Base\ System/

# Convert the Sierra ISO Image to ISO/CD master
hdiutil convert /tmp/Sierra.cdr.dmg -format UDTO -o /tmp/Sierra.iso

# Remove temporary DMG file
rm /tmp/Sierra.cdr.dmg

# Rename the Sierra ISO Image and move it to the desktop
mv /tmp/Sierra.iso.cdr ~/Desktop/Sierra.iso
