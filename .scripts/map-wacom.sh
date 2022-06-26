#!/bin/bash
sleep 1
ID=`xsetwacom list devices | grep "STYLUS" | awk '{print $7}'`
echo $ID
xsetwacom set $ID MapToOutput "eDP1"
