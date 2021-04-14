" Function: parses line containing a plugin, and opens it in browser {{{
  function! VimFindPlugName(line, delimiter)
    let segments = split(a:line, a:delimiter)
    let seg_len  = len(segments)
    for seg in segments
      let index = index(segments, seg)
      if ( index + 1 < seg_len ) && ( seg =~ "Plug " || seg =~ "Bundle " )
        return segments[index + 1]
      endif
    endfor
  endfunction
  function! VimPlugBrowser(line)
    let plugin = VimFindPlugName(a:line, "'")
    if empty(plugin) | let plugin = VimFindPlugName(a:line, '"') | endif
    if empty(plugin)
      echom 'Could not find a plugin definition on this line.'
    else
      execute(":OpenBrowser https://github.com/" . plugin)
    endif
  endfunction
" }}}
" Specialize: binds <F6> to open plugin's Github URL in browser
" Test it here:   ' ''' ' \"''" \" '' \"' Plug 'nikhgupta/dotfiles' ''''''"
" or, here: callPlugFunction 'some/asd'
" FIXME: use regex and should also be able to open vim-scripts repos
augroup vim_plugin_browser
  au!
  au filetype vim noremap <silent> <buffer> <F6>
        \ <Esc>:call VimPlugBrowser(getline('.'))<CR>
augroup end

" Mapping:  quickly, edit or source the vim configuration
" edit the vimrc file
nmap <leader>e. :vs<CR>:e $MYVIMRC<CR>
" source the current file
nmap <leader>bs :source %<CR>:set foldenable<CR>:e!<CR>
" source a visual range
vmap <leader>bs y:@"<CR>:echo 'Sourced the selected range.'<CR>

" Mapping:  quickly navigate the help window
augroup help_window
  au!
  au filetype help nnoremap <buffer><cr> <c-]>
  au filetype help nnoremap <buffer><bs> <c-T>
  au filetype help nnoremap <buffer>q :q<CR>
augroup end

