#!/bin/sh

set -o nounset
set -o errexit

# cd into the bundle and use relative paths
cd "$(dirname "$0")" || {
	echo 'Unable to cd into bundle directory; exiting.'
	exit 1
}
[ -n "$HOME" ] || {
	echo "\$HOME is unset; exiting."
	exit 1
}
[ -w "$HOME" ] || {
	echo "\$HOME is not writeable; exiting."
	exit 1
}

cp ./profile "$HOME"/.profile
cp ./shrc "$HOME"/.shrc

if command -v bash >/dev/null 2>&1; then
	cp ./bashrc "$HOME"/.bashrc
	cp ./bash_profile "$HOME"/.bash_profile
	#cp ./bash_logout "$HOME"/.bash_logout
fi

config_dir=${XDG_CONFIG_HOME:-$HOME/.config}
data_dir=${XDG_DATA_HOME:-$HOME/.local/share}
state_dir=${XDG_STATE_HOME:-$HOME/.local/state}

if [ -z "$REMOVE_CLUTTER" ]; then
	cp ./inputrc "$HOME"/.inputrc
	if command -v tmux >/dev/null 2>&1; then
		cp ./tmux.conf "$HOME"/.tmux.conf
	fi
else
	mkdir -p "$config_dir"/readline
	cp ./inputrc "$config_dir"/readline/
	if command -v tmux >/dev/null 2>&1; then
		mkdir -p "$config_dir"/tmux
		cp ./tmux.conf "$config_dir"/tmux/
	fi
	if command -v npm >/dev/null 2>&1; then
		mkdir -p "$config_dir"/npm
		cp ./npmrc "$config_dir"/npm
	fi
	if command -v python >/dev/null 2>&1; then
		mkdir -p "$config_dir"/python
		cp ./startup.py "$config_dir"/python
	fi
	if command -v yarn >/dev/null 2>&1; then
		mkdir -p "$config_dir"/yarn
		# yarn needs a file to be here, even if it is empty
		touch "$config_dir"/yarn/config
	fi
fi

if [ -d "$HOME"/.local ]; then
	mkdir -p "$HOME"/.local/bin
else
	mkdir -p "$HOME"/.bin
fi

plugin_urls='https://github.com/ntpeters/vim-better-whitespace.git\nhttps://github.com/tpope/vim-surround.git\nhttps://github.com/maxbrunsfeld/vim-emacs-bindings.git\nhttps://github.com/mbbill/undotree.git\nhttps://github.com/nvim-treesitter/nvim-treesitter.git\n'

if command -v nvim >/dev/null 2>&1; then
	mkdir -p "$config_dir"/nvim
	cp -r ./vim/. "$config_dir"/nvim/
	mkdir -p "$data_dir"/nvim/site/pack/plugins/start
	# make directories for undo, swap, and backup files
	mkdir -p "$state_dir"/nvim/undo "$state_dir"/nvim/backup "$state_dir"/nvim/swap
	# set permissions separately in case the directories already existed
	chmod 0700 "$state_dir"/nvim/undo "$state_dir"/nvim/backup "$state_dir"/nvim/swap
	(
		cd "$data_dir"/nvim/site/pack/plugins/start || exit 1
		printf '%s' $plugin_urls | while read -r plugin_url; do
			plugin_dir=$(basename -s .git "$plugin_url")
			if [ -d "$plugin_dir" ]; then
				(
					cd "$plugin_dir" || exit 1
					git pull
				)
			else git clone "$plugin_url"; fi
		done
		# clone/update release version of coc, and only if nvim is installed
		if [ -d 'coc.nvim' ]; then
			(
				cd 'coc.nvim' || exit 1
				git pull
			)
		else
			git clone --branch release \
				https://github.com/neoclide/coc.nvim.git \
				--depth=1
		fi
	)
	if command -v vim >/dev/null 2>&1 && [ -z "$REMOVE_CLUTTER" ]; then
		ln -sfT "$config_dir"/nvim "$HOME"/.vim
		ln -sf "$config_dir"/nvim/init.vim "$HOME"/.vimrc
		ln -sfT "$data_dir"/nvim/site/pack "$config_dir"/nvim/pack
		ln -sfT "$state_dir"/nvim/undo "$HOME"/.vim/undo
		ln -sfT "$state_dir"/nvim/swap "$HOME"/.vim/swap
		ln -sfT "$state_dir"/nvim/backup "$HOME"/.vim/backup
	fi
elif command -v vim >/dev/null 2>&1; then
	mkdir -p "$HOME"/.vim/pack/plugins/start
	# make directories for undo, swap, and backup files
	mkdir -p "$HOME"/.vim/undo "$HOME"/.vim/backup "$HOME"/.vim/swap
	# set permissions separately in case the directories already existed
	chmod 0700 "$HOME"/.vim/undo "$HOME"/.vim/backup "$HOME"/.vim/swap
	cp -r ./vim/. "$HOME"/.vim/
	(
		cd "$HOME"/.vim/pack/plugins/start || exit 1
		printf '%s' $plugin_urls | while read -r plugin_url; do
			plugin_dir=$(basename -s .git "$plugin_url")
			if [ -d "$plugin_dir" ]; then
				(
					cd "$plugin_dir" || exit 1
					git pull
				)
			else git clone "$plugin_url"; fi
		done
	)
	ln -sf "$HOME"/.vim/init.vim "$HOME"/.vimrc
fi
