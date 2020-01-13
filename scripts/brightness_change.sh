#!/bin/bash

brightness_file="/tmp/redshift_brightness"
temperature_file="/tmp/redshift_temperature"

if ! [[ -f "$brightness_file" ]]; then
    echo "5500" > "$temperature_file"
    echo "80" > "$brightness_file"
fi

case $1 in
    bluen)
        newtemp=$(expr "$(cat $temperature_file)" + "$2")
        echo "$newtemp" > "$temperature_file"
        redshift -P -O "$(cat $temperature_file)" -b "0.$(cat $brightness_file)"
        ;;
    redden)
        newtemp=$(expr "$(cat $temperature_file)" - "$2")
        echo "$newtemp" > "$temperature_file"
        redshift -P -O "$(cat $temperature_file)" -b "0.$(cat $brightness_file)"
        ;;
    lighten)
        newbright=$(expr "$(cat $brightness_file)" + "$2")
        echo "$newbright" > "$brightness_file"
        redshift -P -O "$(cat $temperature_file)" -b "0.$(cat $brightness_file)"
        ;;
    darken)
        newbright=$(expr "$(cat $brightness_file)" - "$2")
        echo "$newbright" > "$brightness_file"
        redshift -P -O "$(cat $temperature_file)" -b "0.$(cat $brightness_file)"
        ;;
esac
