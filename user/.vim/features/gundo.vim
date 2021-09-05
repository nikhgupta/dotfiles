" allows traversing the undo/redo history as a graphical tree
Plug 'sjl/gundo.vim'

" toggle gundo window
let g:which_key_map.t.u.g = 'Toggle Gundo window'
nnoremap <leader>tug :GundoToggle<CR>

