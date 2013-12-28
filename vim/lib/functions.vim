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
" load default colorscheme depending on gui is running or not {{{
function! LoadDefaultVimColors()
  " reload colorscheme and related
  if has('gui_running')
    execute 'set background=' . g:colorschemes[0][1][2]
    execute 'colorscheme ' . g:colorschemes[0][1][0]
    let g:airline_theme = g:colorschemes[0][1][1]
  else
    execute 'set background=' . g:colorschemes[1][0][2]
    execute 'colorscheme ' . g:colorschemes[1][0][0]
    let g:airline_theme = g:colorschemes[1][0][1]
  endif
endfunction
" }}}
" create session with a prompt {{{
function! SaveSessionWithPrompt()
  " guess name from current session, if any
  let name = xolox#session#find_current_session()
  let is_tab_scoped = xolox#session#is_tab_scoped()

  " ask user for a session name, otherwise
  if empty(name)
    let default_name = ''
    if g:session_default_name
      let default_name = g:session_default_name
    endif

    call inputsave()
    let name = input('save session? by what name? ', default_name)
    call inputrestore()
  endif

  " use the default session name, otherwise
  if empty(name) && g:session_default_name
    let name = g:session_default_name
  endif

  " save the given session
  if xolox#session#is_tab_scoped()
    call xolox#session#save_tab_cmd(name, '!', 'SaveTabSession')
  else
    call xolox#session#save_cmd(name, '!', 'SaveSession')
  endif

endfunction
" }}}
" reload last session and restore vim colors {{{
function! ReloadSessionAndRestoreColors()
  if function_exists("xolox#session#auto_load")
    call xolox#session#auto_load()
  endif
  call LoadDefaultVimColors()
  if exists(g:airline_theme)
    call airline#load_theme(g:airline_theme)
  endif
endfunction
" }}}
" search for a pattern across multiple files {{{
function! SearchAcrossMultipleFiles(word)
  if strlen(a:word)
    let l:pattern = a:word
    echo "Searching for: " . l:pattern
  else
    let l:pattern = input("Give me a pattern: ")
  end
  let l:infiles = input("Give me patterns for files to search inside: ")
  let l:cmdline = ":lvim /" . l:pattern . "/gj" . l:infiles
  execute l:cmdline
  :lwindow
endfunction
" }}}
" load a random colorscheme {{{
function! LoadRandomColorScheme()
  let l:colorschemes = split(globpath(&rtp,"**/colors/*.vim"),"\n")
  let l:colorscheme  = l:colorschemes[localtime() % len(l:colorschemes)]
  let l:colorscheme  = fnamemodify(expand(l:colorscheme), ":t:r")
  if localtime() % 2 == 1
    let l:background = "dark"
  else
    let l:background = "light"
  endif
  execute "colorscheme " . l:colorscheme
  execute "set background=".l:background
  redraw
  echo "Loading colorscheme (".l:background."): " . l:colorscheme
endfunction
" }}}
