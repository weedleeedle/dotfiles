#!/bin/bash
while :
do
    termdown $1 -T Work && notify-send -u normal -t 10000 "Time's up!" "Time to take a break!" ; aplay ./ping.wav
    termdown $2 -T Relax && notify-send -u normal -t 10000 "Time's up!" "Time to get back to work!" ; aplay ./ping.wav
done
