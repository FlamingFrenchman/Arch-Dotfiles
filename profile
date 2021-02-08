#
# ~/.profile
#

# editor
if command -v nvim >/dev/null 2>&1 ; then
    export EDITOR=nvim
elif command -v vim >/dev/null 2>&1 ; then
    export EDITOR=vim
else
    export EDITOR=vi
fi
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR

# guix vars
command -v guix >/dev/null 2>&1 && {
    export GUIX_PROFILE="$HOME/.guix-profile"
    [ -f "$GUIX_PROFILE/etc/profile" ] && . "$GUIX_PROFILE/etc/profile"
}

# xdg
command -v xdg_user_dir >/dev/null 2>&1 && {
    XDG_CONFIG_HOME=$(xdg_user_dir)
    XDG_CONFIG_DOCUMENTS=$(xdg_user_dir DOWNLOADS)
    XDG_CONFIG_DOWNLOADS=$(xdg_user_dir DOCUMENTS)
    export XDG_CONFIG_HOME
    export XDG_CONFIG_DOCUMENTS
    export XDG_CONFIG_DOWNLOADS
}

# colorful less
# Note: raw escape sequences are not portable between shells
LESS='-FRSX --mouse'                     # raw color escape sequences
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

# make less more friendly for non-text input files, see lesspipe(1)
if command -v lesspipe.sh >/dev/null 2>&1 ; then
    export LESSOPEN="|lesspipe.sh %s"
    eval "$(lesspipe.sh)"
fi

# rcon
export MCRCON_PROMPT='> '
