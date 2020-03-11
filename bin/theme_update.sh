#!/bin/bash

gsettings set guake.style.font palette-name 'Custom'
gsettings set guake.style.font palette $(cat ~/.cache/wal/colors-guake)
cp ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/config.rasi
cp ~/.cache/wal/colors.Xresources ~/.Xresources
cp ~/.cache/wal/colors-dunstrc ~/.config/dunst/dunstrc
pgrep guake &>/dev/null || { nohup guake &>/dev/null & } &
xrdb -merge ~/.Xresources
~/.bin/dunst_restart.sh
