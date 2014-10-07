" How to check options.
"	 :help options
"	 :help option-list
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
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'thinca/vim-singleton'
NeoBundle 'vim-scripts/gtags.vim'
NeoBundle 'rking/ag.vim'
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
set showtabline=2

syntax on

"------------------------------
" Keymap
"------------------------------
" How to check about key map.
" Detault  key map > :h index.txt
" Assigned key map > :verbose map(or nmap/imap/vmap)

nnoremap <F4> :<C-u>edit $MYVIMRC<CR>
nnoremap <F5> :<C-u>source $MYVIMRC<CR>

" Help
nnoremap <C-h>      :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

nnoremap Y y$
noremap  j gj
noremap  k gk
noremap  gj j
noremap  gk k

nnoremap <Space>/ :<C-u>nohlsearch<C-l><CR>
nnoremap <Space>m :<C-u>marks<CR>
nnoremap <Space>r :<C-u>registers<CR>

nnoremap ss :<C-u>write<CR>
noremap  sg 0
noremap  sh ^
noremap  sl $

" Toggle Options
nnoremap [Option] <Nop>
nmap <Space>o [Option]
nnoremap [Option]n :<C-u>set number!<CR>
nnoremap [Option]r :<C-u>set relativenumber!<CR>
nnoremap [Option]w :<C-u>set wrap!<CR>

" TabPage
nnoremap [TabPage] <Nop>
nmap   t [TabPage]
nnoremap <silent> [TabPage]t <C-w>T
nnoremap <silent> [TabPage]o :<C-u>tabedit<CR>
nnoremap <silent> [TabPage]q :<C-u>tabclose<CR>
nnoremap <silent> [TabPage]x :<C-u>tabonly<CR>
nnoremap <silent> [TabPage]n :<C-u>tabnext<CR>
nnoremap <silent> [TabPage]p :<C-u>tabprevious<CR>
nnoremap <silent> [TabPage]l :<C-u>tabs<CR>
for i in range(1, 9)
	" Input 't{i}' to go to tab page {i}.
	execute 'nnoremap <silent> [TabPage]'.i ':<C-u>tabnext'.i '<CR>'
endfor

" Tags
nnoremap   [Tags] <Nop>
nmap <C-t> [Tags]
nnoremap <silent> [Tags]<C-t> <C-]>
nnoremap <silent> [Tags]n :<C-u>tag<CR>
nnoremap <silent> [Tags]p :<C-u>pop<CR>
nnoremap <silent> [Tags]l :<C-u>tags<CR>

" Gtags
nmap          <C-g> :Gtags<Space>
nmap <silent> <C-l> :cd <C-r>=getcwd()<CR><CR>:Gtags -f %<CR>
nmap <silent> <C-j> :Gtags <C-r><C-w><CR>
nmap <silent> <C-k> :Gtags -r <C-r><C-w><CR>

" QuickFix
nmap <silent> <C-n> :cn<CR>
nmap <silent> <C-p> :cp<CR>

"------------------------------
" Local Setting
"------------------------------
" Write local setting to '~/.vimrc.local', for example:
" - color scheme
" - enviroment variables.(useful document folder etc...)
if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif

