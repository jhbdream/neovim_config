set number

set completeopt=menu,menuone,noselect

let g:python3_host_prog="/usr/bin/python3"

" General tab settings
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=0    " number of spaces to use for autoindent
set noexpandtab     " not expand tab to spaces so that tabs are spaces
set backspace=indent,eol,start

" Set matching pairs of characters and highlight matching brackets
" set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》

" File and script encoding settings for vim
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Break line at predefined characters
set linebreak
" Character to show before the lines that have been soft-wrapped
set showbreak=↪
set wrap

" Disable showing current mode on command line since statusline plugins can show it.
set noshowmode

set fileformats=unix,dos  " Fileformats to use for new files

set visualbell noerrorbells  " Do not use visual and errorbells
set history=500  " The number of command and search history to keep

" Use list mode and customized listchars
set listchars=tab:‣\ ,trail:·

" Do not show "match xx of xx" and other messages during auto-completion
set shortmess+=c

" Do not show search match count on bottom right (seriously, I would strain my
" neck looking at it). Using plugins like vim-anzu or nvim-hlslens is a better
" choice, IMHO.
set shortmess+=S

" Disable showing intro message (:intro)
set shortmess+=I

" Completion behaviour
" set completeopt+=noinsert  " Auto select the first completion entry
set completeopt+=menuone  " Show menu even if there is only one item
set completeopt-=preview  " Disable the preview window

set pumheight=10  " Maximum number of items to show in popup menu
set pumblend=10  " pseudo transparency for completion menu

set winblend=0  " pseudo transparency for floating window

" Insert mode key word completion setting
set complete+=kspell complete-=w complete-=b complete-=u complete-=t

set virtualedit=block  " Virtual edit is useful for visual block edit

" Correctly break multi-byte characters such as CJK,
" see https://stackoverflow.com/q/32669814/6064933
set formatoptions+=mM

" External program to use for grep command
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

" set signcolumn=yes:1

filetype on
set nomodeline
set secure
set termguicolors
set shortmess+=I

set nocursorcolumn
set cursorline

syntax off
set number
set mouse=

nmap <C-S> :w!<CR>
vmap <C-S> <C-C>:w!<CR>
imap <C-S> <Esc>:w!<CR>
nnoremap <C-E> :pop<CR>

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

" Doxgen
let g:DoxygenToolkit_briefTag_pre="@brief "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@returns "
let g:DoxygenToolkit_authorName="jihb "

tnoremap <Esc> <C-\><C-n>
