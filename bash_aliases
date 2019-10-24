#
# ~/.bash_aliases
#

# Define a few Colors
BLACK='\[\e[0;30m\]'
BLUE='\[\e[0;34m\]'
GREEN='\[\e[0;32m\]'
CYAN='\[\e[0;36m\]'
RED='\[\e[0;31m\]'
PURPLE='\[\e[0;35m\]'
BROWN='\[\e[0;33m\]'
LIGHTGRAY='\[\e[0;37m\]'
DARKGRAY='\[\e[1;30m\]'
LIGHTBLUE='\[\e[1;34m\]'
LIGHTGREEN='\[\e[1;32m\]'
LIGHTCYAN='\[\e[1;36m\]'
LIGHTRED='\[\e[1;31m\]'
LIGHTPURPLE='\[\e[1;35m\]'
YELLOW='\[\e[1;33m\]'
WHITE='\[\e[1;37m\]'
NC='\[\e[0m\]'

# Useful things
alias ls='ls -h --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias df='df -h'
alias dmesg='dmesg -H --color=always'
alias admin='sudo -i -u admin'
alias devel='sudo -i -u devel'

# Force myself to use the good shit
alias kim='nvim'
alias vi='nvim'

# stolen from stackoverflow and changed to my liking
setprompt () {
  local SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
  local SSH2_IP=`echo $SSH2_CLIENT | awk '{ print $1 }'`
  if [ $SSH2_IP ] || [ $SSH_IP ] ; then
    local SSH_FLAG="@\h"
  fi
  PS1="$BLACK[$RED\u$WHITE$SSH_FLAG:$LIGHTRED\w$BLACK]$WHITE\\$ $NC"
  PS2="$RED>$NC "
  PS4='$RED+$NC '
}

setprompt_long () {
  local SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
  local SSH2_IP=`echo $SSH2_CLIENT | awk '{ print $1 }'`
  if [ $SSH2_IP ] || [ $SSH_IP ] ; then
    local SSH_FLAG="@\h"
  fi
  PS1="$DARKGRAY[$LIGHTRED\$(date +%H:%M)$DARKGRAY]\
[$RED\u$WHITE$SSH_FLAG:$LIGHTRED\w$DARKGRAY]$WHITE\\$ $NC"
  PS2="$RED>$NC "
  PS4='$RED+$NC '
}

# Extract things. Thanks to urukrama, ubuntuforums.org	
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

# From apmcd47 on ubuntuforums, and the guy that actually
# wrote it and gave it to him
vipath () { 
    declare TFILE=/tmp/path.$LOGNAME.$$;
    echo $PATH | sed 's/^:/.:/;s/:$/:./' | sed 's/::/:.:/g' | tr ':' '\012' > $TFILE;
    vi $TFILE;
    PATH=`awk ' { if (NR>1) printf ":"
      printf "%s",$1 }' $TFILE`;
    rm -f $TFILE;
    echo $PATH
}  
