# shellcheck shell=bash

if [[ -r "$HOME/.profile" ]]; then source "$HOME/.profile"; fi

# put histfile in state
export HISTFILE="$XDG_STATE_HOME/bash/history"

if [[ -r "$HOME/.bashrc" ]]; then source "$HOME/.bashrc"; fi
