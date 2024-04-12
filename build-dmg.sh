#!/bin/zsh

set -e

if [ -f "PicGuard.dmg" ]; then
    echo "Delete PicGuard.dmg"
    rm -f ./PicGuard.dmg
fi

pnpm -c -s dlx appdmg ./appdmg.json ./PicGuard.dmg

exit 0
