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

" cursor settings
" if vi mode prefixes are not being set by readline, they will need to be set
" manually on vim exit using autocmds
if exists('$TMUX')
    let &t_SI = "\ePtmux;\e\e[3 q\e\\"
    let &t_SR = "\ePtmux;\e\e[5 q\e\\"
    let &t_EI = "\ePtmux;\e\e[1 q\e\\"
else
    " insert
    let &t_SI = "\e[3 q"
    " replace
    let &t_SR = "\e[5 q"
    " normal (and anything else)
    let &t_EI = "\e[1 q"
endif
" used in gVim and by neovim
set guicursor=n-v-ve-o:block,i-c-ci:hor20,r-cr:ver25
    \,a:blinkwait700-blinkoff200-blinkon200-Cursor/lCursor

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
