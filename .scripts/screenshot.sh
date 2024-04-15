#!/bin/bash
# Automates the screenshot process. It takes a screenshot, stores it in the /tmp
# directory, then copies the screenshot to the clipboard.
# An optional -g argument takes a full screenshot, otherwise the user is
# prompted to select an area to screenshot.
if [ "$1" == -g ]
then
	escrotum -e 'mv $f /tmp/screenshot.png' 2>scroterror && 
	xclip -selection clipboard -target image/png -i /tmp/screenshot.png
else
	sleep 1
	escrotum -s -e 'mv $f /tmp/screenshot.png' 2>scroterror &&
	xclip -selection clipboard -target image/png -i /tmp/screenshot.png
fi
