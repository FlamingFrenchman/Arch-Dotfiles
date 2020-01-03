#!/bin/bash

# cd into the bundle and use relative paths
cd "${BASH_SOURCE%/*}/" || { echo "Unable to cd into bundle directory; exiting"; exit; }

# user must indicate whether they want the laptop configs or desktop configs
[ -z "$1" ] && { echo "Please indicate whether you wish to install the laptop or \
desktop version of the config files."; exit; }

# literal dotfiles
cp ./vimrc ~/.vimrc
cp ./bashrc ~/.bashrc
cp ./bash_profile ~/.bash_profile
cp ./bash_logout ~/.bash_logout
cp ./bash_aliases ~/.bash_aliases
cp ./inputrc ~/.inputrc
cp ./tmux.conf ~/.tmux.conf
cp ./xprofile ~/.xprofile

# set up symlinks for neovim
[[ -f ~/.config/nvim ]] || mkdir -p ~/.config/nvim
[[ -f ~/.config/nvim/init.vim ]] || ln -s ~/.vimrc ~/.config/nvim/init.vim
[[ -f ~/.vim ]] || mkdir ~/.vim
[[ -f ~/.local/share/nvim/site ]] && rm -rf ~/.local/share/nvim/site
ln -s ~/.vim ~/.local/share/nvim/site

# other stuff
cp ./wal/templates/colors-rofi-dark.rasi ~/.config/wal/templates/colors-rofi-dark.rasi
cp ./bork_referendum ~/Documents/
[[ -f ~/.config/dunst ]] || mkdir -p ~/.config/dunst
cp ./dunstrc ~/.config/dunst/dunstrc
#cp -r ./polybar ~/.config

[[ -f ~/.config/i3 ]] || mkdir -p ~/.config/i3
if [[ "$1" == "desktop" ]]; then
    cp ./desktop-i3config ~/.config/i3/config
elif [[ "$1" == "laptop" ]]; then
    cp ./laptop-i3config ~/.config/i3/config
fi
