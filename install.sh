#!/bin/sh

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
fi

if [ -d "$HOME"/.local ]; then
	mkdir -p "$HOME"/.local/bin
else
	mkdir -p "$HOME"/.bin
fi

if command -v nvim >/dev/null 2>&1; then
	mkdir -p "$config_dir"/nvim
	cp -r ./vim/. "$config_dir"/nvim/
	mkdir -p "$data_dir"/nvim/site/pack/plugins/start
	(
		cd "$data_dir"/nvim/site/pack/plugins/start || exit 1
		for plugin_url in 'https://github.com/ntpeters/vim-better-whitespace.git' \
			'https://github.com/tpope/vim-surround.git' \
			'https://github.com/neoclide/coc.nvim.git' \
			'https://github.com/maxbrunsfeld/vim-emacs-bindings.git' \
			'https://github.com/mbbill/undotree.git' \
			'https://github.com/nvim-treesitter/nvim-treesitter.git'; do
			plugin_dir=$(basename -s .git "$plugin_url")
			if [ -d "$plugin_dir" ]; then
				(
					cd "$plugin_dir" || exit 1
					git pull
				)
			else git clone "$plugin_url"; fi
		done
	)
	if command -v vim >/dev/null 2>&1 && [ -z "$REMOVE_CLUTTER" ]; then
		ln -sfT "$config_dir"/nvim "$HOME"/.vim
		ln -sf "$config_dir"/nvim/init.vim "$HOME"/.vimrc
		ln -sfT "$data_dir"/nvim/site/pack "$config_dir"/nvim/pack
	fi
elif command -v vim >/dev/null 2>&1; then
	mkdir -p "$HOME"/.vim/pack/plugins/start
	cp -r ./vim/. "$HOME"/.vim/
	(
		cd "$HOME"/.vim/pack/plugins/start || exit 1
		for plugin_url in 'https://github.com/ntpeters/vim-better-whitespace.git' \
			'https://github.com/tpope/vim-surround.git' \
			'https://github.com/neoclide/coc.nvim.git' \
			'https://github.com/maxbrunsfeld/vim-emacs-bindings.git' \
			'https://github.com/mbbill/undotree.git' \
			'https://github.com/nvim-treesitter/nvim-treesitter.git'; do
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
