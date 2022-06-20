#
# ~/.profile
#

# editor
if command -v nvim >/dev/null 2>&1 ; then
    EDITOR=nvim
    export EDITOR
    VISUAL=$EDITOR
    export VISUAL
    SUDO_EDITOR=$EDITOR
    export SUDO_EDITOR
elif command -v vim >/dev/null 2>&1 ; then
    EDITOR=vim
    export EDITOR
    VISUAL=$EDITOR
    export VISUAL
    SUDO_EDITOR=$EDITOR
    export SUDO_EDITOR
elif command -v vi >/dev/null 2>&1 ; then
    EDITOR='vi'
    export EDITOR
    VISUAL=$EDITOR
    export VISUAL
    SUDO_EDITOR=$EDITOR
    export SUDO_EDITOR
fi

# xdg directories
XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME
XDG_CACHE_HOME="$HOME/.cache"
export XDG_CACHE_HOME
XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_HOME
XDG_STATE_HOME="$HOME/.local/state"
export XDG_STATE_HOME

# readline
INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export INPUTRC

# qt5 in gnome/gtk environments
QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORMTHEME
#QT_STYLE_OVERRIDE=adwaita-dark
#export QT_STYLE_OVERRIDE
QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_AUTO_SCREEN_SCALE_FACTOR
QT_SCALE_FACTOR=1
export QT_SCALE_FACTOR
QT_FONT_DPI=96
export QT_FONT_DPI

if lsmod | grep amdgpu >/dev/null 2>&1 ; then
    # hardware video acceleration
    LIBVA_DRIVER_NAME=radeonsi
    export LIBVA_DRIVER_NAME
    VDPAU_DRIVER=radeonsi
    export VDPAU_DRIVER
elif lsmod | grep i915 >/dev/null 2>&1 ; then
    # hardware video acceleration
    LIBVA_DRIVER_NAME=i965
    export LIBVA_DRIVER_NAME
    VDPAU_DRIVER=va_gl
    export VDPAU_DRIVER
    # prevent libglvnd from loading the nvidia driver on optimus laptops
    __EGL_VENDOR_LIBRARY_FILENAMES="/usr/share/glvnd/egl_vendor.d/50_mesa.json"
    export __EGL_VENDOR_LIBRARY_FILENAMES
fi

# less
[ -d "$XDG_CONFIG_HOME/less" ] || mkdir "$XDG_CONFIG_HOME/less"
LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
export LESSKEY
[ -d "$XDG_STATE_HOME/less" ] || mkdir "$XDG_STATE_HOME/less"
LESSHISTFILE="$XDG_STATE_HOME/less/history"
export LESSHISTFILE

# Note: raw escape sequences are not portable between shells
LESS='-FRSX --mouse --use-color'             # raw color escape sequences
export LESS
if echo "$TERM" | grep '^screen.*$' >/dev/null 2>&1 ; then
    LESS_TERMCAP_mb=$(printf '\eP\e[1;31m\e\\')     # begin blink
    export LESS_TERMCAP_mb
    LESS_TERMCAP_md=$(printf '\eP\e[1;36m\e\\')     # begin bold
    export LESS_TERMCAP_md
    LESS_TERMCAP_me=$(printf '\eP\e[0m\e\\')        # reset bold/blink
    export LESS_TERMCAP_me
    LESS_TERMCAP_so=$(printf '\eP\e[01;44;33m\e\\') # begin reverse video
    export LESS_TERMCAP_so
    LESS_TERMCAP_se=$(printf '\eP\e[0m\e\\')        # reset reverse video
    export LESS_TERMCAP_se
    LESS_TERMCAP_us=$(printf '\eP\e[1;32m\e\\')     # begin underline
    export LESS_TERMCAP_us
    LESS_TERMCAP_ue=$(printf '\eP\e[0m\e\\')        # reset underline
    export LESS_TERMCAP_ue
else 
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
fi

# make less more friendly for non-text input files and add syntax highlighting
# see lesspipe(1) and source-highlight(1)
if command -v src-hilite-lesspipe.sh >/dev/null 2>&1 ; then
    export LESSOPEN="| src-hilite-lesspipe.sh %s"
fi

### most of this is just trying to make $HOME less cluttered ###

# wget
command -v wget >/dev/null 2>&1 && {
    WGETRC="$XDG_CONFIG_HOME/wgetrc"
    export WGETRC
}

# openssl
command -v openssl >/dev/null 2>&1 && {
    RANDFILE="$XDG_CACHE_HOME/rnd"
    export RANDFILE
}

# GnuPG
command -v gpg >/dev/null 2>&1 && {
    GNUPGHOME="$XDG_DATA_HOME/gnupg"
    export GNUPGHOME
}

# python
command -v python >/dev/null 2>&1 && {
    PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
    export PYTHONSTARTUP
}

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

# elinks
command -v elinks >/dev/null 2>&1 && {
    ELINKS_CONFDIR="$XDG_CONFIG_HOME/elinks"
    export ELINKS_CONFDIR
}

# NVIDIA settings and CUDA
command -v nvidia-settings >/dev/null 2>&1 && {
    alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"'
    CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
    export CUDA_CACHE_PATH
}

# mednafen
command -v mednafen >/dev/null 2>&1 && {
    MEDNAFEN_HOME="$XDG_CONFIG_HOME/mednafen"
    export MEDNAFEN_HOME
}

# DOSBox
command -v dosbox >/dev/null 2>&1 && {
    alias dosbox='dosbox -conf "$XDG_CONFIG_HOME/dosbox/dosbox.conf"'
}

return 0
