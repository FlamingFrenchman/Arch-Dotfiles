#!/bin/bash

brightness_file="/tmp/redshift_brightness"
temperature_file="/tmp/redshift_temperature"

if ! [[ -f "$brightness_file" ]]; then
    echo "5500" > "$temperature_file"
    echo "80" > "$brightness_file"
elif ! [[ -r "$brightness_file" ]]; then
    exit 1
elif ! [[ -w "$brightness_file" ]]; then
    exit 1
fi

case $1 in
    bluen)
        newtemp=$(expr "$(cat $temperature_file)" + "$2")
        if [[ $newtemp -gt 6500 ]]; then newtemp=6500; fi
        echo "$newtemp" > "$temperature_file"
        brightness="$(cat $brightness_file)"
        if [[ $brightness -lt 100 ]]; then brightness="0.$brightness"; fi
        redshift -P -O "$(cat $temperature_file)" -b "$brightness"
        notify-send -t 500 -u low 'Color Temp: '"$newtemp"'K'
        ;;
    redden)
        newtemp=$(expr "$(cat $temperature_file)" - "$2")
        if [[ $newtemp -lt 1000 ]]; then newtemp=1000; fi
        echo "$newtemp" > "$temperature_file"
        brightness="$(cat $brightness_file)"
        if [[ $brightness -lt 100 ]]; then brightness="0.$brightness"; fi
        redshift -P -O "$(cat $temperature_file)" -b "$brightness"
        notify-send -t 500 -u low 'Color Temp: '"$newtemp"'K'
        ;;
    lighten)
        newbright=$(expr "$(cat $brightness_file)" + "$2")
        if [[ $newbright -gt 100 ]]; then newbright=100; fi
        echo "$newbright" > "$brightness_file"
        brightness="$(cat $brightness_file)"
        if [[ $brightness -lt 100 ]]; then brightness="0.$brightness"; fi
        redshift -P -O "$(cat $temperature_file)" -b "$brightness"
        notify-send -t 500 -u low 'Brightness: '"$newbright%"
        ;;
    darken)
        newbright=$(expr "$(cat $brightness_file)" - "$2")
        if [[ $newbright -lt 10 ]]; then newbright=10; fi
        echo "$newbright" > "$brightness_file"
        brightness="$(cat $brightness_file)"
        if [[ $brightness -lt 100 ]]; then brightness="0.$brightness"; fi
        redshift -P -O "$(cat $temperature_file)" -b "$brightness"
        notify-send -t 500 -u low "Brightness: $newbright%"
        ;;
esac
