" Essential:   has built-in persisting undo & redo, in branched form {{{
" Explaination: Persistence here means that your undo & redo data will be
" available even when you close the file, and try to edit it later.
  if has('persistent_undo')
    set undofile                  " have a long persisting undo data
    set undolevels=1000           " Maximum number of changes that can be undone
    set undoreload=10000          " Maximum number lines to save for undo on a buffer reload
    set undodir=~/.tmp/vim/undo,/tmp/vim/undo
  endif
" }}}
" Specialize:  allows traversing the undo/redo history as a graphical tree {{{
  Plug 'sjl/gundo.vim'

  " toggle gundo window
  nnoremap <leader>tgu :GundoToggle<CR>
" }}}
" Upgrade:     allows repeat operator (".") to work with plugins, too {{{
  " supports plugins namely: commentary, surround, abolish, unimpaired
  Plug 'tpope/vim-repeat'
" }}}
" Expected:    brings the cursor back when repeat command has been used {{{
  nmap . .`[
" }}}
" Expected:    allows using the repeat operator with visual selection {{{
  " see: http://stackoverflow.com/a/8064607/127816
  vnoremap . :normal .<CR>
" }}}
