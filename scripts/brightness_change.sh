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
        redshift -P -O "$(cat $temperature_file)" -b "0.$(cat $brightness_file)"
        notify-send -t 1000 -u low 'Color Temp: '"$newtemp"'K'
        ;;
    redden)
        newtemp=$(expr "$(cat $temperature_file)" - "$2")
        if [[ $newtemp -lt 1000 ]]; then newtemp=1000; fi
        echo "$newtemp" > "$temperature_file"
        redshift -P -O "$(cat $temperature_file)" -b "0.$(cat $brightness_file)"
        notify-send -t 1000 -u low 'Color Temp: '"$newtemp"'K'
        ;;
    lighten)
        newbright=$(expr "$(cat $brightness_file)" + "$2")
        if [[ $newbright -gt 100 ]]; then newbright=100; fi
        echo "$newbright" > "$brightness_file"
        if [[ $newbright -eq 100 ]]; then
            redshift -P -O "$(cat $temperature_file)" -b "$(cat $brightness_file)"
            notify-send -t 1000 -u low 'Brightness: '"$newbright"
        else
            redshift -P -O "$(cat $temperature_file)" -b "0.$(cat $brightness_file)"
            notify-send -t 1000 -u low 'Brightness: 0.'"$newbright"
        fi
        ;;
    darken)
        newbright=$(expr "$(cat $brightness_file)" - "$2")
        if [[ $newbright -lt 10 ]]; then newbright=10; fi
        echo "$newbright" > "$brightness_file"
        redshift -P -O "$(cat $temperature_file)" -b "0.$(cat $brightness_file)"
        notify-send -t 1000 -u low 'Brightness: 0.'"$newbright"
        ;;
esac
