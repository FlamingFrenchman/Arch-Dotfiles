#!/bin/bash

#killall -q battery_check.sh

#while pgrep -u $UID -x battery_check.sh >/dev/null; do sleep 1; done

while true; do 
    notify-send -t 3000 -u normal "Battery: $(cat \
/sys/class/power_supply/BAT0/capacity)%";
    sleep 30m;
done
