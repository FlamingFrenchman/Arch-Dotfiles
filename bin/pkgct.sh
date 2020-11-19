for repo in core extra community; do 
  pacman -Ss  | grep "^${repo}/.*\[installed\]" -c
done
