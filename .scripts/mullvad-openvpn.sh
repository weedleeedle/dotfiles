#!/bin/bash

# Script for connecting to Mullvad VPN. 
# There's two processes that run, so this opens a tmux session and splits the
# window so both display side-by-side.
tmux new-session -d -s MullvadVPN -n ShadowSocks -d "ss-local -s 198.54.131.178 -p 443 -l 1080 -k mullvad -m aes-256-gcm"
tmux split-window -v -t MullvadVPN:0 "openvpn --config /etc/openvpn/mullvad_us_sea.conf"
tmux set remain-on-exit on

tmux select-layout -t MullvadVPN:0 tiled

tmux attach-session -t MullvadVPN

