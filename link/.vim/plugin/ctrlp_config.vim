"
"   Ctrl P
"

" search open buffers for file
nnoremap <c-u> :CtrlPBuffer<cr>
let g:ctrlp_max_depth=40
let g:ctrlp_max_files=0
let g:ctrlp_working_path_mode=''
let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_cache_dir = $HOME . '/.ctrlp'
