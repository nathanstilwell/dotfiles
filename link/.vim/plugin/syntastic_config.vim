"
"   Syntastic
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Use Eslint for JavaScript
let g:syntastic_javascript_checkers = ['eslint']

" Use tidy for HTML
let g:syntastic_html_tidy_exec = '/usr/local/bin/tidy'
