#!/bin/sh

# cd into the bundle and use relative paths
cd "$(dirname $0)" || { echo "Unable to cd into bundle directory; exiting."; exit 1; }

# literal dotfiles
cp ./bashrc ~/.bashrc
cp ./bash_profile ~/.bash_profile
cp ./bash_logout ~/.bash_logout
cp ./bash_aliases ~/.bash_aliases
cp ./inputrc ~/.inputrc
cp ./octaverc ~/.octaverc
cp ./profile ~/.profile
cp ./screenrc ~/.screenrc
cp ./tmux.conf ~/.tmux.conf
cp ./vimrc ~/.vimrc
cp -r ./vim ~/.vim

# useful scripts in xdg compliant location
[ -d "$HOME/.local/bin" ] || mkdir "$HOME/.local/bin"
cp -r ./bin/* $HOME/.local/bin

# set up symlinks for neovim
if command -v nvim >/dev/null 2>&1 ; then
    [ -d ~/.config/nvim ] || mkdir -p ~/.config/nvim
    [ -h ~/.config/nvim/init.vim ] || ln -s ~/.vimrc ~/.config/nvim/init.vim
    [ -d ~/.vim ] || mkdir ~/.vim
    [ -h ~/.local/share/nvim/site ] || ln -s ~/.vim ~/.local/share/nvim/site
fi
