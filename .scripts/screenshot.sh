#!/bin/bash
if [ "$1" == -g ]
then
	scrot -e 'mv $f /tmp/screenshot.png' 2>scroterror
	xclip -selection clipboard -target image/png -i /tmp/screenshot.png
else
	sleep 1
	scrot -s -e 'mv $f /tmp/screenshot.png' 2>scroterror
	xclip -selection clipboard -target image/png -i /tmp/screenshot.png
fi
