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
set hlsearch          " highlight search results"
set showmatch         " matching brackets
set wildmenu          " tab completion for files/buffers
set nowrap            " don't wrap lines
set laststatus=2      " Status line

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
set listchars=tab:│─,trail:◇,extends:…,precedes:…

syntax on

filetype plugin indent on

"
"   Better Split movement
"

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"
" Ctrl P
"

"search open buffers for file
nnoremap <c-u> :CtrlPBuffer<cr>

let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 40

"
"   Nerd Tree
"

" Navigate to file in nerdtree
let NERDTreeShowHidden=1

map <leader>r :NERDTreeFind<cr>
nmap <leader>ne :NERDTreeToggle<cr>

"
"   Air Line
"

" set airline theme
let g:airline_theme='luna'
