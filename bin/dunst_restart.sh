#!/bin/bash

killall -q dunst
while pgrep -u $UID -x dunst >/dev/null; do sleep 1; done
{ nohup dunst "$*" &>/dev/null & } &
exit 0
