#!/bin/bash

read -p 'Account:' uservar
read -sp 'Password: ' passvar
echo

gpg -d --batch --passphrase "$passvar" ~/.config/6cord/"$uservar".token | xargs 6cord -t

