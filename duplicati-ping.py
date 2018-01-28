#!/usr/bin/python3

#  Decription
#  -----------
#  Ping <https://healthchecks.io/> on successful [Duplicati](https://www.duplicati.com/) backup

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Usage
#  -----
#  Add path to this script to `run-script-after` in job `Configuration` → `Options` → `Advanched Options`
#  On Windows you will need to create `.bat` file containing path to this script, and add path to `.bat` file to `run-script-after`

import os
import urllib.request

if os.environ['DUPLICATI__OPERATIONNAME'] == 'Backup':
    with open(os.environ['DUPLICATI__RESULTFILE']) as r:
        if str('ParsedResult: Success' in r.read()):
            urllib.request.urlopen('https://hchk.io/ URL')
