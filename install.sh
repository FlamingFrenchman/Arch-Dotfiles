#!/bin/bash

cp ./vimrc ~/.vimrc
cp ./bashrc ~/.bashrc
cp -r ./polybar/* ~/.config/polybar

if [[ $(uname -n) == "overkill" ]]; then
    cp ./desktop-i3config ~/.config/i3/config
    cp ./desktop-kitty.conf ~/.config/kitty/kitty.conf
else
    cp ./laptop-i3config ~/.config/i3/config
    cp ./laptop-kitty.conf ~/.config/kitty/kitty.conf
fi

