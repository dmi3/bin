#!/bin/bash

#  Decription
#  ----------
#  Show popup with translation of selected text. Works in any application.

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Requirements
#  ----------
#  1. Setup https://github.com/dmi3/bin/blob/master/yandex-translate.sh
#  2. `sudo apt-get install zenity xsel`

#  Usage
#  -----
#  * Bind script to hotkey in your DE.
#  * Select any text. Press hotkey.

selection=`xsel -p`
zenity --info --timeout 10 --text "$selection\n$(translate-yandex.sh "$selection")" 

# Alternative using translate-bin
#zenity --info --text "$selection\n$(echo "$selection" | translate-bin -s google -t "$DEST_LANG" | sed "s/.*>//g")"


