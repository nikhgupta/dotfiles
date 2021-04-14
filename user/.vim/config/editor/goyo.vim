Plug 'junegunn/goyo.vim'

" Personalize: zen or distraction free mode
function! GoyoEnter()
  if g:is_gui
    # colorscheme onehalfdark
    set guifont=Fira\ Code\ 18
    if g:is_mac | set guifont=FiraCode-Regular:h22 | endif
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  call airline#extensions#whitespace#disable()
  hi! CursorLine guibg=bg ctermbg=bg
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  start
endfunction
function! GoyoLeave()
  if g:is_gui
    # colorscheme snazzy
    set guifont=Fira\ Code\ 12
    if g:is_mac | set guifont=FiraCode-Regular:h15 | endif
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
  call airline#extensions#whitespace#init()
  hi! CursorLine term=underline ctermbg=236 guibg=#3a3d4d guisp=#3a3d4d
  " Quit Vim if this is the only remaining buffer
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

