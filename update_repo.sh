#!/bin/sh

# cd into the bundle and use relative paths
cd "$(dirname "$0")" || { echo 'Unable to cd into bundle directory; exiting.'; exit 1; }
[ -z "$HOME" ] && { echo "\$HOME is unset; exiting."; exit 1; }
[ -r "$HOME" ] || { echo "Unable to read files in \$HOME; exiting."; exit 1; }

cp "$HOME"/.shrc ./shrc
cp "$HOME"/.profile ./profile

if [ -f "$HOME"/.bashrc ]; then
    cp "$HOME"/.bashrc ./bashrc
    cp "$HOME"/.bash_profile ./bash_profile
    #cp "$HOME/.bash_logout" ./bash_logout
fi

config_dir=${XDG_CONFIG_HOME:-$HOME/.config}

if [ -f "$config_dir"/readline/inputrc ]; then
    cp "$config_dir"/readline/inputrc ./
elif [ -f "$HOME"/.inputrc ]; then
    cp "$HOME"/.inputrc ./inputrc
fi

if [ -f "$config_dir"/tmux/tmux.conf ]; then
    cp "$config_dir"/tmux/tmux.conf ./
elif [ -f "$HOME"/.tmux.conf ]; then
    cp "$HOME"/.tmux.conf ./tmux.conf
fi

if [ -d "$HOME"/.local/bin ]; then
    cp -r "$HOME"/.local/bin/. ./bin/
elif [ -d "$HOME"/.bin ]; then
    cp -r "$HOME"/.bin/. ./bin/
fi

if [ -d "$config_dir"/nvim ]; then
    cp -r "$config_dir"/nvim/. ./vim/
    if [ -e ./vim/pack ]; then rm ./vim/pack; fi
elif [ -d "$HOME"/.vim ]; then
    cp -r "$HOME"/.vim/. ./vim/
    rm -rf ./vim/pack
fi
