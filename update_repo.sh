#!/bin/sh

# cd into the bundle and use relative paths
cd "$(dirname $0)" || { echo "Unable to cd into bundle directory; exiting."; exit 1; }

# literal dotfiles
cp ~/.bashrc ./bashrc
cp ~/.bash_profile ./bash_profile
cp ~/.bash_logout ./bash_logout
cp ~/.bash_aliases ./bash_aliases
cp ~/.inputrc ./inputrc
cp ~/.octaverc ./octaverc
cp ~/.profile ./profile
cp ~/.screenrc ./screenrc
cp ~/.tmux.conf ./tmux.conf
cp ~/.vimrc ./vimrc
cp ~/.xprofile ./xprofile

# useful scripts in xdg-compliant directory
cp -r ~/.local/bin/* ./bin
