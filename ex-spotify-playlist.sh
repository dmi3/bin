#!/bin/bash

#  Export playlists from Spotify without giving credentials to shady sites (to avoid your Spotify credentials be stolen and resold to someone in different timezone)
#  
#  Converts Spotify playlist from "Song Links" list:
#  
#      https://open.spotify.com/track/6autdCG3xl7gzoiDCEB2HN
#      https://open.spotify.com/track/4q6RvRkXquQ965hubV58lb
#      https://open.spotify.com/track/01pzLOA8rQLfoodUCLc2wj
#  
#  To "Track - Artist" list:
#  
#      Nerevar Rising - Jeremy Soule
#      Arcanum - NewEnglandStringQuartet
#      Wilderness - Matt Uelmen    

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)
  
#  Requirements
#  ------------
#      sudo apt-get install jq

#  Usage
#  ------------
#  1. Open Spotify app
#  2. Open playlist or "Songs" view
#  3. Select all tracks `Ctrl+A`
#  4. Copy track urls `Ctrl+C`
#  5. Paste into file and save
#  6. `cat /path/to/file | ex-spotify-playlist.sh`

cat | xargs -n 1 curl -s | grep "Spotify.Entity" | grep -Po "\{.*\}" | jq -r '(.name + " - " + .artists[0].name)'