#!/bin/bash

# cd into the bundle and use relative paths
cd "${BASH_SOURCE%/*}/" || { echo "Unable to cd into bundle directory; exiting"; exit; }

cp ~/.vimrc ./vimrc
cp ~/.bashrc ./bashrc
cp ~/.bash_profile ./bash_profile
cp ~/.bash_logout ./bash_logout
cp ~/.bash_aliases ./bash_aliases
cp ~/.inputrc ./inputrc
cp -r ~/.config/polybar .

if [[ $(uname -n) == "overkill" ]]; then
    cp ~/.config/i3/config ./desktop-i3config
else
    cp ~/.config/i3/config ./laptop-i3config
fi
