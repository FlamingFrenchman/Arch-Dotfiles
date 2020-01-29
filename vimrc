" archlinux.vim is probably located in /usr/share/vim/vimfiles/
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim
" If not present or unpleasant, there's also
" /usr/share/vim/vimXX/vimrc_example.vim

if has('nvim')
    " Neovim specific commands
else
    " Standard vim specific commands
endif

if has('plugs')
    " plugins
    call plug#begin('~/.vim/plugged')
    Plug 'mcchrish/nnn.vim'
    Plug 'dylanaraps/wal.vim'
    call plug#end()
endif

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
" always show last command executed
set showcmd
" no wrapping
set nowrap
" pretty colors
colorscheme slate

" the following options are to be used when consistent and relatively readable
" text wrapping is desired
"
" allow text/break label to occupy the gutter
set cpoptions+=n
" make the minimum gutter wide enough for 4 digit numbers
set numberwidth=5
" wrap text
set wrap
" label for line breaks/wraps
set showbreak=\ \ \ >\ 

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
if has('autocmd')
    au Syntax * normal zR
endif
