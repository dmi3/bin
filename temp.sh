#!/bin/bash

#  Decription
#  ----------
#  Shows CPU, System and GPU temperature

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Requirements
#  ------------
#      sudo apt-get install jq lm-sensors nvidia-smi

#  Usage
#  -----
#    temp

CPU=$(sensors -j | jq '."coretemp-isa-0000"."Package id 0".temp1_input')
SYS=$(sensors -j | jq '."acpitz-acpi-0".temp1.temp1_input')
GPU=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)


test $CPU -gt "60" && CPU="#### $CPU ####\n"
test $SYS -gt "30" && SYS="#### $SYS ####\n"
test $GPU -gt "75" && GPU="#### $GPU ####\n"  

echo "CPU:$CPU SYS:$SYS GPU:$GPU"

# https://github.com/dmi3/qmk_firmware/blob/master/keyboards/handwired/onekey/kb2040/kbecho.py
if type "kbecho.py" > /dev/null; then
  kbecho.py t "CPU:$CPU SYS:$SYS\nGPU:$GPU\n$(date +"%H:%M")"
fi

