#!/bin/bash
while :
do
pscircle \
    --output=/tmp/pscircle.png \
    --background-color=f7c604FF \
    --tree-font-color=000000FF \
    --dot-color-min=000000FF \
    --dot-color-max=FFFFFFFF \
    --dot-border-width=0 \
    --link-color-min=000000FF \
    --link-color-max=FFFFFFFF \
    --toplists-font-color=000000FF \
    --toplists-pid-font-color=000000FF \
    --toplists-bar-background=FFFFFFFF \
    --toplists-bar-color=000000FF 

feh --bg-fill /tmp/pscircle.png
sleep 5
done
