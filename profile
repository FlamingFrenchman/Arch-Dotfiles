# PATH
export PATH="$PATH:$HOME/.local/bin:$HOME/.bin:$HOME/.gem/ruby/2.7.0/bin"

# Editor
export EDITOR=vim
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR
which nvim &>/dev/null && { \
    export EDITOR=nvim; \
    export VISUAL=$EDITOR; \
    export SUDO_EDITOR=$EDITOR; \
}

# colorful less
# raw escape sequences are not portable between shells
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# rcon
export MCRCON_PROMPT='> '
