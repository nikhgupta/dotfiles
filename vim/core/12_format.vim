" automatically, indents code when editing code
set autoindent                  " always set autoindenting on
set shiftwidth=2                " number of spaces to use for autoindenting
set copyindent                  " copy the previous indentation on autoindenting
set shiftround                  " use multiple of 'sw' when indenting with '<' and '>'
set smarttab                    " insert tabs on start of line acc to 'sw' not 'ts'

" use Q for formatting the current paragraph (or visual selection)
let g:which_key_map['=']['p'] = 'format current paragraph'
nnoremap <silent> <leader>=p gqap
vnoremap <silent> <leader>=p gq

" auto-indent the entire document, and jump back to current location
nnoremap <leader>=b ggVG=
let g:which_key_map['=']['b'] = 'format current buffer'
