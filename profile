# shellcheck shell=sh

# editor
if command -v nvim >/dev/null 2>&1 ; then
    export EDITOR=nvim
    export VIEWER='nvim -M -R'
    export VISUAL=$EDITOR
    export SUDO_EDITOR=$EDITOR
elif command -v vim >/dev/null 2>&1 ; then
    export EDITOR=vim
    export VIEWER='vim -M -R'
    export VISUAL=$EDITOR
    export SUDO_EDITOR=$EDITOR
elif command -v vi >/dev/null 2>&1 ; then
    export EDITOR='vi'
    # i don't know if view is always shipped with vi, so just to be safe
    if ! command -v view >/dev/null 2>&1 ; then export VIEWER='vi -R' ; fi
    export VISUAL=$EDITOR
    export SUDO_EDITOR=$EDITOR
fi

# rcfile for bourne shell/posix sh
if [ -r "$HOME"/.shrc ] ; then
    export ENV="$HOME"/.shrc
fi

# less
LESS='-FRSX --mouse --use-color'             # raw color escape sequences
export LESS

# make less more friendly for non-text input files and add syntax highlighting
# see lesspipe(1) and source-highlight(1)
if command -v src-hilite-lesspipe.sh >/dev/null 2>&1 ; then
    export LESSOPEN='| src-hilite-lesspipe.sh %s'
fi

# no point in executing the rest of the file if we can't use xdg dirs
if [ -z "$HOME" ] || ! [ -w "$HOME" ] || [ -z "$REMOVE_CLUTTER" ] ; then return ; fi

GREP=$(if command -v grep >/dev/null 2>&1 ; then
        command -v grep
    elif command -pv grep >/dev/null 2>&1 ; then
        command -pv grep
    fi);
if [ -z "$GREP" ] ; then
    echo 'Unable to locate grep; will not attempt to unclutter'
    return 1
fi

MKDIR=$(if command -v mkdir >/dev/null 2>&1 ; then
        command -v mkdir
    elif command -pv mkdir >/dev/null 2>&1 ; then
        command -pv mkdir
    fi);
if [ -z "$MKDIR" ] ; then
    echo 'Unable to locate mkdir; will not attempt to unclutter'
    return 1
fi

# swiped from stackexchange
# changed to use command to find grep rather than assuming a particular path
pathmunge () {
    if ! echo "$PATH" | "$GREP" -Eq "(^|:)$1($|:)" ; then
           if [ "$2" = 'after' ] ; then
              PATH="$PATH:$1"
           else
              PATH="$1:$PATH"
           fi
        fi
}

# xdg directories
export XDG_CONFIG_HOME="$HOME"/.config
"$MKDIR" -p "$XDG_CONFIG_HOME"
export XDG_CACHE_HOME="$HOME"/.cache
"$MKDIR" -p "$XDG_CACHE_HOME"
export XDG_DATA_HOME="$HOME"/.local/share
"$MKDIR" -p "$XDG_DATA_HOME"
export XDG_STATE_HOME="$HOME"/.local/state
"$MKDIR" -p "$XDG_STATE_HOME"

# readline
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
"$MKDIR" -p "$XDG_CONFIG_HOME"/readline

# less
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
"$MKDIR" -p "$XDG_CONFIG_HOME"/less
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
"$MKDIR" -p "$XDG_STATE_HOME"/less

# wget
if command -v wget >/dev/null 2>&1 ; then
    export WGETRC="$XDG_CONFIG_HOME"/wgetrc
fi

# openssl
if command -v openssl >/dev/null 2>&1 ; then
    export RANDFILE="$XDG_CACHE_HOME"/rnd
fi

# GnuPG
if command -v gpg >/dev/null 2>&1 ; then
    export GNUPGHOME="$XDG_DATA_HOME"/gnupg
fi

# python
if command -v python >/dev/null 2>&1 ; then
    export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/startup.py
    "$MKDIR" -p "$XDG_CONFIG_HOME"/python
fi

# rust packages
if command -v cargo >/dev/null 2>&1 ; then
    export CARGO_HOME="$XDG_DATA_HOME"/cargo
    pathmunge "$CARGO_HOME"/bin
fi

# golang packages
if command -v go >/dev/null 2>&1 ; then
    export GOPATH="$XDG_DATA_HOME"/go
    pathmunge "$GOPATH"/bin
fi

# node repl history
if command -v node >/dev/null 2>&1 ; then
    export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node/history
    "$MKDIR" -p "$XDG_STATE_HOME"/node
fi

# npm
if command -v npm >/dev/null 2>&1 ; then
    NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
    "$MKDIR" -p "$XDG_CONFIG_HOME"/npm
    export NPM_CONFIG_USERCONFIG
fi

# texlive/texmf
if command -v mf >/dev/null 2>&1 ; then
    export TEXMFHOME="$XDG_DATA_HOME"/texmf
    export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
    export TEXMFCONFIG="$XDG_CONFIG_HOME"/texlive/texmf-config
fi

# virtualenv
if command -v virtualenv >/dev/null 2>&1 ; then
    export WORKON_HOME="$XDG_DATA_HOME"/virtualenvs
fi

# docker
if command -v docker >/dev/null 2>&1 ; then
    export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
fi

# wine
if command -v wine >/dev/null 2>&1 ; then
    export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
    "$MKDIR" -p "$WINEPREFIX"
fi

# elinks
if command -v elinks >/dev/null 2>&1 ; then
    export ELINKS_CONFDIR="$XDG_CONFIG_HOME"/elinks
fi

unset GREP
unset MKDIR
unset -f pathmunge
