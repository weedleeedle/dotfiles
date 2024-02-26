#!/bin/bash
command="restic backup --verbose --exclude-caches=true --exclude-file /home/viperzer0/.dotfiles/backup-exclude /home/viperzer0 2>&1"
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
