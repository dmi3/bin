#!/usr/bin/python3

#  Decription
#  -----------
#  Execute `.desktop` file from terminal


#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Usage
#  -----
#  rundesktop /usr/share/applications/firefox.desktop

from gi.repository import Gio
import sys

def main(myname, desktop, *uris):
    launcher = Gio.DesktopAppInfo.new_from_filename(desktop)
    launcher.launch_uris(uris, None)

if __name__ == "__main__":
    main(*sys.argv)
