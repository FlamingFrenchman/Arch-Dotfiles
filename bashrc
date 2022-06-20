#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source aliases
if [[ -r "$HOME/.bash_aliases" ]]; then source "$HOME/.bash_aliases"; fi

# resize window after command, if necessary
shopt -s checkwinsize

# append history to $HISTFILE on exit instead of overwriting it
shopt -s histappend

# expand directory paths when completing
shopt -s direxpand
