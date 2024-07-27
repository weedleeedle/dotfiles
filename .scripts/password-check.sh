#!/bin/bash
# Checks how many commits have been made since the last password export.
# Uses the pass-last-commit file, which is set by password-export.sh on export.
PASS_DIR=/home/viperzer0/.password-store/
cd $PASS_DIR
HASH_FILE=/home/viperzer0/.scripts/pass-last-commit
COMMIT_HASH=$(cat $HASH_FILE)
NUM_COMMITS=$(git rev-list $COMMIT_HASH..HEAD | wc -l)
echo $NUM_COMMITS
