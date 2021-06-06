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

### most of this is just trying to make $HOME less cluttered ###

# xdg directories
XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME
XDG_CACHE_HOME="$HOME/.cache"
export XDG_CACHE_HOME
XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_HOME

# rust packages
command -v cargo >/dev/null 2>&1 && {
    CARGO_HOME="$XDG_DATA_HOME/cargo"
    export CARGO_HOME
    export PATH="$PATH:$CARGO_HOME/bin"
}

# golang packages
command -v go >/dev/null 2>&1 && {
    GOPATH="$XDG_DATA_HOME/go"
    export GOPATH
    export PATH="$PATH:$GOPATH/bin"
}

# texlive/texmf
command -v mf >/dev/null 2>&1 && {
    TEXMFHOME="$XDG_DATA_HOME/texmf"
    export TEXMFHOME
    TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
    export TEXMFVAR
    TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config"
    export TEXMFCONFIG
}

# virtualenv
command -v virtualenv >/dev/null 2>&1 && {
    WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
    export WORKON_HOME
}

# docker
command -v docker >/dev/null 2>&1 && {
    DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
    export DOCKER_CONFIG
}

# npm
command -v npm >/dev/null 2>&1 && {
    NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
    export NPM_CONFIG_USERCONFIG
}

# wine
command -v wine >/dev/null 2>&1 && {
    WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
    export WINEPREFIX
}

# guix vars
command -v guix >/dev/null 2>&1 && {
    export GUIX_PROFILE="$HOME/.guix-profile"
    # shellcheck disable=SC1091
    [ -f "$GUIX_PROFILE/etc/profile" ] && . "$GUIX_PROFILE/etc/profile"
}

# CUDA
command -v nvcc >/dev/null 2>&1 && {
    CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
    export CUDA_CACHE_PATH
}

# NVIDIA settings
command -v nvidia-settings >/dev/null 2>&1 && {
    alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"'
}

# mednafen
command -v mednafen >/dev/null 2>&1 && {
    MEDNAFEN_HOME="$XDG_CONFIG_HOME/mednafen"
    export MEDNAFEN_HOME
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
