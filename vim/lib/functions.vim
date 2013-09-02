" Custom Functions that provide some special behaviour
" get current directory path {{{
function! CurDir()
    return substitute(getcwd(), $HOME, "~", "")
endfunction
" }}}
" Text to display on folded lines {{{
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
endfunction " }}}
" View changes in the current buffer {{{
command! DiffSaved call s:DiffWithSaved()
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction " }}}
" Pulsate the line containing the cursor {{{
function! PulseCursorLine()
  let current_window = winnr()

  windo set nocursorline
  execute current_window . 'wincmd w'

  setlocal cursorline

  redir => old_hi
  silent execute 'hi CursorLine'
  redir END
  let old_hi = split(old_hi, '\n')[0]
  let old_hi = substitute(old_hi, 'xxx', '', '')

  hi CursorLine guibg=#3a3a3a
  redraw
  sleep 20m

  hi CursorLine guibg=#4a4a4a
  redraw
  sleep 30m

  hi CursorLine guibg=#3a3a3a
  redraw
  sleep 30m

  hi CursorLine guibg=#2a2a2a
  redraw
  sleep 20m

  execute 'hi ' . old_hi

  windo set cursorline
  execute current_window . 'wincmd w'
endfunction
" }}}
" Append a modeline in the current buffer {{{
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
        \ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction " }}}
" Relative line numbering for the nerds :P {{{
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunction " }}}
" Quickly toggle in/out the QuickFix window {{{
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction " }}}
" Detect Python vs Django-Python based on python content {{{
function! s:DetectPythonVariant()
  let n = 1
  while n < 50 && n < line("$")
    " check for django
    if getline(n) =~ 'import\s\+\<django\>' || getline(n) =~ 'from\s\+\<django\>\s\+import'
      set ft=python.django
      "set syntax=python
      return
    endif
    let n = n + 1
  endwhile
  " go with html
  set ft=python
endfunction " }}}
" Detect HTML vs Django templates and set filetype accordingly {{{
function! s:DetectHTMLVariant()
  let n = 1
  while n < 50 && n < line("$")
    " check for django
    if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
      set ft=htmldjango.html
      return
    endif
    let n = n + 1
  endwhile
  " go with html
  set ft=html
endfunction " }}}
" get whether PasteMode is on or off (used for statusline purposes) {{{
function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction
" }}}