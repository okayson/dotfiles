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

set runtimepath&
set runtimepath+=~/.vim

"------------------------------
" Encoding
"------------------------------
set encoding=utf-8
"if has('win32')
"	set encoding=cp932
"endif
set ambiwidth=double

"set fileencodings=iso-2022-jp,iso-2022-jp-2,utf-8,euc-jp,sjis
set fileencodings=iso-2022-jp-3,iso-2022-jp,euc-jisx0213,euc-jp,utf-8,ucs-bom,euc-jp,eucjp-ms,cp932

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
set listchars=tab:^\ ,trail:~
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
set laststatus=2
set showtabline=2
"set cursorline

"------------------------------
" Plugins
"------------------------------
" Use NeoBundle to manage other plugins.
filetype plugin indent off
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
"- utilities
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'mingw32-make -f make_mingw32.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/unite-outline'		" for unite
NeoBundle 'ujihisa/unite-colorscheme'	" for unite
NeoBundle 'tsukkee/unite-tag'			" for unite
NeoBundle 'thinca/vim-singleton'
NeoBundle 'thinca/vim-fontzoom'
NeoBundle 'vim-scripts/gtags.vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-fold'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-lastpat'
"- color schemes
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'jnurmine/Zenburn'
NeoBundle 'okayson/crosspj.vim'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"------------------------------
" Plugin Settings
"------------------------------
" Unite
let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'
let g:unite_source_history_yank_enable = 1
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#custom#profile('default', 'context', {
"\   'start_insert': 1
"\ })

" NeoComplCache
let g:neocomplcache_enable_at_startup = 1

" NeoSnippet
let g:neosnippet#snippets_directory = '~/.vim/snippets, ~/vim-snippets'
"let g:neosnippet#disable_runtime_snippets = {
"			\   'c' : 1, 'cpp' : 1,
"			\ }

" Ag
let g:aghighlight=1

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

noremap  sg 0
noremap  sh ^
noremap  sl $
noremap  sp %

vnoremap < <gv
vnoremap > >gv

nnoremap <silent> cy   cw<C-r>0<Esc>:let @/ = @"<CR>:nohlsearch<CR>
nnoremap <silent> cY   cW<C-r>0<Esc>:let @/ = @"<CR>:nohlsearch<CR>
nnoremap <silent> ciy ciw<C-r>0<Esc>:let @/ = @"<CR>:nohlsearch<CR>
nnoremap <silent> ciY ciW<C-r>0<Esc>:let @/ = @"<CR>:nohlsearch<CR>
vnoremap <silent> cy    c<C-r>0<Esc>:let @/ = @"<CR>:nohlsearch<CR>

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><C-l>
nnoremap ss :<C-u>write<CR>
nnoremap <Space>m :<C-u>marks<CR>

" Run Command
nnoremap [RC] <Nop>
nmap <Space>. [RC]
nnoremap [RC]  :<C-u>edit $MYVIMRC<CR>
nnoremap [RC]. :<C-u>source $MYVIMRC<CR>

" Help
nnoremap <C-h>      :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

" Toggle Options
nnoremap [Option] <Nop>
nmap <Space>o [Option]
nnoremap [Option]n :<C-u>set number!<CR>
nnoremap [Option]r :<C-u>set relativenumber!<CR>
nnoremap [Option]w :<C-u>set wrap!<CR>

" TabPage
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
nnoremap <silent> [TabPage]s :<C-u>split<CR>
nnoremap <silent> [TabPage]v :<C-u>vsplit<CR>
nnoremap <silent> [TabPage]j <C-w>j
nnoremap <silent> [TabPage]k <C-w>k
nnoremap <silent> [TabPage]h <C-w>h
nnoremap <silent> [TabPage]l <C-w>l

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
nnoremap <silent> <C-n> :cn<CR>zz
nnoremap <silent> <C-p> :cp<CR>zz
nnoremap <silent> so :colder<CR>
nnoremap <silent> sn :cnewer<CR>

