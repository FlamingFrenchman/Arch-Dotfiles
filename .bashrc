#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Resize window after command, if necessary
shopt -s checkwinsize

# Define a few Colors
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m'              # No Color

# Prompts
#PS1='[\u@\h \W]\$ '

# Editor
export VISUAL=vim
export EDITOR=$VISUAL
export SUDO_EDITOR=vim

# flame dog
export BROWSER="firefox '%s' &"

# These may be in /etc/inputrc but just in case
# Currently the keyboard switch commands mess up the bindings
bind "Control-]:vi-movement-mode"
bind "Space:magic-space"

# Useful things
alias ls='ls -h --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias df='df -h'
alias dmesg='dmesg -H --color=always'

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

# stolen from stackoverflow and changed to my liking
function __setprompt {
  local SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
  local SSH2_IP=`echo $SSH2_CLIENT | awk '{ print $1 }'`
  if [ $SSH2_IP ] || [ $SSH_IP ] ; then
    local SSH_FLAG="@\h"
  fi
  PS1="$DARKGRAY[$LIGHTRED\$(date +%H:%M)$DARKGRAY][$RED\u$WHITE$SSH_FLAG:$LIGHTRED\w$DARKGRAY]$NC\\$ "
  PS2="$RED>$NC "
  PS4='$RED+$NC '
}

# Extract things. Thanks to urukrama, Ubuntuforums.org	
# I use unrar instead of rar
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       unrar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# Terminal emulator specific stuff
if [[ $TERM == xterm-kitty ]]; then
   # Fix ssh behavior caused by xterm-kitty
   export TERM=xterm

   # Quickly change keyboard
   # Currently breaks anything set with "bind" so avoid using if you like those
   alias pgkb='setxkbmap -layout us -variant dvp -option ctrl:swapcaps /
      -option ctrl:nocaps'
   alias dvkb='setxkbmap -layout us -variant dvorak -option ctrl:swapcaps /
      -option ctrl:nocaps'
   alias enkb='setxkbmap -layout us -option ctrl:swapcaps -option ctrl:nocaps'
   alias dfkb='setxkbmap -layout us'

   # needed for powerline
   powerline-daemon -q
   POWERLINE_BASH_CONTINUATION=1
   POWERLINE_BASH_SELECT=1
   . /usr/share/powerline/bindings/bash/powerline.sh
fi

# bash specific stuff
if [[ $TERM == linux ]]; then
   __setprompt
fi

# Clear screen after login
clear
