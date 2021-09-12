" parses line containing a plugin, and opens it in browser
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

" binds <F6> to open plugin's Github URL in browser
augroup vim_plugin_browser
  au!
  au filetype vim noremap <silent> <buffer> <F6> <Esc>:call VimPlugBrowser(getline('.'))<CR>
augroup end

" quickly, edit or source the vim configuration
" edit the vimrc file
let g:which_key_map.v.e = 'Edit vimrc'
nmap <leader>ve :vs<CR>:e $MYVIMRC<CR>

" source the current file or visual range
let g:which_key_map.v.s = 'Source current file'
nmap <leader>vs :source %<CR>:set foldenable<CR>:e!<CR>:echo 'Sourced current buffer.'<CR>
vmap <leader>vs y:@"<CR>:echo 'Sourced the selected range.'<CR>

"  quickly navigate the help window
augroup help_window
  au!
  au filetype help nnoremap <buffer><cr> <c-]>
  au filetype help nnoremap <buffer><bs> <c-T>
  au filetype help nnoremap <buffer>q :q<CR>
augroup end


