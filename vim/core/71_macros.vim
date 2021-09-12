" provides replaying a macro linewise on a visual selection
" note that, the macro must be recorded in the `v` register
let g:which_key_map.q.v = 'Replay macro v on selected lines'
vnoremap <leader>qv :normal @v<CR>

