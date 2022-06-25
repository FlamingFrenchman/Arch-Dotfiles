#!/bin/sh

# cd into the bundle and use relative paths
cd "$(dirname "$0")" || { echo "Unable to cd into bundle directory; exiting."; exit 1; }

# source variables in case this is a fresh install
. ./profile

# literal dotfiles
cp ./bashrc "$HOME/.bashrc"
cp ./bash_profile "$HOME/.bash_profile"
#cp ./bash_logout "$HOME/.bash_logout"
cp ./bash_aliases "$HOME/.bash_aliases"
if [ -n "$INPUTRC" ]; then
    [ -d "$(dirname "$INPUTRC")" ] || mkdir -p "$(dirname "$INPUTRC")"
    cp ./inputrc "$INPUTRC"
else cp ./inputrc "$HOME/.inputrc"
fi
cp ./profile "$HOME/.profile"
if [ -r "$HOME/.tmux.conf" ]; then
    cp ./tmux.conf "$HOME/.tmux.conf"
elif [ -n "$XDG_CONFIG_HOME" ]; then
    [ -d "$XDG_CONFIG_HOME/tmux" ] || mkdir "$XDG_CONFIG_HOME/tmux"
    cp ./tmux.conf "$XDG_CONFIG_HOME/tmux/tmux.conf"
else
    [ -d "$HOME/.config/tmux" ] || mkdir "$HOME/.config/tmux"
    cp ./tmux.conf "$HOME/.config/tmux/tmux.conf"
fi

# useful scripts in xdg compliant location
[ -d "$HOME/.local/bin" ] || mkdir "$HOME/.local/bin"
cp -r ./bin/* "$HOME/.local/bin/"

# vim/nvim
if command -v nvim >/dev/null 2>&1 ; then
    [ -d ~/.config/nvim ] || mkdir ~/.config/nvim
    cp -r ./vim/* ~/.config/nvim/
else 
    cp -r ./vim ~/.vim
    cp ./vim/init.vim ~/.vimrc
fi
