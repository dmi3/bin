#!/bin/sh

#  Decription
#  ----------
#  Prompts for text. Then inputs translation. Works in any application.

#  Author: Dmitry (http://dmi3.net)
#  Source: https://github.com/dmi3/bin

#  Requirements
#  ----------
#  `sudo apt-get install libtranslate-bin xdotool`

#  Usage
#  -----
#  * Bind script to hotkey in your DE. After input wait couple of seconds for translation to appear.

DEST_LANG=en
SRC_LANG=ru

echo $(zenity --entry) | translate-bin -s google -f "$SRC_LANG" -t "$DEST_LANG" | sed "s/.*>//g" | xclip -sel clip

sh -c "xdotool key --clearmodifiers ctrl+v"

