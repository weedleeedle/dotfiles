#!/bin/bash
sleep 1
ID=`xsetwacom list devices | grep "STYLUS" | awk '{print $9}'`
echo $ID
xsetwacom set $ID MapToOutput "HEAD-0"
