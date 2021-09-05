" allows pasting code easily, formats it, and reselects it for quick alignment
" function: paste using paste mode
function! PasteWithPasteMode(keys)
  if &paste
    execute("normal " . a:keys)
  else
    " Enable paste mode and paste the text, then disable paste mode.
    set paste
    execute("normal " . a:keys)
    set nopaste
  endif
endfunction
let g:which_key_map.y.p = 'paste with Paste mode below line'
let g:which_key_map.y.P = 'paste with Paste mode above line'
nnoremap <silent> <leader>yp :call PasteWithPasteMode('p')<CR>`[v`]=`[v`]
nnoremap <silent> <leader>yP :call PasteWithPasteMode('P')<CR>`[v`]=`[v`]

" store and cycle through yanked text strings
Plug 'maxbrunsfeld/vim-yankstack'
" do not use meta keys
let g:yankstack_map_keys = 0
" cycle through yanks
let g:which_key_map.y.n = 'cycle clipboard contents backwards'
let g:which_key_map.y.N = 'cycle clipboard contents forwards'
nmap <leader>yn <Plug>yankstack_substitute_older_paste
nmap <leader>yN <Plug>yankstack_substitute_newer_paste
