" Personalize: allows turning on paste mode with '<F2>' key {{{
  set pastetoggle=<F2>
" }}}
" Expedite:    allows pasting code easily, formats it, and reselects it for quick alignment {{{
  " function: paste using paste mode {{{
  function! PasteWithPasteMode(keys)
    if &paste
      execute("normal " . a:keys)
    else
      " Enable paste mode and paste the text, then disable paste mode.
      set paste
      execute("normal " . a:keys)
      set nopaste
    endif
  endfunction
  " }}}

  nnoremap <silent> <leader>p :call PasteWithPasteMode('p')<CR>`[v`]=`[v`]
  nnoremap <silent> <leader>P :call PasteWithPasteMode('P')<CR>`[v`]=`[v`]
" }}}
" Essential:   do share clipboard between editor and operating system {{{
  if g:is_nix && has('unnamedplus')
    set clipboard=unnamedplus,unnamed      " On Linux use + register for copy-paste
  elseif g:is_nvim && g:is_wsl && has('unnamedplus') && executable('win32yank.exe')
    set clipboard=unnamedplus,unnamed
  elseif g:is_wsl && executable('win32yank.exe')
    set clipboard=unnamed
    autocmd TextYankPost * call YankDebounced()

    function! Yank(timer)
      call system('win32yank.exe -i --crlf', @")
      redraw!
    endfunction

    let g:yank_debounce_time_ms = 500
    let g:yank_debounce_timer_id = -1

    function! YankDebounced()
      let l:now = localtime()
      call timer_stop(g:yank_debounce_timer_id)
      let g:yank_debounce_timer_id = timer_start(g:yank_debounce_time_ms, 'Yank')
    endfunction
  elseif has('unnamedplus')
    set clipboard=unnamedplus,unnamed
  else
    set clipboard+=unnamed                 " On mac and Windows, use * register for copy-paste
  endif
" }}}
" expected: highlight yanked text {{{
  Plug 'machakann/vim-highlightedyank'
  let g:highlightedyank_highlight_duration = 240
" }}}
" Specialize:  store and cycle through yanked text strings {{{
  Plug 'maxbrunsfeld/vim-yankstack'

  " do not use meta keys
  let g:yankstack_map_keys = 0
  " call yankstack#setup()                 " should happen after plugin indent?

  " for cycling what is pasted
  nmap <leader>pc <Plug>yankstack_substitute_older_paste

  " toggle YankStack window
  nnoremap <leader>tys :Yanks<CR>
" }}}
" Mappings:    reselects text that was just selected (or pasted) {{{
  nnoremap <leader>gv `[v`]
" }}}
" Expected:    pasting in visual mode replaces the selected text {{{
  vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
" }}}
