" restores history, registers, etc. when a file is loaded
if has('viminfo')
  " ': Remember upto 500 files for which marks are remembered.
  " %: Save and restore the buffer list.
  " :: Remember upto 100 items in command-line history.
  " /: Remember upto 20  items in the search pattern history.
  " <: Remember upto 200 lines for each register.
  " f: Store file marks ('0 to '9 and 'A to 'Z)
  " Further, reading:  :h viminfo
  set viminfo='500,:100,@100,/20,f1,%,<200
  set viminfofile=$HOME/.viminfo
endif

" restores editor's window's size, as well
if has('mksession')
  set sessionoptions+=resize
endif

" remembers a long history of commands and searches performed
set history=1000

" restore cursor position on opening a file
augroup restore_cursor
  au!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g`\"" | endif
augroup end

