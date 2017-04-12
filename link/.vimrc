" Use Vim settings, rather then Vi
" This must be first, because it changes other options as a side effect
set nocompatible

"
"   pathogen
"
" runtime bundle/vim-pathogen/autoload/pathogen.vim
" call pathogen#infect()
" call pathogen#helptags()

"
"  Plug - https://github.com/junegunn/vim-plug/
"
call plug#begin('~/.vim/plugged')

Plug 'dracula/vim'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

" Dockerfile.vim
" command-t
" ctrlp.vim
" editorconfig-vim
" vim-commentary
" vim-fugitive
" "vim-git
" vim-indent-guides
" vim-javascript
" vim-json
" vim-markdown
" vim-mustache-handlebars
" vim-pathogen
" vim-scala
" vim-surround
" vim-velocity

call plug#end()

"
"   Color Scheme
"
color dracula

"
"   set up
"

set number            " line numbers
set history=1000      " moar history
set hidden            " allow unsaved background buffers
set autoread          " read when a file is changed
set ruler             " show current position
set autochdir         " change to directory of the open file
set encoding=utf-8    " file encoding
set incsearch         " incremental search as you type
set hlsearch          " highlight search results"
set showmatch         " matching brackets
set wildmenu          " tab completion for files/buffers
set nowrap            " don't wrap lines
set laststatus=2      " turn on status line
set nohlsearch        " don't show previous search highlights

syntax on                  " turn that syntax highlighting on
filetype plugin indent on  " turn on indent plugin

" turn off swap files
set noswapfile
set nobackup
set nowritebackup

" show whitespace
set list
set listchars=tab:▸▸,trail:•,extends:→,precedes:←

" code folding
set foldmethod=indent   " fold based on indent
set foldnestmax=5       " deepest fold is 10 levels
set nofoldenable        " dont fold by default
set foldlevel=1         " when foldleve is positive, some folds are open

" Make backspace work
set backspace=indent,eol,start

" Something to make Facebook Reason / opam stuff work
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
