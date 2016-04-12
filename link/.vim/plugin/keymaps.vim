"
"   Key maps
"

" Map leader to Space
let mapleader = "\<Space>"

" Split movement
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" Clears trailing whitespace
map <Leader><Space> :%s/\s\+$//<CR>:let @/=''<CR>

" Buffers
nmap <leader>l :bnext<cr>
nmap <leader>h :bprevious<cr>
nmap <leader>w :bd<cr>

" Turn on copy mode (hide lines and whitespace)
nmap <silent> <leader>p  :set list! <BAR> set number! <CR>

" Working with tabs
nmap t% :tabedit %<CR>
nmap td :tabclose<CR>

" For doing merges
nnoremap <leader><Left> :diffg LO <CR>
nnoremap <leader><Right> :diffg RE <CR>
nnoremap <leader><Down> :diffg BA <CR>
nnoremap <leader><Up> :diffupdate <CR>

