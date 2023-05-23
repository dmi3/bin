#!/bin/bash


#  Description
#  -----------
#  Show file or stream currently playing in VLC. See `playerctl -h` for another players
  
#  Requirements
#  ------------
#  * `sudo apt-get install vlc playerctl`

#  Usage
#  ------------
   
#  * `vlc-now`

function cutExt() {
    cut -d. -f1
}

function wrapInBrackets() {
    xargs -I % echo [%]
}

function basename() {
    xargs -0 basename
}

function urlDecode() {
    perl -pe 's/\%(\w\w)/chr hex $1/ge' 
}

url=$(playerctl -p vlc metadata xesam:url 2>/dev/null) && echo "$url" | urlDecode | basename | cutExt | wrapInBrackets || echo ""
