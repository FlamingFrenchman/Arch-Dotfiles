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

if [ -z "${REMOVE_CLUTTER+x}" ]; then
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

if command -v nvim >/dev/null 2>&1; then
	mkdir -p "$config_dir"/nvim
	cp -r ./vim/. "$config_dir"/nvim/
	mkdir -p "$data_dir"/nvim/site/pack/
	# make directories for undo, swap, and backup files
	mkdir -p "$state_dir"/nvim/undo "$state_dir"/nvim/backup "$state_dir"/nvim/swap
	# set permissions separately in case the directories already existed
	chmod 0700 "$state_dir"/nvim/undo "$state_dir"/nvim/backup "$state_dir"/nvim/swap

	# install/update lsp packages
	(
		mkdir -p "$data_dir"/nvim/site/pack/lsp/start
		cd "$data_dir"/nvim/site/pack/lsp/start || exit 1
		while read -r lsp_url; do
			lsp_dir=$(basename -s .git "$lsp_url")
			if [ -d "$lsp_dir" ]; then
				(
					cd "$lsp_dir" || exit 1
					git pull
				)
			else git clone "$lsp_url"; fi
		done <<EOF
https://github.com/hrsh7th/cmp-nvim-lsp.git
https://github.com/saadparwaiz1/cmp_luasnip.git
https://github.com/VonHeikemen/lsp-zero.nvim.git
https://github.com/L3MON4D3/LuaSnip.git
https://github.com/Bilal2453/luvit-meta.git
https://github.com/hrsh7th/nvim-cmp.git
https://github.com/neovim/nvim-lspconfig.git
EOF
	)
	# install plugins
	(
		mkdir -p "$data_dir"/nvim/site/pack/plugins/start
		cd "$data_dir"/nvim/site/pack/plugins/start || exit 1
		while read -r plugin_url; do
			plugin_dir=$(basename -s .git "$plugin_url")
			if [ -d "$plugin_dir" ]; then
				(
					cd "$plugin_dir" || exit 1
					git pull
				)
			else git clone "$plugin_url"; fi
		done <<EOF
https://github.com/lukas-reineke/indent-blankline.nvim.git
https://github.com/echasnovski/mini.nvim.git
https://github.com/kylechui/nvim-surround.git
https://github.com/mbbill/undotree.git
https://github.com/tpope/vim-sleuth.git
EOF
	)
	# install treesitter
	(
		mkdir -p "$data_dir"/nvim/site/pack/treesitter/start
		cd "$data_dir"/nvim/site/pack/treesitter/start || exit 1
		while read -r tsit_url; do
			tsit_dir=$(basename -s .git "$tsit_url")
			if [ -d "$tsit_dir" ]; then
				(
					cd "$tsit_dir" || exit 1
					git pull
				)
			else git clone --branch=main "$tsit_url"; fi
		done <<EOF
https://github.com/nvim-treesitter/nvim-treesitter.git
https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git
EOF
	)
else
	echo "Unable to locate neovim executable; skipping package installation."
fi
