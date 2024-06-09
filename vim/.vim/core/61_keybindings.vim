" adds bash like key mappings in command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" swaps generic most used key mappings with analogous mappings
" Since I never use the ; key anyway, this is a real optimization for almost
" all Vim commands, since we don't have to press that annoying Shift key that
" slows the commands down
nnoremap ; :

" Swap implementations of ` and ' jump to markers
nnoremap ' `
nnoremap ` '

" Swap implementations of 0 and ^
nnoremap 0 ^
nnoremap ^ 0

" avoids any accidental hits with mappings
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

" provides some easier movement related mappings
" remap j and k to act as expected when used on long, wrapped, lines
noremap j gj
noremap k gk

" jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %

" has mappings to perform everyday tasks quicker
" quickly close the current window
let g:which_key_map.x.w = 'Close current window'
noremap <leader>xw :q<CR>

" Switch between the last two files
let g:which_key_map.t.e.b = 'Switch between last 2 buffers'
let g:which_key_map["\'"] = 'Switch between last 2 buffers'
nnoremap <leader>teb <C-^>
nnoremap <leader>' <C-^>

" sudo to write
cmap w!! w !sudo tee % >/dev/null

" quick save a file
let g:which_key_map.w.f = 'Save current file'
nnoremap <leader>wf :w!<CR>

" provides a mapping to save file after removing all trailing whitespace
" replaces all hard tabs and ^M to spaces, and then removes trailing WS.
" restores cursor position by setting a marker
let g:which_key_map.w.F = 'Save current file removing trailing whitesapce'
nnoremap <silent> <leader>wF  mw:%s/\v<C-v><C-m>//e<CR>:retab<CR>:%s/\s\+$//e<CR>:nohlsearch<CR>:w<CR>`w

" Quickly toggle in/out the QuickFix window
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
let g:which_key_map.t.u.q = 'Toggle QuickFIx'
nmap <silent> <leader>tuq :QFix<CR>

" " insert the current time by pressing <F8>
" nnoremap <leader> "=strftime("%d-%m-%y %H:%M:%S")<CR>P
" inoremap <F8> <C-R>=strftime("%d-%m-%y %H:%M:%S")<CR>

if g:is_mac && g:is_gui
  " indentation related
  omap <D-]> >>
  omap <D-[> <<
  nmap <D-]> >>
  nmap <D-[> <<
  vmap <D-]> >gv
  vmap <D-[> <gv
  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

  " bubble lines up/down
  nmap <D-k> [e
  nmap <D-j> ]e
  vmap <D-k> [egv
  vmap <D-j> ]egv

  " map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt
endif
