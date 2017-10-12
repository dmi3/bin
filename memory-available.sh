#!/bin/bash

#  Decription
#  ----------
#  Prints available memory in gigabytes. Sends urgent notification if usage is less than defined value.
#  Works best with [indicator-sysmonitor](https://github.com/fossfreedom/indicator-sysmonitor) and [dunst](http://developer.run/23)

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Requirements
#  ----------
#  1. `sudo apt-get install notify-send `

available=$(awk '/MemAvailable/ { printf "%.0f", $2/1024 }' /proc/meminfo)

if [ $available -lt 1000 ] # threshold in megabytes
    then
    notify-send -u critical "Memory is running out! $available Mb"
fi

echo $available | awk '{ printf "%.1f", $1/1024 }'