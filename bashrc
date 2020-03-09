#
# ~/.bashrc
#
# I like my .bashrc file

# /bin/bash
#       The bash executable
# /etc/profile
#       The systemwide initialization file, executed for login shells
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

# Source profile
[[ -f ~/.profile ]] && . ~/.profile

# Source aliases
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Source readline settings
[[ -f ~/.inputrc ]] && bind -f ~/.inputrc

# Resize window after command, if necessary
shopt -s checkwinsize
# append history to $HISTFILE on exit instead of overwriting it
shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe.sh ]] && { \
    export LESSOPEN="|lesspipe.sh %s"; \
    eval "$(lesspipe.sh)"; \
}

# prep for ssh
# on arch I am using systemd/user to start instead
#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#  ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
#fi
#if [[ ! "$SSH_AUTH_SOCK" ]]; then
#  eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
#fi

# function to call to generate command
PS1="";
PROMPT_COMMAND=prompt
