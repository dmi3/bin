#!/usr/bin/python3

#  Decription
#  -----------
#  Renames files given in arguments. Interactively prompts for file name. If no otherwise specified - uses first file
#  name + number.

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Usage
#  -----
#  rename.py file1 file2 file3 ...

from sys import argv
from os import rename
from urllib.request import unquote
from os.path import splitext, abspath, basename, dirname
from sh import zenity, notify_send


new = ""
message = ""

for i,f in enumerate(argv[1:]):
    if "file://" in f:
        f = unquote(f)[7:]

    fdir = dirname(abspath(f))
    name,ext = splitext(f)

    if new == "":
       new = zenity("--text", "Rename", "--entry", "--entry-text", basename(name)).strip()

    try:
        new_name = "%s/%s_%s%s" % (fdir, new, i, ext)
        rename(f, new_name)
        message = "%s%s → %s\n" % (message, f, new_name)
    except Exception as e:
        notify_send("Error", "-u", "critical", e)

notify_send("Renamed", message)