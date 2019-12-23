#!/usr/bin/env bash

last_state=0

disconnected=""
wireless_connected=""
ethernet_connected=""

ID="$(ip link | awk '/state UP/ {print $2}')"
network_name="$(iw dev $1 link | awk '$1 == "SSID:" {print $2}')"

while true; do
    if (ping -c 1 archlinux.org || ping -c 1 google.com || ping -c 1 bitbucket.org || ping -c 1 github.com || ping -c 1 sourceforge.net) &>/dev/null; then
        if [[ $ID == e* ]] && [[ $last_state == 0 ]]; then
            notify-send -t 3000 -u low "$ID"; last_state=1; sleep 30
        elif [[ $last_state == 0 ]]; then
            notify-send -t 3000 -u low "$wireless_connected $network_name" ; last_state=1; sleep 30
        else
            sleep 60
        fi
    elif [[ $last_state == 1 ]]; then
        notify-send -t 3000 -u low "$disconnected"; last_state=0 sleep 30;
    else
        sleep 30
    fi
done
