#!/bin/bash

# cd into the bundle and use relative paths
cd "${BASH_SOURCE%/*}/" || { echo "Unable to cd into bundle directory; exiting"; exit; }

# user must indicate whether they want the laptop configs or desktop configs
[[ -z "$1" ]] && echo "If you would like to update laptop/desktop configs, \
please indicate which one."

cp ~/.vimrc ./vimrc
cp ~/.bashrc ./bashrc
cp ~/.bash_profile ./bash_profile
cp ~/.bash_logout ./bash_logout
cp ~/.bash_aliases ./bash_aliases
cp ~/.inputrc ./inputrc
cp ~/.tmux.conf ./tmux.conf

# assume no xprofile on a minimal update
[ -z "$1" ] && exit 0
cp ~/.xprofile ./xprofile

cp ~/.config/wal/templates/colors-rofi-dark.rasi ./wal/templates/colors-rofi-dark.rasi
cp ~/.config/dunst/dunstrc ./dunstrc
cp ~/.config/dunst/dunstrc.in ./dunstrc.in
#cp -r ~/.config/polybar .

if [[ "$1" == "desktop" ]]; then
    cp ~/.config/i3/config ./desktop-i3config;
elif [[ "$1" == "laptop" ]]; then
    cp ~/.config/i3/config ./laptop-i3config;
    cp -r ~/.config/i3/scripts ./
fi
