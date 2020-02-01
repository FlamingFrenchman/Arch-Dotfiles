#!/bin/bash

# supposed to setup a completely clean environment on it's own on most distros
programs="bash tmux screen dunst neovim vim Thunar firejail alsa pulseaudio \
    rofi redshift nnn lesspipe i3-gaps htop neofetch conky"
st_patches="anysize boxdraw bold-is-not-bright alpha"

if which apt; then
    sudo apt install $programs
elif which yum; then
    sudo yum install $programs
elif which pacman; then
    sudo pacman -S $programs
else
fi
