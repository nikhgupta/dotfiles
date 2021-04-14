" Expected:    restores history, registers, etc. when a file is loaded {{{
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
" }}}
" Expected:    restores editor's window's size, as well {{{
  if has('mksession')
    set sessionoptions+=resize
  endif
" }}}
" Expected:    remembers a long history of commands and searches performed {{{
  set history=1000
" }}}
" Expected:    restore cursor position on opening a file {{{
  augroup restore_cursor
    au!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
                          \ | exe "normal! g`\"" | endif
  augroup end
" }}}
" " Modernize:   automatically, saves and restores editor sessions {{{
"   " NOTE: vim-misc is required for vim-session
"   Plug 'xolox/vim-misc'
"   Plug 'xolox/vim-session'
"   let g:session_autoload = 'yes'
"   let g:session_autosave = 'yes'
"   " let g:session_default_overwrite = 1
"   let g:session_default_to_last = 1
"   " let g:session_command_aliases = 1

"   nnoremap <leader>QA :call SaveSessionWithPrompt()<CR>:qall<CR>
"   " Function: save session by prompting the user for a session name {{{
"   function! SaveSessionWithPrompt()
"     " guess name from current session, if any
"     let name = xolox#session#find_current_session()
"     let is_tab_scoped = xolox#session#is_tab_scoped()

"     " ask user for a session name, otherwise
"     if empty(name)
"       let default_name = ''
"       if g:session_default_name
"         let default_name = g:session_default_name
"       endif

"       call inputsave()
"       let name = input('save session? by what name? ', default_name)
"       call inputrestore()
"     endif

"     " use the default session name, otherwise
"     if empty(name) && g:session_default_name
"       let name = g:session_default_name
"     endif

"     " save the given session
"     if xolox#session#is_tab_scoped()
"       call xolox#session#save_tab_cmd(name, '!', 'SaveTabSession')
"     else
"       call xolox#session#save_cmd(name, '!', 'SaveSession')
"     endif

"   endfunction
"   " }}}
" " }}}

