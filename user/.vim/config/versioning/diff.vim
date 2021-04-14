" Mappings:    view changes in the current buffer as a diff {{{
  " Function: View changes in the current buffer {{{
  function! DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  endfunction " }}}
  nnoremap <leader>ds :call DiffWithSaved()<CR>
" }}}
