#!/bin/bash

#  Decription
#  ----------
#  System wide text snippet expander. Simulates cut→replace→paste so works in almost any application. Examples:
#  * Type `->`, press hotkey, get `→`. 
#  * Type `thx`, press hotkey, get `Thank you`.
#
#  Original idea by [sessy](https://bbs.archlinux.org/viewtopic.php?id=71938) and [Linux Magazine](http://www.linux-magazine.com/Issues/2014/162/Workspace-Text-Expander) with following improvements:
#  * Works as keybinding in Compiz/Unity/Openbox
#  * Does not go crazy if keybinding includes Ctrl, Alt, Shift...
#  * Works in Sublime Text/IntelliJ Idea/Chrome/Slack
#  * Expands snippets without preceding space i.e. `30eur` to `30€`
#     - If snippet needs preceding space or start of line - use regexp `\b` i.e. `s/\bv$/✔/g;` converts `v` to `✔` only if its separate symbol
#  * Expands snippets with symbols i.e. `->` to `→`
#  * Expands commands i.e. `now` to formatted todays date, `mon` to to formatted next mondays date
#  * Stores all snippets in one file
#  * Works with Ubuntu 16.04

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Requirements
#  ----------
#  `sudo apt-get install xdotool xclip xsel`

#  Usage
#  -----
#  * Bind script to hotkey in your DE, for example Shift+Tab.
#  * Add new snippets after line 30, in format `s/SHORCUT$/REPLACEMENT/g;`

snippets="
s/<->$/⇄/g;
s/-^$/↑/g;
s/<-$/←/g;
s/->$/→/g;
s/-$/—/g;
s/~$/≈/g;
s/!$/⚠/g;
s/\bv$/✔/g;
s/\bx$/✖/g;
s/\?$/❓/g;
s/>$/❯/g;
s/+-$/±/g;
s/tm$/™/g;
s/larr$/←/g;
s/rarr$/→/g;
s/darr$/↓/g;
s/uarr$/↑/g;
s/copy$/©/g;
s/eur$/€/g;
s/20$/⓴/g;
s/19$/⓳/g;
s/18$/⓲/g;
s/17$/⓱/g;
s/16$/⓰/g;
s/15$/⓯/g;
s/14$/⓮/g;
s/13$/⓭/g;
s/12$/⓬/g;
s/11$/⓫/g;
s/10$/➓/g;
s/9$/➒/g;
s/8$/➑/g;
s/7$/➐/g;
s/6$/➏/g;
s/5/➎/g;
s/4$/➍/g;
s/3$/➌/g;
s/2$/➋/g;
s/1$/➊/g;
s/0$/⓿/g;
s/sim$/simultaneously/g;
s/unf$/unfortunately/g;
s/env$/environment/g;
s/suc$/successful/g;
s/misc$/miscellaneous/g;
s/thx$/Thank you\./g;
s/br$/Regards,\nDmitry/g;
s/bus$/business/g;
s/now$/$(date +'%a %d\/%m\/%y')/g;
s/mon$/$(date +'%a %d\/%m\/%y' --date='next mon')/g;
s/tue$/$(date +'%a %d\/%m\/%y' --date='next tue')/g;
s/wed$/$(date +'%a %d\/%m\/%y' --date='next wed')/g;
s/thu$/$(date +'%a %d\/%m\/%y' --date='next thu')/g;
s/fri$/$(date +'%a %d\/%m\/%y' --date='next fri')/g;
s/sat$/$(date +'%a %d\/%m\/%y' --date='next sat')/g;
s/sun$/$(date +'%a %d\/%m\/%y' --date='next sun')/g;"

xdotool keyup --delay 5 Control_L Control_R Shift_L Shift_R Alt_L Alt_R 
xdotool key   --delay 5 ctrl+shift+Left
xdotool key   --delay 5 ctrl+x
selection=`xsel -b`
echo -n "$selection" | sed "$snippets" | xclip -sel clip
xdotool key   --delay 5  ctrl+v
xdotool keyup --delay 5 Control_L Control_R Shift_L Shift_R Alt_L Alt_R 
