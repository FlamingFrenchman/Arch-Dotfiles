#!/bin/bash

# supposed to setup a completely clean environment on it's own on most distros

if which apt; then
elif which yum; then
elif which pacman; then
    sudo pacman -S i3-gaps tmux feh python-pywal vim firefox conky dunst htop neofetch rofi
else
fi
