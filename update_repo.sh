#!/bin/sh

# cd into the bundle and use relative paths
cd "$(dirname "$0")" || { echo "Unable to cd into bundle directory; exiting."; exit 1; }

# literal dotfiles
cp ~/.bashrc ./bashrc
cp ~/.bash_profile ./bash_profile
cp ~/.bash_logout ./bash_logout
cp ~/.bash_aliases ./bash_aliases
cp ~/.inputrc ./inputrc
cp ~/.profile ./profile
cp ~/.tmux.conf ./tmux.conf

# vim/nvim
if command -v nvim >/dev/null 2>&1; then
    cp -r ~/.config/nvim/* ./vim/
    rm -rf vim/plugged vim/autoload
else
    cp ~/.vimrc ./vimrc
    cp -r ~/.vim/* ./vim/ && rm -rf vim/plugged vim/autoload
fi

# useful scripts in xdg-compliant directory
cp -r ~/.local/bin/* ./bin
