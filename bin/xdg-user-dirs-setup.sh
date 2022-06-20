#!/bin/bash
set -x

prefix=${1:-"/media/shared"}
xdg_dirs=('Documents' 'Downloads' 'Public' 'Music'
             'Videos' 'Pictures' 'Templates')
other_dirs=('Torrents' 'Projects')

for d in "${xdg_dirs[@]}"; do
    # remove link if it is to the wrong place
    [[ -h $HOME/$d ]] && rm $HOME/$d
    # remove directory if it is not a symlink
    [[ -d $HOME/$d ]] && rm -r $HOME/$d
    uppercase=$(echo $d | tr [:lower:] [:upper:])
    uppercase=${uppercase/%PUBLIC/PUBLICSHARE}
    xdg-user-dirs-update --set $uppercase "$prefix/$d"
    ln -s "$prefix/$d" "$HOME/$d"
done
