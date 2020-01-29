#
# ~/.bashrc
#
# I like my .bashrc file

#/bin/bash
#       The bash executable
#/etc/profile
#       The systemwide initialization file, executed for login shells
#~/.bash_profile
#       The personal initialization file, executed for login shells
#~/.bashrc
#       The individual per-interactive-shell startup file
#~/.bash_logout
#       The individual login shell cleanup file, executed when a login shell exits
#~/.inputrc
#       Individual readline initialization file (for anything readline-based)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source aliases
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Source readline settings
[[ -f ~/.inputrc ]] && bind -f ~/.inputrc

# Resize window after command, if necessary
shopt -s checkwinsize
# append history to $HISTFILE on exit instead of overwriting it
shopt -s histappend

# Editor
export EDITOR=vim
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR
which --skip-alias nvim &>/dev/null && { \
    export EDITOR=nvim; \
    export VISUAL=$EDITOR; \
    export SUDO_EDITOR=$EDITOR; \
}

# Colorful less
# Reminder that raw escape sequences are not portable between shells
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# make less more friendly for non-text input files, see lesspipe(1)
export LESSOPEN="|lesspipe.sh %s"
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# prep for ssh
# on arch I am using systemd/user to start instead
#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#  ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
#fi
#if [[ ! "$SSH_AUTH_SOCK" ]]; then
#  eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
#fi

# bash specific stuff
if [[ $TERM == linux ]]; then
   # set prompt once, manually
   prompt_long;
   PROMPT_COMMAND=""
else
   # function to call to generate command
   PS1="";
   PROMPT_COMMAND=prompt_short
fi
