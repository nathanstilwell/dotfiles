"
"   Indent Guides
"

" Enable Plugin on start up
let g:indent_guides_enable_on_vim_startup = 1

" Set custom colors for indent guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236
