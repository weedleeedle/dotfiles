#!/bin/bash

# This script interfaces with rofi to show the list of available passwords,
# including those in subdirectories. When a password is chosen it is copied to
# the clipboard. Shouldn't really be called by hand?
PASS_DIR=$HOME/.password-store/
# We need an external file to keep track of what directory we are "in"
STATE_FILE=/tmp/rofi_current_dir
CURRENT_DIR=$(<$STATE_FILE)

# If the supplied argument is the password file, execute and return nothing.
if [ -f "${PASS_DIR}${CURRENT_DIR}$1.gpg" ] ; then
    nohup clipctl disable && /usr/bin/pass show -c ${CURRENT_DIR}$1 > /dev/null 2>&1 ; clipctl enable &
    # Reset state file
    echo "" > "$STATE_FILE"
    exit 0
fi

# If we enter a directory, update the state file
if [ -d "${PASS_DIR}${CURENT_DIR}$1" ] ; then
    echo "${CURRENT_DIR}$1/" > "$STATE_FILE"
fi
# Otherwise we "auto complete"
results=$(/usr/bin/ls -1 $PASS_DIR$CURRENT_DIR$1 | sed "s/\.gpg$//")
echo "$results"

