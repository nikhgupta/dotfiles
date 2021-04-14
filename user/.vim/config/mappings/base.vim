" Recommend:   adds bash like key mappings in command line {{{
  cnoremap <C-A> <Home>
  cnoremap <C-E> <End>
  cnoremap <C-K> <C-U>
  cnoremap <C-P> <Up>
  cnoremap <C-N> <Down>
" }}}
" Mappings:    insert the current time by pressing <F8> {{{
  nnoremap <F8> "=strftime("%d-%m-%y %H:%M:%S")<CR>P
  inoremap <F8> <C-R>=strftime("%d-%m-%y %H:%M:%S")<CR>
" }}}
" Recommend:   swaps generic most used key mappings with analogous mappings {{{
  " Since I never use the ; key anyway, this is a real optimization for almost
  " all Vim commands, since we don't have to press that annoying Shift key that
  " slows the commands down
  nnoremap ; :
  " nnoremap : ;    " not recommended

  " Swap implementations of ` and ' jump to markers
  nnoremap ' `
  nnoremap ` '

  " Swap implementations of 0 and ^
  nnoremap 0 ^
  nnoremap ^ 0
" }}}
" Recommend:   avoids any accidental hits with mappings {{{
  " avoid accidental hits of <F1> while aiming for <Esc>
  noremap  <F1> :echom "Use ". &keywordprg ." OR press 'K' to get help."<CR><Esc>
  noremap! <F1> <Esc>:echom "Use ". &keywordprg ." OR press 'K' to get help."<CR><Esc>a

  " avoid accidental hits of Shift key
  cmap Tabe tabe
  if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
  endif
" }}}
" Recommend:   has mappings to perform everyday tasks quicker {{{
  " quickly close the current window
  noremap <leader>wq :q<CR>

  " quick save a file
  nnoremap <leader>fs :w!<CR>

  " sudo to write
  cmap w!! w !sudo tee % >/dev/null

  " Switch between the last two files
  nnoremap <leader><leader> <C-^>
" }}}
" Recommend:   provides some easier movement related mappings {{{
  " remap j and k to act as expected when used on long, wrapped, lines
  noremap j gj
  noremap k gk

  " jump to matching pairs easily, with Tab
  nnoremap <Tab> %
  vnoremap <Tab> %

" }}}
" Recommend:   provides a mapping to save file after removing all trailing whitespace {{{
  " replaces all hard tabs and ^M to spaces, and then removes trailing WS.
  " restores cursor position by setting a marker
  nnoremap <silent> <leader>W  mw:%s/\v<C-v><C-m>//e<CR>:retab<CR>:%s/\s\+$//e<CR>:nohlsearch<CR>:w<CR>`w
" }}}
" Mappings:    toggles QuickFix window using '<leader>qf' {{{
  " Function: Quickly toggle in/out the QuickFix window {{{
  function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
      cclose
      unlet g:qfix_win
    else
      copen 10
      let g:qfix_win = bufnr("$")
    endif
  endfunction " }}}
  command! -bang -nargs=? QFix call QFixToggle(<bang>0)
  nmap <silent> <leader>qf :QFix<CR>
" }}}
