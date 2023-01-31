scriptencoding utf-8

" Plugin specification and lua stuff
lua require('plugins')

"""""""""""""""""""""""""""""" neoformat settings """""""""""""""""""""""
" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 0

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']
