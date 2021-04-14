" Advanced:    loads tag file when found, and adds some convenient mappings {{{
  set tags+=./tags,tags;/         " find and load tags file up until root
  set tags+=./.tags,.tags;/         " find and load tags file up until root
  " Plug 'ludovicchabant/vim-gutentags'
  " let g:gutentags_cache_dir = '~/.tags_cache'

  " mappings:
  " TODO: what does this correspond to?
  nnoremap <silent> <leader>j :tnext<cr>zt
  nnoremap <silent> <leader>J :tprev<cr>zt
  nnoremap <silent> <leader>k :pop<cr>zt
  map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
  map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" }}}

