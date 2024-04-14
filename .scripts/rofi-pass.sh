#!/bin/bash

# This script interfaces with rofi to show the list of available passwords,
# including those in subdirectories. When a password is chosen it is copied to
# the clipboard. Shouldn't really be called by hand?
PASS_DIR=$HOME/.password-store/

# If there is an argument, execute password retrieval and return nothing.
if [ $# -eq 1 ] ; then
    nohup sh -c "clipctl disable && /usr/bin/pass show -c $1 ; clipctl enable" > /dev/null 2>&1  &
    exit 0
fi

# If there is no argument, list all the available passwords
if [ $# -eq 0 ] ; then
    find $PASS_DIR -name "*.gpg" -printf "%P\n" | sed "s/.gpg$//"
fi
