#!/bin/sh

# cd into the bundle and use relative paths
cd "$(dirname "$0")" || { echo "Unable to cd into bundle directory; exiting."; exit 1; }

# literal dotfiles
cp ~/.bashrc ./bashrc
cp ~/.bash_profile ./bash_profile
if [ -r "$HOME/.bash_logout" ]; then cp ~/.bash_logout ./bash_logout; fi
cp ~/.bash_aliases ./bash_aliases
if [ -r "$HOME/.inputrc" ]; then cp "$HOME/.inputrc" ./inputrc
elif [ -r "$INPUTRC" ]; then cp "$INPUTRC" ./inputrc
fi
cp ~/.profile ./profile
if [ -r "$HOME/.inputrc" ]; then cp "$HOME/.tmux.conf" ./tmux.conf
elif [ -r "$XDG_CONFIG_HOME/tmux/tmux.conf" ]; then cp "$XDG_CONFIG_HOME/tmux/tmux.conf" ./tmux.conf
elif [ -r "$HOME/.config/tmux/tmux.conf" ]; then cp "$HOME/.config/tmux/tmux.conf" ./tmux.conf
fi

# vim/nvim
if command -v nvim >/dev/null 2>&1; then
    cp -r ~/.config/nvim/* ./vim/
    rm -rf vim/plugged vim/autoload
else
    cp -r ~/.vim/* ./vim/ && rm -rf vim/plugged vim/autoload
    cp ~/.vimrc ./vim/init.vim
fi

# useful scripts in xdg-compliant directory
cp -r ~/.local/bin/* ./bin
