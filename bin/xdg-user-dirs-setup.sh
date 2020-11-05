#!/bin/bash
prefix=${1:-"/media/shared"}
xdg_dirs=('Documents' 'Downloads' 'Public' 'Music'
             'Videos' 'Pictures' 'Templates')
other_dirs=('Torrents' 'Projects')

for d in "${xdg_dirs[@]}"; do
    # remove directory if it is not a symlink
    [[ -d $HOME/$d ]] && [[ ! -h $HOME/$d ]] && mv $HOME/$d $prefix/$d && rm -r $HOME/$d
    # remove link if it is to the wrong place
    if [[ -h $HOME/$d ]]; then
        current_dir=$(readlink $HOME/$d)
        #[[ $current_dir != 
    fi
    uppercase=$(echo $d | tr [:lower:] [:upper:])
    uppercase=${uppercase/%PUBLIC/PUBLICSHARE}
    xdg-user-dirs-update --set $uppercase "$prefix/$d"
done
