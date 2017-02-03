#!/bin/bash

#  Decription
#  ----------
#  Text Snippet expander. Simulates cut→replace→paste so works in almost any application. Examples:
#  * Type `->`, press hotkey, get `→`. 
#  * Type `thx`, press hotkey, get `Thank you`.
#
#  Original idea [sessy](https://bbs.archlinux.org/viewtopic.php?id=71938), and [Linux Magazine](http://www.linux-magazine.com/Issues/2014/162/Workspace-Text-Expander) with following improvements:
#  * Works as keybinding in Compiz/Unity/Openbox
#  * Does not goes crazy if keybinding includes Ctrl, Alt, Shift...
#  * Works in Sublime Text/IntelliJ Idea/Chrome
#  * Expands snippets without space i.e. `30eur` → `30€`
#  * Expands snippets without symbols i.e. `->` → `→``
#  * Works with Ubuntu 16.04

#  Author: Dmitry (http://dmi3.net)
#  Source: https://github.com/dmi3/bin

#  Requirements
#  ----------
#  `sudo apt-get install xdotool xclip xsel`

#  Usage
#  -----
#  Bind script to hotkey in your DE. Shift+Tab recommended.

sh -c "xdotool key --clearmodifiers ctrl+shift+Left"
sh -c "xdotool key --clearmodifiers ctrl+x"
selection=`xsel -b`

trans="s/<-$/←/g;
s/->$/→/g;
s/larr$/←/g;
s/rarr$/→/g;
s/darr$/↓/g;
s/uarr$/↑/g;
s/eur$/€/g;
s/copy$/©/g;
s/unf$/unfortunately/g;
s/suc$/successful/g;
s/thx$/Thank you\./g;
s/bus$/business/g;"

echo -n "$selection" | sed "$trans" | xclip -sel clip

sh -c "xdotool key --clearmodifiers ctrl+v"