" Unite
" show souces	:Unite source
nnoremap [Unite] <Nop>
nmap  su [Unite]
nnoremap          [Unite]u :<C-u>Unite<Space>
nnoremap <silent> [Unite]b :<C-u>Unite -buffer-name=buffer -start-insert buffer<CR>
nnoremap <silent> [Unite]f :<C-u>UniteWithBufferDir -buffer-name=files -start-insert file<CR>
nnoremap <silent> [Unite]s :<C-u>UniteWithCurrentDir -buffer-name=files -start-insert file_rec<CR>
nnoremap <silent> [Unite]m :<C-u>Unite -buffer-name=mru -start-insert file_mru directory_mru bookmark<CR>
nnoremap <silent> [Unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [Unite]y :<C-u>Unite -buffer-name=yank history/yank<CR>
nnoremap <silent> [Unite]h :<C-u>Unite -buffer-name=resume resume<CR>
nnoremap <silent> [Unite]l :<C-u>Unite -buffer-name=line -start-insert line<CR>
nnoremap <silent> [Unite]o :<C-u>Unite -buffer-name=outline -start-insert outline<CR>

augroup UniteBufferMappings
	autocmd!
	autocmd FileType unite call s:map_unite_buffer()
	function! s:map_unite_buffer()
		nnoremap <silent><buffer><expr> cd unite#do_action('lcd')
		nnoremap <silent><buffer><expr> s  unite#do_action('split')
		nnoremap <silent><buffer><expr> v  unite#do_action('vsplit')
		nnoremap <silent><buffer><expr> f  unite#do_action('vimfiler')
	endfunction
augroup END

" VimFiler
nnoremap [VimFiler] <Nop>
nmap     <Space>f [VimFiler]
nnoremap <silent> [VimFiler]f :<C-u>VimFilerBufferDir -buffer-name=BufferDir -status<CR>
nnoremap <silent> [VimFiler]c :<C-u>VimFilerCurrentDir -buffer-name=CurrentDir -status<CR>
nnoremap <silent> [VimFiler]e :<C-u>VimFilerExplorer -buffer-name=explorer -parent<CR>
nnoremap <silent> [VimFiler]b :<C-u>VimFiler bookmark: -buffer-name=bookmark<CR>

augroup VimFilerBufferMappings
	autocmd!
	autocmd FileType vimfiler call s:map_vimfiler_buffer()
	function! s:map_vimfiler_buffer()
		unmap <buffer> t
		unmap <buffer> T
		nmap  <buffer> f <Plug>(vimfiler_expand_tree)
		nmap  <buffer> F <Plug>(vimfiler_expand_tree_recursive)
	endfunction
augroup END

" NeoSnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
xmap <C-l> <Plug>(neosnippet_start_unite_snippet_target)

"------------------------------
" User Commands
"------------------------------
" Trim white spaces on line tail.
command! -range TrimSpaces :%s/\s\+$//|normal! <line1>G

" Make tag files
command! MakeTags :call <SID>make_tags()
" Make tag files
" Functions for 'Make tag file'."{{{
function! s:make_tags()
	call s:make_gtags()
	call s:make_ctags()
endfunction

function! s:make_gtags()
	if executable('gtags')
		echo 'Processing...gtags.'
		call system('find . -type f -name GTAGS -exec rm -f {} \;')
		call system('find . -type f -name GPATH -exec rm -f {} \;')
		call system('find . -type f -name GRTAGS -exec rm -f {} \;')
		call system('gtags')
	else	
		echo 'gtags not found.'
	endif
endfunction

function! s:make_ctags()
	if executable('ctags')
		echo 'Processing...ctags.'
		call system('find . -type f -name tags -exec rm -f {} \;')
		call system('ctags -R')
	else
		echo 'ctags not found.'
	endif
endfunction
"}}}

"------------------------------
" Others
"------------------------------
syntax on

"------------------------------
" Local Setting
"------------------------------
" Write local setting to '~/.vimrc.local', for example:
" - color scheme
" - enviroment variables.(useful document folder etc...)
if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif

" vim: foldmethod=marker
