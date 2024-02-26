#!/bin/bash
# I don't think this program is actually being used by cmus? 
# Cmus generates its own notifications.
# Will probably remove this file.
./.cmus/post-fm "$@" &
cmus_notify --title "Now playing: {title} by {artist}" --body "$(printf "<b>Album:</b> {album}\n<b>Duration:</b> {duration}")" "$*" &
