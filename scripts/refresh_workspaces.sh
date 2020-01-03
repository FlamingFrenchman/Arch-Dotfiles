#!/bin/bash

# big stinky; fix asap
i3-msg -s "/run/user/$UID/i3/$(ls /run/user/$UID/i3/ | grep ipc-socket)" restart
termcount=$(ps aux | awk '/ st(( -e tmux)|( -e tmux attach))?$/ { print $0 }' | wc -l)
pkill -fx "st(( -e tmux)|( -e tmux attach))?$"
sleep 1s
notify-send -t 3000 -u low "Restarting terminal"
