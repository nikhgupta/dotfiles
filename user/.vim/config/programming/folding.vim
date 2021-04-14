" Personalize: display informative text when code is folded {{{
  " Function: Text to display on folded lines {{{
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
  set foldtext=MyFoldText()       " function for text that appears over folds
" }}}
" Expected:    has support for code folding (default: based on indentation) {{{
  set nofoldenable                " do not enable folding, by default
  set foldcolumn=0                " add a fold column to the left of line-numbers
  set foldlevel=0                 " folds with a higher level will be closed
  set foldlevelstart=10           " start out with everything open
  set foldmethod=indent           " create folds based on indentation
  set foldnestmax=7               " deepest fold is 7 levels
  set foldminlines=1              " do not fold single lines, fold everything else
  " which commands trigger auto-unfold
  set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
" }}}
" Expedite:    Mapping: toggle fold on the current fold using a space {{{
  nnoremap <Space> za
  vnoremap <Space> za
" }}}
" Mappings:    allows to quickly fold text at a specific level {{{
  nmap <leader>f0 :set foldlevel=0<CR>
  nmap <leader>f1 :set foldlevel=1<CR>
  nmap <leader>f2 :set foldlevel=2<CR>
  nmap <leader>f3 :set foldlevel=3<CR>
  nmap <leader>f4 :set foldlevel=4<CR>
  nmap <leader>f5 :set foldlevel=5<CR>
  nmap <leader>f6 :set foldlevel=6<CR>
  nmap <leader>f7 :set foldlevel=7<CR>
  nmap <leader>f8 :set foldlevel=8<CR>
  nmap <leader>f9 :set foldlevel=9<CR>
" }}}
" Tweak:       doesn't screw up folds when inserting text {{{
  " Don't screw up folds when inserting text that might affect them, until
  " leaving insert mode. Foldmethod is local to the window. Protect against
  " screwing up folding when switching between windows.
  " http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
  augroup FixFoldInsert
    au!
    autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod |
                        \ setlocal foldmethod=manual | endif
    autocmd InsertLeave,WinLeave * if exists('w:last_fdm') |
                                \ let &l:foldmethod=w:last_fdm |
                                \ unlet w:last_fdm | endif
  augroup end
" }}}

