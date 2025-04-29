#!/bin/bash
sleep 2
ID=`xsetwacom list devices | grep "STYLUS" | awk '{print $11}'`
echo $ID
xsetwacom set $ID MapToOutput "DisplayPort-1"
