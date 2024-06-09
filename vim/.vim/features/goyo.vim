Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

" zen or distraction free mode
function! GoyoEnter()
  if exists('$TMUX')
    silent !tmux set status off
  endif
  call airline#extensions#whitespace#disable()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  start
endfunction

function! GoyoLeave()
  if exists('$TMUX')
    silent !tmux set status on
  endif
  call airline#extensions#whitespace#init()
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang | qa! | else | qa | endif
  endif
endfunction

augroup GoyoFix
  autocmd!
  autocmd User GoyoEnter nested set eventignore=FocusGained
  autocmd User GoyoLeave nested set eventignore=
  autocmd User GoyoEnter nested call GoyoEnter()
  autocmd User GoyoLeave nested call GoyoLeave()
augroup END

" mappings
let g:which_key_map.o.a.g = 'close goyo'
nnoremap <silent> <leader>oag :Goyo!<CR>

let g:which_key_map.x.a.g = 'open goyo'
nnoremap <silent> <leader>qag :Goyo<CR>
