# shellcheck shell=bash

if [[ -r "$HOME/.profile" ]]; then source "$HOME/.profile"; fi

# put histfile in state
if [[ -n "$XDG_STATE_HOME" ]]; then
    mkdir -p "$XDG_STATE_HOME/bash"
    export HISTFILE="$XDG_STATE_HOME/bash/history"
fi

if [[ -r "$HOME/.bashrc" ]]; then source "$HOME/.bashrc"; fi
