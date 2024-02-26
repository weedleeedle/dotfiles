#!/bin/bash

# This script executes a backup of the home directory (using restic, hardcoded)
# and then emails $NOTIFY_EMAIL_ADDRESS with the results of the backup.
# It excludes anything matching the patterns found in
# $HOME/.dotfiles/backup-exclude and any folders marked as caches.
command="restic backup --verbose --exclude-caches=true --exclude-file $HOME/.dotfiles/backup-exclude $HOME 2>&1"
output=$(eval "${command}")
result=$?

message="
----------------Restic Backup Report-----------------------
$(date)
"

if [[ $result != 0 ]]; then
    message="${message}
------------------------------------
BACKUP FAILED!! See output below.
------------------------------------
"
    subject="Backup FAILED---$(date)"
else
    message="${message}
------------------------------------
Backup SUCCEEDED.
------------------------------------
"
    subject="Backup successful---$(date)"
fi

message="${message}
\$ ${command}
${output}
"

echo "Subject: ${subject}"
echo "Message: ${message}"

echo "${message}" | mailx --subject "${subject}" $NOTIFY_EMAIL_ADDRESS
