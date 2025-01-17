#!/bin/bash
window=$(xdotool search --name "Antimatter Dimensions")

if [ -z "$window" ]; then
    echo "Couldn't find Antimatter Dimensions window."
    exit 1
fi

while true
do
    xdotool key --window $window c m
    sleep 0.01
done


