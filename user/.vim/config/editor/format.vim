" Mappings:    use Q for formatting the current paragraph (or visual selection) {{{
  vmap Q gq
  nmap Q gqap
" }}}
" Mappings:    auto-indent the entire document, and jump back to current location {{{
  nmap <leader>b= ggVG=''
" }}}
" Expected:    automatically, indents code when editing code {{{
  set autoindent                  " always set autoindenting on
  set shiftwidth=2                " number of spaces to use for autoindenting
  set copyindent                  " copy the previous indentation on autoindenting
  set shiftround                  " use multiple of 'sw' when indenting with '<' and '>'
  set smarttab                    " insert tabs on start of line acc to 'sw' not 'ts'
" }}}

