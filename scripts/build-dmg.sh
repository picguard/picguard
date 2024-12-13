#!/usr/bin/env zsh

set -e

test -f PicGuard.dmg && rm -f PicGuard.dmg

appdmg ./appdmg.json ./PicGuard.dmg

exit 0
