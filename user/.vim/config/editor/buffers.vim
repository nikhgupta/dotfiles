" Recommend:   hide buffers instead of closing them {{{
  set hidden   " means that current buffer can be put to background without being written; and that marks and undo history are preserved.
" }}}
" Expected:    provides split editing behaviour, in an expected manner {{{
  set splitbelow                  " puts new split windows to the bottom of the current
  set splitright                  " puts new vsplit windows to the right of the current
  set equalalways                 " split windows are always of eqal size
  set switchbuf=useopen,split     " use existing buffer or else split current window
  set winheight=7               " squash splits or windows to a separator when minimized
  set winwidth=30               " squash splits or windows to a separator when minimized
  set winminheight=3              " squash splits or windows to a status bar only when minimized
  set winminwidth=12               " squash splits or windows to a separator when minimized
" }}}
" Expected:    resizes splits when the window is resized {{{
  augroup resize_splits
    au!
    au VimResized * :wincmd =
  augroup end
" }}}
" Advanced:    only opens 15 tabs when using '-p' CLI switch for the editor {{{
  set tabpagemax=15
" }}}
