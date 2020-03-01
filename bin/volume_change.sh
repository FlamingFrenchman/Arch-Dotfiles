#!/bin/bash

case $1 in 
    toggle)
        # default sink toggle mute
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        # notify
        default_sink=$(pactl info | grep "Default Sink:" | awk '{ print $3 }')
        default_vol=$(pactl list sinks | awk '{ \
            if($1 == "Name:") { sink=$2 } \
            if($1 == "Mute:" && sink == "'"$default_sink"'") { print $2 } \
        }')
        notify-send -t 500 -u normal "Mute: $default_vol"
        ;;
    up)
        # default sink volume up
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        # notify
        default_sink=$(pactl info | grep "Default Sink:" | awk '{ print $3 }')
        default_vol=$(pactl list sinks | awk '{ \
            if($1 == "Name:") { sink=$2 } \
            if($1 == "Volume:" && sink == "'"$default_sink"'") { print $5 } \
        }')
        notify-send -t 500 -u normal "Volume: $default_vol"
        ;;
    down)
        # default sink volume down
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        # notify
        default_sink=$(pactl info | grep "Default Sink:" | awk '{ print $3 }')
        default_vol=$(pactl list sinks | awk '{ \
            if($1 == "Name:") { sink=$2 } \
            if($1 == "Volume:" && sink == "'"$default_sink"'") { print $5 } \
        }')
        notify-send -t 500 -u normal "Volume: $default_vol"
        ;;
    cycle)
        # figure out and increment default sink index
        num_sinks=$(expr $(pactl list sinks short | tail -n 1 | awk '{ print $1 }') + 1)
        sinks=($(pactl list sinks short | awk '{ printf "%s ",$1 }'))
        default_sink=$(pactl info | awk '/Default Sink:/ { print $3 }')
        default_index=$(pactl list sinks short | awk '/'"$default_sink"'/ { print $1 }')
        for i in ${!sinks[@]}; do
            [ ${sinks[$i]} -eq $default_index ] && {
                default_index=${sinks[$(expr $(expr $i + 1) % $num_sinks)]}; break;
            }
        done
        default_sink=$(pactl list sinks short | awk '{ if($1 == "'"$default_index"'") \
            { print $2 } }')
        pactl set-default-sink $default_index
        # notify
        notify-send -t 500 -u normal "Set default sink to $default_sink"
        ;;
esac
