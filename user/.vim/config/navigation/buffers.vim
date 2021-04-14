" Expedite:    Mappings: for easy control and navigation of windows {{{
  " resize splits/windows quickly
  map <C-W><C-=> <C-W>=
  map <C-W><C-M> <C-W>999+<C-W>999>

  " easy window navigation
  map <C-H> <C-W>h
  map <C-J> <C-W>j
  map <C-K> <C-W>k
  map <C-L> <C-W>l

  " easy window navigation with enlarged viewport (10 lines for other windows)
  map <C-W><C-H> <C-W>h<C-W><bar>
  map <C-W><C-J> <C-W>j<C-W>_
  map <C-W><C-K> <C-W>k<C-W>_
  map <C-W><C-L> <C-W>l<C-W><bar>
  map <C-W><C-T> <C-W>T
  " easily switch/rotate windows
  " for window layout: __|---
  map <C-W><space> <C-W>t<C-W>J<C-W>t<C-W>H

  " easily jump to a new buffer
  nnoremap <leader>el :buffers<CR>:buffer<Space>
  nnoremap <leader>e3 :e#
" }}}
" Expedite:    Mappings: open a new buffer with current file & switch to it {{{
  nnoremap <leader>wh <C-w>s
  nnoremap <leader>wv <C-w>v<C-w>l
" }}}
" Expedite:    Mappings: open a new buffer with previous file & switch to it {{{
  nnoremap <leader>ph :execute 'rightbelow split' bufname('#')<cr>
  nnoremap <leader>pv :execute 'leftabove vsplit' bufname('#')<cr>
" }}}


