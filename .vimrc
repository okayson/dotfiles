"--- General ---
set noerrorbells
set visualbell
set viminfo=
set nocompatible

if has('vim_starting')
	set runtimepath+=~/.vim
	runtime! userautoload/*.vim
endif

filetype plugin on

"--- Encoding ---
set encoding=utf-8
set encoding=cp932

set fileencodings=iso-2022-jp,iso-2022-jp-2,utf-8,euc-jp,sjis

"--- Plugins ---

"--- File ---
set hidden
set autoread

set browsedir=buffer
"set directory=$HOME/.vim/backup
"set history=1000

"--- Search ---
set incsearch
"set nohlsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan

"--- Input ---
set cindent
set shiftwidth=4
set tabstop=4
set backspace=start,eol,indent
set whichwrap=b,s,h,l,<,>,[,]
set clipboard=unnamed
set list
set listchars=tab:^_,trail:~
set wildmenu wildmode=list:full

"--- Display ---
set number
set title
set showcmd
set ruler
set showmatch
set matchtime=3
"set laststatus=2
"set cursorline

"colorscheme desert
"colorscheme slate
"colorscheme evening

syntax on

hi Statement ctermfg=white
hi Comment   ctermfg=yellow
hi String ctermfg=green cterm=bold
"hi Constant ctermfg=yellow cterm=bold
"hi Character ctermfg=5
"hi String ctermfg=white cterm=bold
"hi Function term=bold ctermfg=LightBlue
"hi Number ctermfg=black
"hi Identifier ctermfg=black cterm=bold
"hi Statement ctermfg=white cterm=bold
"hi PreProc ctermfg=white cterm=bold
"hi Type ctermfg=LightBlue cterm=bold
"hi Special ctermfg=grey cterm=bold
"hi Underlined cterm=italic
"hi Ignore ctermfg=darkgray
"hi Error ctermfg=darkred ctermbg=black
"hi Todo ctermbg=darkred ctermfg=yellow

"--- Map ---
map Y y$

