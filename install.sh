#!/bin/sh

# cd into the bundle and use relative paths
cd "$(dirname $0)" || { echo "Unable to cd into bundle directory; exiting."; exit 1; }

# user must indicate whether they want the laptop configs or desktop configs
[ -z "$1" ] && echo "Platform (laptop/desktop) not specified; performing minimal install."

# literal dotfiles
cp ./vimrc ~/.vimrc
cp ./bashrc ~/.bashrc
cp ./bash_profile ~/.bash_profile
cp ./bash_logout ~/.bash_logout
cp ./bash_aliases ~/.bash_aliases
cp ./inputrc ~/.inputrc
cp ./tmux.conf ~/.tmux.conf
cp ./screenrc ~/.screenrc

# useful scripts
[-d ~/.bin ] || mkdir ~/.bin
cp ./scripts/* ~/.bin

# assume no X settings on a minimal install
[ -z "$1" ] && exit 0
cp ./xprofile ~/.xprofile
cp ./xsession ~/.xsession
cp ./xinitrc  ~/.xinitrc

# set up symlinks for neovim
[ -d ~/.config/nvim ] || mkdir -p ~/.config/nvim
[ -h ~/.config/nvim/init.vim ] || ln -s ~/.vimrc ~/.config/nvim/init.vim
[ -d ~/.vim ] || mkdir ~/.vim
[ -h ~/.local/share/nvim/site ] || ln -s ~/.vim ~/.local/share/nvim/site

# other stuff
[ -d ~/.config/wal/templates ] || mkdir -p ~/.config/wal/templates
cp ./wal/templates/colors-rofi-dark.rasi ~/.config/wal/templates/colors-rofi-dark.rasi
cp ./bork_referendum.jpg ~/Documents/
[ -d ~/.config/dunst ] || mkdir ~/.config/dunst
cp ./dunstrc ~/.config/dunst/dunstrc
cp ./dunstrc.in ~/.config/dunst/dunstrc.in

# i3
[ -d ~/.config/i3 ] || mkdir -p ~/.config/i3
if [ "$1" == "desktop" ]; then
    cp ./desktop-i3config ~/.config/i3/config
elif [ "$1" == "laptop" ]; then
    cp ./laptop-i3config ~/.config/i3/config
fi
cp -r ./scripts ~/.config/i3/
