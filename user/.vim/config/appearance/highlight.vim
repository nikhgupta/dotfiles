" Personalize: highlight current line, but not the current column {{{
  set cursorline                  " highlight the current line for quick orientation
  set nocursorcolumn              " do not highlight the current column
  " toggle highlighting of cursor column - useful for manual indentation
  nnoremap <leader>tcc :set cursorcolumn!<CR>
" }}}
" Personalize: highlight column markers for several columns {{{
  if has('syntax')
    let &colorcolumn="+1,+21,+41,+81"
  end

" }}}
" Expedite:    allows to highlight indentation guides (default: off) {{{
  Plug 'nathanaelkane/vim-indent-guides'
  " NOTE: default map: <leader>ig
  nmap <silent> <Leader>tig <Plug>IndentGuidesToggle

  let g:indent_guides_guide_size  = 1
  let g:indent_guides_start_level = 2
" }}}
