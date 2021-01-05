#
# ~/.bashrc
#
# I like my .bashrc file

# /bin/bash
#       The bash executable
# /etc/profile
#       The systemwide initialization file, executed for login shells
# /etc/bash.bashrc
#       The systemwide per-interactive-shell bash startup file
# ~/.bash_profile and ~/.profile
#       The personal initialization file, executed for login shells
# ~/.bashrc
#       The individual per-interactive-shell bash startup file
# ~/.bash_logout
#       The individual login shell cleanup file, executed when a login shell exits
# ~/.inputrc
#       Individual readline initialization file (for anything readline-based)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source aliases
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Source readline settings
[[ -f ~/.inputrc ]] && bind -f ~/.inputrc

# resize window after command, if necessary
shopt -s checkwinsize

# append history to $HISTFILE on exit instead of overwriting it
shopt -s histappend

# expand directory paths when completing
shopt -s direxpand

# function to call to generate command
export PROMPT_COMMAND=prompt
