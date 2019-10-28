#!/bin/bash

# cd into the bundle and use relative paths
cd "${BASH_SOURCE%/*}/" || { echo "Unable to cd into bundle directory; exiting"; exit; }

cp ./vimrc ~/.vimrc
cp ./bashrc ~/.bashrc
cp ./bash_profile ~/.bash_profile
cp ./bash_logout ~/.bash_logout
cp ./bash_aliases ~/.bash_aliases
cp ./inputrc ~/.inputrc
cp -r ./polybar ~/.config

if [[ $(uname -n) == "overkill" ]]; then
    cp ./desktop-i3config ~/.config/i3/config
else
    cp ./laptop-i3config ~/.config/i3/config
fi
