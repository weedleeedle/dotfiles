#!/bin/bash
# Run a pomodoro timer. Starts a clock in the terminal and sends a ping and
# notification when the timer expires. 
# Takes two arguments, the first is the duration of the work timer and the
# second is the duration of the break timer. No difference between the two other
# than the label of the timer and the notification sent after each timer
# expires.
while :
do
    termdown $1 -T Work && notify-send -u normal -t 10000 "Time's up!" "Time to take a break!" ; aplay ./ping.wav
    termdown $2 -T Relax && notify-send -u normal -t 10000 "Time's up!" "Time to get back to work!" ; aplay ./ping.wav
done
