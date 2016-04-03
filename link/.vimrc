" Use Vim settings, rather then Vi
" This must be first, because it changes other options as a side effect
set nocompatible

"
"   pathogen
"
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

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

" turn off swap files
set noswapfile
set nobackup
set nowritebackup

" show whitespace
set list
set listchars=tab:│─,trail:◇,extends:…,precedes:…

syntax on                  " turn that syntax highlighting on
filetype plugin indent on  " turn on indent plugin

"
"   Color Scheme
"
set background=dark    " Setting dark mode
colorscheme gruvbox    " https://github.com/morhetz/gruvbox

"
"   Key maps
"

" Split movement
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Clears trailing whitespace
map <Leader><Space> :%s/\s\+$//<CR>:let @/=''<CR>

" prev and next buffer
nmap <leader>l :bnext<cr>
nmap <leader>h :bprevious<cr>

" closing a buffer
nmap <leader>w :bd<cr>
