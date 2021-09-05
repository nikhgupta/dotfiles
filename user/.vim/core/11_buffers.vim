" hide buffers instead of closing them
set hidden   " means that current buffer can be put to background without being written; and that marks and undo history are preserved.

" provides split editing behaviour, in an expected manner
set splitbelow                  " puts new split windows to the bottom of the current
set splitright                  " puts new vsplit windows to the right of the current
set equalalways                 " split windows are always of eqal size
set switchbuf=useopen,split     " use existing buffer or else split current window
set winheight=7               " squash splits or windows to a separator when minimized
set winwidth=30               " squash splits or windows to a separator when minimized
set winminheight=3              " squash splits or windows to a status bar only when minimized
set winminwidth=12               " squash splits or windows to a separator when minimized

" resizes splits when the window is resized
augroup resize_splits
  au!
  au VimResized * :wincmd =
augroup end

" only opens 15 tabs when using '-p' CLI switch for the editor
set tabpagemax=15

" for easy control and navigation of windows
" resize splits/windows quickly

let g:which_key_map['<C-w>']['='] = 'Equalize splits'
let g:which_key_map['<C-w>']['<C-=>'] = 'Equalize splits'
let g:which_key_map['<C-w>']['<C-m>'] = 'Maximize current split'
map <C-W><C-=> <C-W>=
map <C-W><C-M> <C-W>999+<C-W>999>

" easy window navigation
let g:which_key_map['<C-h>'] = 'Move to left split'
let g:which_key_map['<C-j>'] = 'Move to bottom split'
let g:which_key_map['<C-k>'] = 'Move to right split'
let g:which_key_map['<C-l>'] = 'Move to top split'
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" easy window navigation with enlarged viewport (10 lines for other windows)
let g:which_key_map['<C-w>']['<C-h>'] = 'Move to left split and maximize'
let g:which_key_map['<C-w>']['<C-j>'] = 'Move to bottom split and maximize'
let g:which_key_map['<C-w>']['<C-k>'] = 'Move to right split and maximize'
let g:which_key_map['<C-w>']['<C-l>'] = 'Move to top split and maximize'
map <C-W><C-H> <C-W>h<C-W><bar>
map <C-W><C-J> <C-W>j<C-W>_
map <C-W><C-K> <C-W>k<C-W>_
map <C-W><C-L> <C-W>l<C-W><bar>

let g:which_key_map['<C-w>']['T'] = 'Open a new tab'
let g:which_key_map['<C-w>']['<C-t>'] = 'Open a new tab'
map <C-W><C-T> <C-W>T

" easily switch/rotate windows
" for window layout: __|---
let g:which_key_map['<C-w>']['<space>'] = 'Rotate window layout'
map <C-W><space> <C-W>t<C-W>J<C-W>t<C-W>H

" " easily jump to a new buffer
" nnoremap <leader>fb :buffers<CR>:buffer<Space>
" nnoremap <leader>e3 :e#

" " open a new buffer with current file & switch to it
" nnoremap <leader>wh <C-w>s
" nnoremap <leader>wv <C-w>v<C-w>l

" " open a new buffer with previous file & switch to it
" nnoremap <leader>ph :execute 'rightbelow split' bufname('#')<cr>
" nnoremap <leader>pv :execute 'leftabove vsplit' bufname('#')<cr>
