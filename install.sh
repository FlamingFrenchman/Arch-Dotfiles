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
cp ./profile ~/.profile

# want keyboard and faster repeat
cp ./xprofile ~/.xprofile

# useful scripts in xdg-compliant location
[ -d $HOME/.local/bin ] || mkdir $HOME/.local/bin
cp -r ./bin/* $HOME/.local/bin

# no custom X sessions on minimal install
[ -z "$1" ] && exit 0
cp ./xsession ~/.xsession
cp ./xinitrc  ~/.xinitrc

# set up symlinks for neovim
[ -d ~/.config/nvim ] || mkdir -p ~/.config/nvim
[ -h ~/.config/nvim/init.vim ] || ln -s ~/.vimrc ~/.config/nvim/init.vim
[ -d ~/.vim ] || mkdir ~/.vim
[ -h ~/.local/share/nvim/site ] || ln -s ~/.vim ~/.local/share/nvim/site

# other stuff
cp -r ./wal ~/.config/
cp -r ./dunst ~/.config/
cp -r ./rofi ~/.config

# i3
[ -d ~/.config/i3 ] || mkdir -p ~/.config/i3
if [ "$1" = "desktop" ]; then
    #cp ./desktop-i3config ~/.config/i3/config
    :
elif [ "$1" = "laptop" ]; then
    cp -r ./i3 ~/.config/
    cp -r ./sway ~/.config/
fi
