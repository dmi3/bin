#!/usr/bin/python3
# -*- coding: utf-8 -*-

#  Decription
#  -----------
#  Font especially designed to fit 6 digits to 20x8 screens
#  For some reason [miniwi.flf](https://github.com/xero/figlet-fonts/blob/master/miniwi.flf) [figlet font](https://developer.run/26) is not working in tty
#  Useful for [Raspberry Pi 2fa](https://developer.run/45)
#  ```
#      ▐ ██ ██ ▌▐ ██ ██
#      ▐  ▐  ▐ ▌▐ ▌  ▌
#      ▐ ██ ██ ██ ██ ██
#      ▐ ▌   ▐  ▐  ▐ ▌▐
#      ▐ ██ ██  ▐ ██ ██
#  ```

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Usage
#  -----
#      python3 numbers.py 123456



import sys

map = {
'1':
"""   .
  ▐.
  ▐.
  ▐.
  ▐.
  ▐.
""",
'2':
"""   .
 ██.
  ▐.
 ██.
 ▌ .
 ██.
""",
'3':
"""   .
 ██.
  ▐.
 ██.
  ▐.
 ██.
""",
'4':
"""   .
 ▌▐.
 ▌▐.
 ██.
  ▐.
  ▐.
""",
'5':
"""   .
 ██.
 ▌ .
 ██.
  ▐.
 ██.
""",
'6':
"""   .
 ██.
 ▌ .
 ██.
 ▌▐.
 ██.
""",
'7':
"""   .
 ██.
  ▐.
  ▐.
  ▐.
  ▐.
""",
'8':
"""   .
 ██.
 ▌▐.
 ██.
 ▌▐.
 ██.
""",
'9':
"""   .
 ██.
 ▌▐.
 ██.
  ▐.
 ██.
""",
'0':
"""   .
 ██.
 ▌▐.
 ▌▐.
 ▌▐.
 ██.
""",
}

print(sys.argv[1])

strs = [" " for x in range(6)]

for n in sys.argv[1]:
    line = map[n].replace(".\n", "")
    chunks = [line[i:i+3] for i in range(0, len(line), 3)]

    for i,chunk in enumerate(chunks):
        strs[i]+=chunk

for s in strs:
    print(s)