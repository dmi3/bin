#!/usr/bin/python3

#  Decription
#  -----------
#  Moves mouse in the center of active window.

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Requirements
#  ------------
#      sudo apt-get install gir1.2-wnck-3.0

#  Usage
#  -----
#  center-mouse-active-window.py


import gi
gi.require_version('Wnck', '3.0')
from gi.repository import Wnck
from sh import xdotool

screen = Wnck.Screen.get_default()
screen.force_update()
active_window = screen.get_active_window()
g = active_window.get_geometry()

xdotool("mousemove", int(g.xp + g.widthp/2), int(g.yp +g.heightp/2))
