#!/bin/bash


#  Description
#  -----------
#  Saves full screen screenshot with current window name and date to predefined folder and plays sound if successful.
  
#  Requirements
#  ------------
#  * `sudo apt-get install scrot xdotool`

#  Usage
#  ------------
   
#  * Bind a hotkey to `game-screenshot.sh /path/to/folder`

scrot "$*/%Y_$(xdotool getwindowfocus getwindowname | tr -dc '[:alnum:]\n\r')_%m_%d_%H_%M_%S.png" \
    && ffplay ~/git/stuff/documents/sounds/Comix_Zone_STRIGIL\ PACK\ IT\ IN.mp3 -autoexit -nodisp


