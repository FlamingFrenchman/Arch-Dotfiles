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

if has('nvim')
    " Neovim specific commands
else
    " Standard vim specific commands
endif

call plug#begin('~/.vim/plugged')
Plug 'mcchrish/nnn.vim'
Plug 'dylanaraps/wal.vim'
call plug#end()

" enable line numbers
set number
" allow backspacing over everything in insert mode
set bs=indent,eol,start
" always show cursor coordinates
set ruler
" highlight matches when searching
set hlsearch
" make it easier to unhighlight things
nmap <space> :nohls<CR>
" enable statusline even for single files
set laststatus=2
" enable tabline even if there's only one tab
set showtabline=2
" no wrapping
set nowrap
" pretty colors
colorscheme slate

" indent something something?
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" enable default lexical/syntax highlighting
syntax on
" turn on folding and let syntax files handle it
set foldmethod=syntax
" C syntax options
let c_minlines = 100
let c_space_errors = 1
let c_curly_error = 1 " can be slow on large files

" open all folds to start
au Syntax * normal zR
