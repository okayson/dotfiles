"------------------------------
" General
"------------------------------
set noerrorbells
set visualbell
set viminfo=
set nocompatible

if has('vim_starting')
	set runtimepath+=~/.vim
	runtime! userautoload/*.vim
endif

"------------------------------
" Encoding
"------------------------------
set encoding=utf-8
set encoding=cp932

set fileencodings=iso-2022-jp,iso-2022-jp-2,utf-8,euc-jp,sjis

"------------------------------
" Plugins
"------------------------------
" Use NeoBundle to manage other plugins.

filetype plugin indent off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
"- utilities
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'thinca/vim-singleton'
NeoBundle 'vim-scripts/gtags.vim'
"- color schemes
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'jnurmine/Zenburn'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

"------------------------------
" File
"------------------------------
set hidden
set autoread

set browsedir=buffer
"set directory=$HOME/.vim/backup
"set history=1000

"------------------------------
" Search
"------------------------------
set incsearch
"set nohlsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan

"------------------------------
" Input
"------------------------------
set cindent
set shiftwidth=4
set tabstop=4
set backspace=start,eol,indent
set whichwrap=b,s,h,l,<,>,[,]
set clipboard=unnamed
set list
set listchars=tab:^_,trail:~
set wildmenu wildmode=list:full

"------------------------------
" Display
"------------------------------
set number
set title
set showcmd
set ruler
set showmatch
set matchtime=3
"set laststatus=2
"set cursorline

syntax on

"------------------------------
" Map
"------------------------------
" How to check about key map.
" Detault key map  > :h index.txt
" Assigned key map > :verbose map
"                     (or nmap/imap/vmap)

map Y y$

" Gtags
nmap <C-q> <C-w><C-w><C-w>q
nmap <C-g> :Gtags -g
nmap <C-l> :cd <C-r>=getcwd()<CR><CR> 
         \ :Gtags -f <C-r>=substitute(expand('%'), "\\", "/", "g")<CR><CR>
nmap <C-j> :Gtags <C-r><C-w><CR>
nmap <C-k> :Gtags -r <C-r><C-w><CR>
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>

"------------------------------
" Local Setting
"------------------------------
" Write local setting to '~/.vimrc.local', for example:
" - color scheme
" - enviroment variables.(useful document folder etc...)
if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif

