#!/bin/bash

# cd into the bundle and use relative paths
cd "${BASH_SOURCE%/*}/" || { echo "Unable to cd into bundle directory; exiting"; exit; }

cp ~/.vimrc ./vimrc
cp ~/.bashrc ./bashrc
cp -r ~/.config/polybar/* ./polybar

if [[ $(uname -n) == "overkill" ]]; then
    cp ~/.config/i3/config ./desktop-i3config
    cp ~/.config/kitty/kitty.conf ./desktop-kitty.conf
else
    cp ~/.config/i3/config ./laptop-i3config
    cp ~/.config/kitty/kitty.conf ./laptop-kitty.conf
fi
