#!/bin/sh
xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/myxkb $DISPLAY 2> /dev/null
