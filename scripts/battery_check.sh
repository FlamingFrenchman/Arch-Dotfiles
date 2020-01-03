#!/bin/bash

while true; do 
    notify-send -t 3000 -u normal "Battery: $(cat \
/sys/class/power_supply/BAT0/capacity)%";
    sleep 30m;
done
