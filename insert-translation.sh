#!/bin/sh

#  Decription
#  ----------
#  Prompts for text. Then inputs translation. Works in any application.

#  Author: Dmitry (http://dmi3.net)
#  Source: https://github.com/dmi3/bin

#  Requirements
#  ----------
#  1. Setup https://github.com/dmi3/bin/blob/master/yandex-translate.sh
#  2. `sudo apt-get install zenity xsel`

#  Usage
#  -----
#  * Bind script to hotkey in your DE. After input wait couple of seconds for translation to appear.

DEST_LANG=en
SRC_LANG=ru

printf $(yandex-translate.sh "$(zenity --entry)") | xclip -sel clip

# Alternative using translate-bin
# echo $(zenity --entry) | translate-bin -s google -f "$SRC_LANG" -t "$DEST_LANG" | sed "s/.*>//g" | xclip -sel clip

sh -c "xdotool key --clearmodifiers ctrl+v"

