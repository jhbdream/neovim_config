scriptencoding utf-8

" change fillchars for folding, vertical split, end of buffer, and message separator
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

" Split window below/right when creating horizontal/vertical windows
set splitbelow splitright

" Time in milliseconds to wait for a mapped sequence to complete,
" see https://unix.stackexchange.com/q/36882/221410 for more info
set timeoutlen=500

set updatetime=100  " For CursorHold events

" Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
set noswapfile

" General tab settings
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set noexpandtab     " expand tab to spaces so that tabs are spaces

" Set matching pairs of characters and highlight matching brackets
set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》

set number relativenumber  " Show line number and relative line number

" Ignore case in general, but become case-sensitive when uppercase is present
set ignorecase smartcase

" File and script encoding settings for vim
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Character to show before the lines that have been soft-wrapped
set showbreak=↪

" Disable showing current mode on command line since statusline plugins can show it.
set noshowmode

set fileformats=unix,dos  " Fileformats to use for new files

set visualbell noerrorbells  " Do not use visual and errorbells
set history=500  " The number of command and search history to keep

" Use list mode and customized listchars
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣

set virtualedit=block  " Virtual edit is useful for visual block edit

" External program to use for grep command
if executable('rg')
	set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
	set grepformat=%f:%l:%c:%m
endif

" Enable true color support. Do not set this option if your terminal does not
" support true colors! For a comprehensive list of terminals supporting true
" colors, see https://github.com/termstandard/colors and https://gist.github.com/XVilka/8346728.
set termguicolors

set nowrap

set signcolumn=auto

" 高亮行列
set cursorcolumn
set cursorline

" 不高亮搜索结果
set nohlsearch

let g:clipboard = {
			\   'name': 'WslClipboard',
			\   'copy': {
			\      '+': 'clip.exe',
			\      '*': 'clip.exe',
			\    },
			\   'paste': {
			\      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			\      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			\   },
			\   'cache_enabled': 0,
			\ }

" c 头文件文件类型默认是 cpp
let g:c_syntax_for_h = 1

