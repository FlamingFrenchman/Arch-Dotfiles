#!/bin/bash

# cd into the bundle and use relative paths
cd "${BASH_SOURCE%/*}/" || { echo "Unable to cd into bundle directory; exiting"; exit; }

# user must indicate whether they want the laptop configs or desktop configs
[[ -z "$1" ]] && { echo "Please indicate whether you are updating the laptop or \
desktop version of the config files."; exit; }

cp ~/.vimrc ./vimrc
cp ~/.bashrc ./bashrc
cp ~/.bash_profile ./bash_profile
cp ~/.bash_logout ./bash_logout
cp ~/.bash_aliases ./bash_aliases
cp ~/.inputrc ./inputrc
cp ~/.tmux.conf ./tmux.conf
cp ~/.xprofile ./xprofile

cp ~/.config/wal/templates/colors-rofi-dark.rasi ./wal/templates/colors-rofi-dark.rasi
cp ~/.config/dunst/dunstrc ./dunstrc
#cp -r ~/.config/polybar .

if [[ "$1" == "desktop" ]]; then
    cp ~/.config/i3/config ./desktop-i3config;
elif [[ "$1" == "laptop" ]]; then
    cp ~/.config/i3/config ./laptop-i3config;
fi
