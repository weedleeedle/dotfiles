#!/bin/bash
./.cmus/post-fm "$@" &
cmus_notify --title "Now playing: {title} by {artist}" --body "$(printf "<b>Album:</b> {album}\n<b>Duration:</b> {duration}")" "$*" &
