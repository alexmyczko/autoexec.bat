syntax on
set background=dark

highlight Normal ctermbg=blue ctermfg=white guibg=blue guifg=white
highlight Comment ctermfg=cyan guifg=cyan
highlight Constant ctermfg=yellow guifg=yellow
highlight Statement ctermfg=white guifg=white gui=bold cterm=bold

" F2 to Save
nnoremap <F2> :w<CR>
inoremap <F2> <Esc>:w<CR>a

" F4 to Replace
nnoremap <F4> :%s/

" F7 to Search
nnoremap <F7> /

" F10 to Quit
nnoremap <F10> :q<CR>
inoremap <F10> <Esc>:q<CR>
