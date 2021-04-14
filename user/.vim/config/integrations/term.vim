map <leader>` :term<CR>
map <leader>: :term<space>

" Expected:    uses a faster tty (terminal) & sets it title as per the file {{{
  set title                         " change the terminal's title
  set ttyfast                       " always use a fast terminal
" }}}
" Essential:   integrates with the user's login shell {{{
  " NOTE: DO NOT ENABLE INTERACTIVE SHELL OR TERMINAL VIM WILL SUSPEND ITSELF.
  " NOTE: For this reason, important environment variables, rbenv initialization,
  "       etc. must be placed inside ~/.zprofile, so that VIM can read them.
  if !g:is_windows
    if !empty('$SHELL')
      set shell=$SHELL\ -l
    elseif executable('zsh')
      set shell=zsh\ -l               " use a ZSH login shell
    elseif executable('bash')
      set shell=bash\ -l              " use a Bash login shell
    else
      set shell=/bin/sh
    endif
  endif
" }}}
" " Tweak:       sets appropriate terminal colors for the terminal {{{
"   " set appropriate terminal colors
"   if &t_Co > 2 && &t_Co < 16
"     set t_Co =16
"   elseif &t_Co > 16
"     set t_Co =256
"   endif
" " }}}
