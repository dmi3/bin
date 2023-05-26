#!/bin/bash


#  Description
#  -----------
#  Show file or stream currently playing in VLC. Shows artist and title on hover (with xfce4-genmon-plugin). See `playerctl -h` for another players.
  
#  Requirements
#  ------------
#  * `sudo apt-get install vlc playerctl`

#  Usage
#  ------------
   
#  * `vlc-now`

#  **Includes useful functions**

function cutExt() {
    cut -d. -f1
}

function wrapInBrackets() {
    xargs -I % echo "<txt>["%"]</txt>"
}

function basename() {
    xargs -0 basename
}

function urlDecode() {
    perl -pe 's/\%(\w\w)/chr hex $1/ge' 
}

url=$(playerctl -p vlc metadata xesam:url 2>/dev/null) && echo "$url" | urlDecode | basename | cutExt | wrapInBrackets || echo ""
playerctl -p vlc metadata --format '<tool>{{xesam:artist}} — {{xesam:title}}</tool>'
