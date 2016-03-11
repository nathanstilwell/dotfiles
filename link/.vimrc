" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"
"   Pathogen
"
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

"
"   Colors
"
"   using duotone-dark from atelierbram/vim-colors_duotones
set background=dark
colorscheme duotone-dark

"
"   Set up
"

set number            " line numbers
set history=10000     " moar history
set hidden            " allow unsaved background buffers
set autoread          " read when a file is changed
set ruler             " show current position
set autochdir         " change to directory of the open file
set encoding=utf-8    " file encoding
set incsearch         " incremental search as you type
set hlsearch          "highlight search results"
set showmatch         " matching brackets
"
"   Turn off swap files
"
set noswapfile
set nobackup
set nowritebackup
"
"   Show whitespace
"
set list
set listchars=eol:¬,tab:│─,trail:◇,extends:…,precedes:…

syntax on

filetype plugin indent on
