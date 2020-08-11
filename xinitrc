#!/bin/sh

# ~/.xprofile
#       Many display managers source this file when you begin a session 
# ~/.xinitrc
#       Sourced when executing xinit
# ~/.xsession
#       Also sourced by display managers, but is used for the "custom" profile
# ~/.xsessionrc
#       Debian specific; should be used to set global environment variables

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
[ -f "$sysresources"  ] && xrdb -merge $sysresources
[ -f "$sysmodmap"     ] && xmodmap $sysmodmap
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap"    ] && xmodmap "$usermodmap"

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

[ -f ~/.xprofile ] && source ~/.xprofile
exec startxfce4
