#!/bin/bash

#  Decription
#  ----------
#  Show popup with translation of selected text. Works in any application.

#  Author: Dmitry (http://dmi3.net)
#  Source: https://github.com/dmi3/bin

#  Requirements
#  ----------
#  `sudo apt-get install libtranslate-bin zenity xsel`

#  Usage
#  -----
#  * Bind script to hotkey in your DE.
#  * Select any text. Press hotkey.

DEST_LANG=ru

#sed - fix issue in translate-bin
selection=`xsel -p`
zenity --info --text "$selection\n$(echo "$selection" | translate-bin -s google -t "$DEST_LANG" | sed "s/.*>//g")"


