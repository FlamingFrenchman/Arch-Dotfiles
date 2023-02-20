#!/bin/sh

cd "$(dirname "$0")" || { echo "Unable to cd into bundle directory; exiting."; exit 1; }
BUNDLE_DIR=$(pwd)
cd "$HOME" || exit 1

# only pull in shell scripts that pass shellcheck
command -v shellcheck >/dev/null 2>&1 || {
    echo "Unable to locate shellcheck; exiting."
    exit 1
}
shellcheck "$HOME/.profile" "$HOME/.shrc" "$HOME/.bash_profile" "$HOME/.bashrc" || exit 1

# cd into the bundle and use relative paths
cd "$BUNDLE_DIR" || { echo "Unable to cd into bundle directory; exiting."; exit 1; }

# literal dotfiles
cp "$HOME/.bashrc" ./bashrc
cp "$HOME/.bash_profile" ./bash_profile
#cp "$HOME/.bash_logout" ./bash_logout
if [ -n "$INPUTRC" ] && [ -r "$INPUTRC" ]; then cp "$INPUTRC" ./inputrc
else cp "$HOME/.inputrc" ./inputrc
fi
cp "$HOME/.shrc" ./shrc
cp "$HOME/.profile" ./profile
if [ -n "$XDG_CONFIG_HOME" ] && [ -r "$XDG_CONFIG_HOME/tmux/tmux.conf" ]; then
    cp "$XDG_CONFIG_HOME/tmux/tmux.conf" ./tmux.conf
elif [ -r "$HOME/.config/tmux/tmux.conf" ]; then
    cp "$HOME/.config/tmux/tmux.conf" ./tmux.conf
elif [ -r "$HOME/.tmux.conf" ]; then cp "$HOME/.tmux.conf" ./tmux.conf
fi

# useful scripts in xdg-compliant directory
cp -r "$HOME"/.local/bin/* ./bin/

# vim/nvim
if command -v nvim >/dev/null 2>&1; then
    cp -r "$HOME"/.config/nvim/* ./vim/
    rm -rf vim/plugged vim/autoload
else
    cp -r "$HOME"/.vim/* ./vim/ && rm -rf vim/plugged vim/autoload
    cp "$HOME"/.vimrc ./vim/init.vim
fi
