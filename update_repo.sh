#!/bin/sh

# cd into the bundle and use relative paths
cd "$(dirname $0)" || { echo "Unable to cd into bundle directory; exiting."; exit 1; }

# user must indicate whether they want the laptop configs or desktop configs
[ -z "$1" ] && echo "Platform (laptop/desktop) not specified; performing minimal update."

# literal dotfiles
cp ~/.vimrc ./vimrc
cp ~/.bashrc ./bashrc
cp ~/.bash_profile ./bash_profile
cp ~/.bash_logout ./bash_logout
cp ~/.bash_aliases ./bash_aliases
cp ~/.inputrc ./inputrc
cp ~/.tmux.conf ./tmux.conf
cp ~/.screenrc ./screenrc
cp ~/.xprofile ./xprofile

# useful scripts
cp -r ~/.bin/* ./bin

[ -z "$1" ] && exit 0
cp ~/.xsession ./xsession
cp ~/.xinitrc  ./xinitrc

cp -r ~/.config/wal ./
cp -r ~/.config/dunst ./

if [ "$1" == "desktop" ]; then
    cp ~/.config/i3/config ./desktop-i3config;
elif [ "$1" == "laptop" ]; then
    cp ~/.config/i3/config ./laptop-i3config;
fi
