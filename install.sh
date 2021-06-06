#!/bin/sh

# cd into the bundle and use relative paths
cd "$(dirname "$0")" || { echo "Unable to cd into bundle directory; exiting."; exit 1; }

# literal dotfiles
cp ./bashrc ~/.bashrc
cp ./bash_profile ~/.bash_profile
cp ./bash_logout ~/.bash_logout
cp ./bash_aliases ~/.bash_aliases
cp ./inputrc ~/.inputrc
cp ./profile ~/.profile
cp ./tmux.conf ~/.tmux.conf

# useful scripts in xdg compliant location
[ -d "$HOME/.local/bin" ] || mkdir "$HOME/.local/bin"
cp -r ./bin/* ~/.local/bin

# vim/nvim
if command -v nvim >/dev/null 2>&1 ; then
    [ -d ~/.config/nvim ] || mkdir ~/.config/nvim
    cp -r ./vim/* ~/.config/nvim/
else 
    cp -r ./vim ~/.vim
    cp ./vim/init.vim ~/.vimrc
fi
