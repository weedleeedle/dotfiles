#!/bin/bash
# Retrieves all passwords and exports them to stdout. Intended to be piped into
# lpr for printing. Gpg is wack so may need to cache the password beforehand,
# idk.
# Also checks what the latest commit was for password git repo and stores it in
# the pass-last-commit file. password-check.sh uses this file to determine how
# many commits have been added since the last time this script was run
HASH_FILE=/home/viperzer0/.scripts/pass-last-commit
PASSWORD_DIR=/home/viperzer0/.password-store
cd $PASSWORD_DIR
for file in *; do
    if [ -f "$file" ]; then
        NAME=$(echo $file | sed "s/.gpg//")
        CONTENTS=$(gpg --quiet -d $file | awk '{ print "\t" $0 }')
        echo "$NAME"
        echo "$CONTENTS"
    fi
done

COMMIT_HASH=$(git rev-parse HEAD)
echo $COMMIT_HASH > $HASH_FILE



