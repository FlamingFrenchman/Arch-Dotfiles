" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1

" enable powerlines in xterm
"if (&term == "xterm")
   let g:powerline_pycmd='py3'
   "let g:powerline_config_overrides='ext.vim.top_theme=powerline_terminus'
"endif
"if (&term == "linux")
"   let g:powerline_config_overrides='
" enable line numbers
set number
" allow backspacing over everything in insert mode
set bs=indent,eol,start
" always show cursor coordinates
set ruler
" enable default lexical/syntax highlighting
syntax on
" highlight matches when searching
set hlsearch
" enable statusline even for single files
set laststatus=2
" pretty colors
colorscheme zellner
" easier? way to exit insert mode
inoremap <C-]> <esc>
