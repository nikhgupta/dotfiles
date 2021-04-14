" Expected:    auto-formats comments, & insert comment markers where required {{{
  " automatically, insert comment marker, when possible:
  set formatoptions+=cro
  " allow 'gq' to format comments
  set formatoptions+=q
  " remove comment markers when joining lines
  silent! set formatoptions+=j    " gives error on some versions of vim 7.3 & lower
" }}}
" Expedite:    supports adding or removing comments for many languages {{{
  Plug 'tpope/vim-commentary'
  " From the FAQ:
  " > My favorite file type isn't supported!
  " > > Relax! You just have to adjust 'commentstring':
  "     autocmd FileType apache set commentstring=#\ %s
" }}}
