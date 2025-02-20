#!/bin/bash

#  Decription
#  ----------
#  Sets the wallpaper, randomly selecting one from a folder. If the wallpaper is smaller than the screen, it also changes the surrounding area to a color that matches the wallpaper's palette.

#  Author: Dmitry (http://dmi3.net)
#  Source: https://github.com/dmi3/bin

#  Instalation
#  -----------
#      sudo apt-get install nitrogen coreutils

#  Usage
#  -----
#  * Put some nice pictures in ~/wallpapers/
#  * Call this script by cron, on login or unlock
#  * If you want fixed background color - put one in ~/wallpapers/bg_color
#  * You may want to change `--set-centered` to `--set-auto` depending on how picture should be scaled.


export DISPLAY=":0"

DIRECTORY=~/wallpapers/

if [ ! -d "$DIRECTORY" ]; then
  echo "Directory does not exist: $DIRECTORY"
  exit 1
fi

WALL=$DIRECTORY/$(ls ~/wallpapers/ | shuf -n1)

if [ -f "$DIRECTORY/bg_color" ]; then
    COLOR=$(<"$DIRECTORY/bg_color")
else
    COLOR=$(convert $WALL -scale 1x1\! -format '%[pixel:u]' info:- | awk -F'[(),]' '{printf "#%02X%02X%02X\n", $2, $3, $4}')
fi

nitrogen --save --set-color="$COLOR" --set-centered $WALL

