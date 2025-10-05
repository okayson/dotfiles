" How to see options.
"	 :help options
"	 :help option-list
"------------------------------
" General
"------------------------------
" Add `lua` directory to package path.
" lua << EOF
" local config_path = vim.fn.stdpath("config")
" package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/lua/?.lua;"
" EOF
lua package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/lua/?.lua;"

set visualbell
set number

"------------------------------
" Encoding
"------------------------------
" set ambiwidth=double
" set fileencodings=utf-8,cp932,iso-2022-jp-3,iso-2022-jp,euc-jisx0213,euc-jp,ucs-bom,eucjp-ms

"------------------------------
" File
"------------------------------
set hidden
set autoread
" set browsedir=buffer

"------------------------------
" Search
"------------------------------
set incsearch
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
set clipboard=unnamedplus
set list
set listchars=tab:^\ ,trail:~

" set wildmenu
" set wildmenu wildmode=list:full
"
"------------------------------
" Display
"------------------------------
set number
set title
set showcmd
set ruler
set showmatch
set matchtime=3
set laststatus=2
set showtabline=2
"set cursorline

"------------------------------
" Key Mappings
"------------------------------
" [How to check about key map]
" 	Detault  key map > :h index.txt
" 	Assigned key map > :verbose map(or nmap/imap/vmap)
"
" [Guide line]
" 	- for moving.
" 	  mode		: Normal/Visual/Operator-pending
" 	  command	: noremap
" 	- for seclecting.
" 	  mode		: Visual/Operator-pending
" 	  command	: vnoremap/onoremap
" 	- for inputing.
" 	  mode		: Insert/Command-line(optional)
" 	  command	: inoremap
" 	- for executing function.
" 	  mode		: Normal
" 	  command	: nnoremap

nnoremap Y  y$

noremap  j  gj
noremap  k  gk
noremap  gj j
noremap  gk k

" noremap  sg 0
" noremap  sh ^
noremap  sh 0
noremap  sl $
noremap  sp %

vnoremap < <gv
vnoremap > >gv

nnoremap *  *N
nnoremap #  #N

nnoremap <silent> cy   cw<C-r>0<Esc>:let @/ = @"<CR>:nohlsearch<CR>
nnoremap <silent> cY   cW<C-r>0<Esc>:let @/ = @"<CR>:nohlsearch<CR>
nnoremap <silent> ciy ciw<C-r>0<Esc>:let @/ = @"<CR>:nohlsearch<CR>
nnoremap <silent> ciY ciW<C-r>0<Esc>:let @/ = @"<CR>:nohlsearch<CR>
vnoremap <silent> cy    c<C-r>0<Esc>:let @/ = @"<CR>:nohlsearch<CR>

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><C-l>
nnoremap ss :<C-u>write<CR>
nnoremap <Space>m :<C-u>marks<CR>
nnoremap <C-g> <C-^>

" Run Command
nnoremap [RC] <Nop>
nmap <Space>. [RC]
nnoremap [RC]  :<C-u>edit $MYVIMRC<CR>
nnoremap [RC]. :<C-u>source $MYVIMRC<CR>

" Help
if !exists('g:vscode') 	" NOT VSCODE ----->
nnoremap <C-h>      :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>
nnoremap <C-h><C-g> :<C-u>helpgrep<Space>
endif					" NOT VSCODE -----<

" Toggle Options
nnoremap [Option] <Nop>
nmap <Space>o [Option]
nnoremap          [Option]n :<C-u>set number!<CR>
nnoremap          [Option]r :<C-u>set relativenumber!<CR>
nnoremap          [Option]w :<C-u>set wrap!<CR>
nnoremap          [Option]t :<C-u>set expandtab!<CR>
nnoremap <silent> [Option]g :<C-u>ToggleGitbranchDisplay<CR>
nnoremap <silent> [Option]p :<C-u>TogglePathDisplay<CR>
nnoremap <silent> [Option]f :<C-u>ToggleFuncDisplay<CR>

" TabPage
if !exists('g:vscode') 	" NOT VSCODE ----->
nnoremap [TabPage] <Nop>
nmap   t [TabPage]
nnoremap <silent> [TabPage]o <C-w>T
nnoremap <silent> [TabPage]t :<C-u>tabedit<CR>
nnoremap <silent> [TabPage]q :<C-u>tabclose<CR>
nnoremap <silent> [TabPage]x :<C-u>tabonly<CR>
nnoremap <silent> [TabPage]n :<C-u>tabnext<CR>
nnoremap <silent> [TabPage]p :<C-u>tabprevious<CR>
nnoremap <silent> [TabPage]i :<C-u>tabs<CR>
for i in range(1, 9)
	" Input 't{i}' to go to tab page {i}.
	execute 'nnoremap <silent> [TabPage]'.i ':<C-u>tabnext'.i '<CR>'
endfor
nnoremap <silent> [TabPage]. :<C-u>tabmove +1<CR>
nnoremap <silent> [TabPage], :<C-u>tabmove -1<CR>
nnoremap <silent> [TabPage]> :<C-u>tabmove<CR>
nnoremap <silent> [TabPage]< :<C-u>tabmove 0<CR>

nnoremap <silent> [TabPage]s :<C-u>split<CR>
nnoremap <silent> [TabPage]v :<C-u>vsplit<CR>
nnoremap <silent> [TabPage]j <C-w>j
nnoremap <silent> [TabPage]k <C-w>k
nnoremap <silent> [TabPage]h <C-w>h
nnoremap <silent> [TabPage]l <C-w>l
endif					" NOT VSCODE -----<

" Terminal
" Terminal prefix key is <C-w>.
" set termkey=<C-j>
"" Change to terminal normal mode
" tnoremap <silent> <Esc><Esc> <C-w>N
tnoremap <silent> <C-o><C-o> <C-w>N
"" Paste "register
tnoremap <silent> <C-o><C-p> <C-w>""

" Terminal cheat sheet
"- Rotate window:=> <C-w>r
"- Change to command line mode:=> <C-w>:

" Tags
nnoremap   [Tags] <Nop>
nmap <C-t> [Tags]
nnoremap <silent> [Tags]<C-t> <C-]>
nnoremap <silent> [Tags]n :<C-u>tag<CR>
nnoremap <silent> [Tags]p :<C-u>pop<CR>
nnoremap <silent> [Tags]l :<C-u>tags<CR>

" Gtags
nmap <silent> <C-l> :cd <C-r>=getcwd()<CR><CR>:Gtags -f %<CR>
nmap <silent> <C-j> :Gtags <C-r><C-w><CR>
nmap <silent> <C-k> :Gtags -r <C-r><C-w><CR>

" QuickFix
nnoremap <silent> <C-n> :cn<CR>zz
nnoremap <silent> <C-p> :cp<CR>zz
nnoremap <silent> so :colder<CR>
nnoremap <silent> sn :cnewer<CR>

if exists('g:vscode')	" VSCODE ----->
	lua require('modules.vscode_keymap')
endif					" VSCODE ----->

"------------------------------
" FileType Setting
"------------------------------
" sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtab
"
augroup FileTypeConfig
	autocmd!
	autocmd FileType sh  setlocal sw=2 sts=2 ts=2 et
	autocmd FileType c   setlocal sw=4 sts=4 ts=4 et
	autocmd FileType cpp setlocal sw=4 sts=4 ts=4 et
augroup END

"------------------------------
" Others
"------------------------------
syntax on


