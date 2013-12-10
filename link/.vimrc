" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"
" General Config
"
set title
set number
set history=1000
set hidden
set autochdir
set encoding=utf-8
set visualbell
set autoread

set backspace=indent,eol,start
set autoindent
set smartindent
set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab

"
" Turn Off Swap files
"
set noswapfile
set nobackup
set nowb

"
" Pathogen
"
"execute pathogen#infect()
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

syntax enable
set background=dark
colorscheme Tomorrow

autocmd BufWritePre * :%s/\s\+$//e



