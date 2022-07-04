#!/bin/bash
while :
do
pscircle \
    --output=/tmp/pscircle.png \
    --background-color=000000ff \
    --tree-font-color=FF0000FF \
    --dot-color-min=600000FF \
    --dot-color-max=FF0000FF \
    --dot-border-width=0 \
    --link-color-min=400000FF \
    --link-color-max=AA0000FF \
    --toplists-font-color=FF0000FF \
    --toplists-pid-font-color=AA0000FF \
    --toplists-bar-background=200000FF \
    --toplists-bar-color=aa0000FF 

feh --bg-fill /tmp/pscircle.png
sleep 5
done
