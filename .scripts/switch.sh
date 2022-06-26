#!/bin/bash
S1=$(ip n show | grep 3c:90:66:71:0f:e8 | grep PERMANENT)
if [ -z "$S1" ]; then
	echo "Bypass Activ8"
	ip n change dev wlp2s0 to 192.168.1.1 lladdr 3C:90:66:71:0F:E8
    ip n flush dev wlp2s0
else 
	echo "Conforming to System."
    ip n del dev wlp2s0 to 192.168.1.1
    ip n flush dev wlp2s0
fi
