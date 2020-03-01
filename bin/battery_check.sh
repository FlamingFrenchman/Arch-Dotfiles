#!/bin/bash

notify-send -t 3000 -u normal "Battery: $(cat /sys/class/power_supply/BAT0/capacity)%"
