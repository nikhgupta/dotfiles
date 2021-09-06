" display informative text when code is folded
" Text to display on folded lines
function! MyFoldText()
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
  return line . ' ' . repeat("-",fillcharcount) . ' ' . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()       " function for text that appears over folds

" doesn't screw up folds when inserting text
" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
" http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
augroup FixFoldInsert
  au!
  autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod |
        \ setlocal foldmethod=manual | endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm') |
        \ let &l:foldmethod=w:last_fdm |
        \ unlet w:last_fdm | endif
augroup end

" allows to quickly fold text at a specific level
let g:which_key_map.z.1 = 'set fold level 0'
let g:which_key_map.z.2 = 'set fold level 1'
let g:which_key_map.z.3 = 'set fold level 2'
let g:which_key_map.z.4 = 'set fold level 3'
let g:which_key_map.z.5 = 'set fold level 4'
let g:which_key_map.z.6 = 'set fold level 5'
let g:which_key_map.z.7 = 'set fold level 6'
let g:which_key_map.z.8 = 'set fold level 7'
let g:which_key_map.z.9 = 'set fold level 8'
let g:which_key_map.z.0 = 'set fold level 9'
let g:which_key_map.z.z = 'set fold level 0'
let g:which_key_map.z.o = 'set fold level 9'
nmap <silent> <leader>zz :Fold<CR>:set foldlevel=0<CR>
nmap <silent> <leader>z1 :Fold<CR>:set foldlevel=0<CR>
nmap <silent> <leader>z2 :Fold<CR>:set foldlevel=1<CR>
nmap <silent> <leader>z3 :Fold<CR>:set foldlevel=2<CR>
nmap <silent> <leader>z4 :Fold<CR>:set foldlevel=3<CR>
nmap <silent> <leader>z5 :Fold<CR>:set foldlevel=4<CR>
nmap <silent> <leader>z6 :Fold<CR>:set foldlevel=5<CR>
nmap <silent> <leader>z7 :Fold<CR>:set foldlevel=6<CR>
nmap <silent> <leader>z8 :Fold<CR>:set foldlevel=7<CR>
nmap <silent> <leader>z9 :Fold<CR>:set foldlevel=8<CR>
nmap <silent> <leader>z0 :Fold<CR>:set foldlevel=9<CR>
nmap <silent> <leader>zo :Fold<CR>:set foldlevel=9<CR>
