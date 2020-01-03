#!/bin/bash

file="/home/robert/.config/dunst/dunstrc"

killall -q dunst
while pgrep -u $UID -x dunst >/dev/null; do sleep 1; done
cp "$file.in" "$file.tmp"

xrdb ~/.cache/wal/colors.Xresources
for i in {0..15}
do
    v=$(xrdb -query | awk '/\*\.color'"$i"':/ { print substr ($2, 2) }')
    eval "sed -i 's/%xresourcesc${i}%/\x22#${v}\x22/g' $file.tmp";
done

foreground=$(xrdb -query | awk '/\*\.foreground:/ { print substr ($2, 2) }')
background=$(xrdb -query | awk '/\*\.background:/ { print substr ($2, 2) }')
eval "sed -i 's/%xresourcesbg%/\x22#${background}\x22/g' $file.tmp"
eval "sed -i 's/%xresourcesfg%/\x22#${foreground}\x22/g' $file.tmp"

rm "$file"
mv "$file.tmp" "$file"
dunst &
notify-send -t 3000 -u low "Dunst restarted"
