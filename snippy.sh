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
#  * Works in Sublime Text/IntelliJ Idea/Chrome
#  * Expands snippets without preceding space i.e. `30eur` to `30€`
#     - If snippet needs preceding space or start of line - use regexp `\b` i.e. `s/\bv$/✔/g;` converts `v` to `✔` only if its separate symbol
#  * Expands snippets with symbols i.e. `->` to `→`
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
#  * If you use this for emoji, it will work but make me sad.

snippets="
s/<->$/⇄/g;
s/-^$/↑/g;
s/<-$/←/g;
s/->$/→/g;
s/~$/≈/g;
s/!$/⚠/g;
s/\bv$/✔/g;
s/\bx$/✖/g;
s/+-$/±/g;
s/tm$/™/g;
s/larr$/←/g;
s/rarr$/→/g;
s/darr$/↓/g;
s/uarr$/↑/g;
s/copy$/©/g;
s/eur$/€/g;
s/fu$/futher/g;
s/sim$/simultaneously/g;
s/unf$/unfortunately/g;
s/env$/environment/g;
s/suc$/successful/g;
s/thx$/Thank you\./g;
s/bus$/business/g;"

sh -c "xdotool key --clearmodifiers ctrl+shift+Left"
sh -c "xdotool key --clearmodifiers ctrl+x"
selection=`xsel -b`

sleep 0.05

echo -n "$selection" | sed "$snippets" | xclip -sel clip

sleep 0.05

sh -c "xdotool key --clearmodifiers ctrl+v"

