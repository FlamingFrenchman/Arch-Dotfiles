#
# ~/.profile
#

# PATH
export PATH="$PATH:$HOME/.local/bin:$HOME/.gem/ruby/2.7.0/bin"

# editor
if command -v nvim >/dev/null 2>&1 ; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR

# xdg
command -v xdg_user_dir >/dev/null 2>&1  && {
    XDG_CONFIG_HOME=$(xdg_user_dir)
    XDG_CONFIG_DOCUMENTS=$(xdg_user_dir DOWNLOADS)
    XDG_CONFIG_DOWNLOADS=$(xdg_user_dir DOCUMENTS)
    export XDG_CONFIG_HOME
    export XDG_CONFIG_DOCUMENTS
    export XDG_CONFIG_DOWNLOADS
}

# nnn
command -v nnn >/dev/null 2>&1  && {
    export NNN_USE_EDITOR=1
    export NNN_BMS="d:${XDG_CONFIG_DOCUMENTS:-$HOME/Documents};D:${XDG_CONFIG_DOWNLOADS:-$HOME/Downloads};h:${XDG_CONFIG_HOME:-$HOME}"
}

# colorful less
# Note: raw escape sequences are not portable between shells
LESS=-R                                  # raw color escape sequences
export LESS
LESS_TERMCAP_mb=$(printf '\e[1;31m')     # begin blink
export LESS_TERMCAP_mb
LESS_TERMCAP_md=$(printf '\e[1;36m')     # begin bold
export LESS_TERMCAP_md
LESS_TERMCAP_me=$(printf '\e[0m')        # reset bold/blink
export LESS_TERMCAP_me
LESS_TERMCAP_so=$(printf '\e[01;44;33m') # begin reverse video
export LESS_TERMCAP_so
LESS_TERMCAP_se=$(printf '\e[0m')        # reset reverse video
export LESS_TERMCAP_se
LESS_TERMCAP_us=$(printf '\e[1;32m')     # begin underline
export LESS_TERMCAP_us
LESS_TERMCAP_ue=$(printf '\e[0m')        # reset underline
export LESS_TERMCAP_ue

# rcon
export MCRCON_PROMPT='> '
