" ease-of-use related mappings {{{
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

" mappings created to avoid any accidental hits {{{
  " avoid accidental hits of <F1> while aiming for <Esc>
  map! <F1> <Esc>

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

" mappings that perform everyday tasks quicker {{{
  " quickly close the current window
  noremap <leader>q :q<CR>

  " quickly yanking a complete line
  nmap Y yy
" }}}

" movement related mappings {{{

  " use the damn hjkl keys
  map <up> <nop>
  map <down> <nop>
  map <left> <nop>
  map <right> <nop>

  " remap j and k to act as expected when used on long, wrapped, lines
  noremap j gj
  noremap k gk

  " jump to matching pairs easily, with Tab
  nnoremap <Tab> %
  vnoremap <Tab> %

  " toggle RelativeLineNumbers manually using Ctrl+n
  nnoremap <C-n> :call NumberToggle()<cr>

" }}}

" windows related mappings {{{

  " resize windows automatically
  map <leader>= <C-w>=

  " easy window navigation
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

  " easy window navigation with maximize
  map <leader><C-h> <C-w>h<C-w><bar>
  map <leader><C-j> <C-w>j<C-w>_
  map <leader><C-k> <C-w>k<C-w>_
  map <leader><C-l> <C-w>l<C-w><bar>

  " create a split buffer containing the current file and switch to it
  nnoremap <leader>ws <C-w>s<C-w>k
  nnoremap <leader>wv <C-w>v<C-w>l

  " speed up scrolling of the viewport slightly
  nnoremap <C-e> 2<C-e>
  nnoremap <C-y> 2<C-y>

  " Split previously opened file ('#') in a split window
  nnoremap <leader>sh :execute 'leftabove vsplit' bufname('#')<cr>
  nnoremap <leader>sl :execute 'rightbelow vsplit' bufname('#')<cr>

" }}}

" editing/formatting related mappings {{{

  " quick save a file
  nnoremap <leader>w :w!<CR>

  " sudo to write
  cmap w!! w !sudo tee % >/dev/null

  " strip all trailing whitespace from a file and save it
  nnoremap <silent> <leader>W  :%s/\v<C-v><C-m>//e<CR>:retab<CR>:%s/\s\+$//e<CR>:let @/=''<CR>:w<CR>

  " allow using the repeat operator with a visual selection (!)
  " http://stackoverflow.com/a/8064607/127816
  vnoremap . :normal .<CR>

  " quickly get out of insert mode without your fingers having to leave the
  " home row (either use 'jj' or 'jk')
  inoremap jj <Esc>
  inoremap jk <Esc>

  " toggle highlighting of cursor column - useful for manual indentation
  nnoremap <leader>cr :set cursorcolumn!<CR>

  " view changes in the current buffer as compared to the last saved document
  nnoremap <leader>ds :DiffSaved<CR>

  " quickly create new buffers with files from current directory
  " http://vimcasts.org/e/14
  cnoremap %% <C-R>=expand('%:h').'/'<cr>
  map <leader>ew :e %%
  map <leader>es :sp %%
  map <leader>ev :vsp %%
  map <leader>et :tabe %%

  " use Q for formatting the current paragraph (or visual selection)
  vmap Q gq
  nmap Q gqap

  " Visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv

  " auto-indent the entire document
  nmap <leader>fef ggVG=

  " quick alignment of text across the window-width
  nmap <leader>al :left<CR>
  nmap <leader>ar :right<CR>
  nmap <leader>ac :center<CR>

  " insert modeline after last line of the file
  nnoremap <silent> <leader>ml :call AppendModeline()<CR>

  " insert current time
  nnoremap <F5> "=strftime("%d-%m-%y %H:%M:%S")<CR>P
  inoremap <F5> <C-R>=strftime("%d-%m-%y %H:%M:%S")<CR>

  " underline the current line with '='
  nmap <silent> <leader>lu YpVr=<CR>

" }}}

" file system related mappings {{{

  " change Working Directory to that of the current file
  cmap cwd lcd %:p:h
  cmap cd. lcd %:p:h

  " create the directory containing the file in the buffer
  nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" }}}

" search/replace related mappings {{{

  " use really magic mode for search patterns
  " 01-09-13 03:03:06 - using `magic` mode, instead.
  " nnoremap / /\v
  " vnoremap / /\v

  " run Ack fast
  nnoremap <leader>a :Ack<Space>

  " clears the search register
  nmap <silent> <leader><cr> :nohlsearch<CR>

  " keep search matches in the middle of the window and pulse the line when moving
  " to them (no need to map to: Nzz hence)
  nnoremap <silent> n n:call PulseCursorLine()<cr>
  nnoremap <silent> N N:call PulseCursorLine()<cr>

  " search: display all lines with keyword under cursor and ask which one to jump to
  nmap <Leader>fs [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

  " replace: pull word under cursor into LHS of a substitute (for quick search and replace)
  nmap <leader>fr :%s#\<<C-r>=expand("<cword>")<CR>\>#
" }}}

" clipboard related mappings {{{

  " toggle paste mode on and off
  map <leader>pp :setlocal paste!<cr>

  " yank/paste to the OS clipboard with ,y and ,p
  " (not required, if using 'unnamed' clipboard on OS)
  nmap <leader>y "+y
  nmap <leader>Y "+yy
  nmap <leader>p "+p
  nmap <leader>P "+P

  " use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
  " yanked stack (also, in visual mode)
  nmap <silent> <leader>d "_d
  vmap <silent> <leader>d "_d

  " reselect text that was just pasted with ,v
  nnoremap <leader>v V`]

" }}}

" folding related mappings {{{

  " fold/unfold the current-fold using a space
  nnoremap <Space> za
  vnoremap <Space> za

  " code folding for a specific level
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

  " creating folds for tags in HTML
  nnoremap <leader>ft Vatzf

" }}}

" completion related mappings {{{

  " complete filenames in insert mode
  imap <C-f> <C-x><C-f>

  " complete lines from current buffer in insert mode
  imap <C-l> <C-x><C-l>

" }}}

" command line mappings {{{

  " bash like keys for the command line
  cnoremap <C-A> <Home>
  cnoremap <C-E> <End>
  cnoremap <C-K> <C-U>
  cnoremap <C-P> <Up>
  cnoremap <C-N> <Down>
" }}}

" ctags related mappings {{{
  nnoremap <silent> <leader>j :tnext<cr>zt
  nnoremap <silent> <leader>J :tprev<cr>zt
  nnoremap <silent> <leader>k :pop<cr>zt
  map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
  map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" }}}

" mappings that provide some expected behaviours {{{
  " make p in Visual mode replace the selected text with the yank register
  vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
" }}}

" mappings that provide some special behaviours {{{

  " open/close QuickFix window using <l>f
  nmap <silent> <leader>f :QFix<CR>

  " shortcut to jump to next conflict marker
  nmap <silent> <leader>co /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
  " nmap <silent> <leader>co /\v^[<\|=>]{7}( .*\|$)<CR>

  " Panic button
  nnoremap <f9> mzggg?G'z'          " rot13s the current buffer
" }}}

" Vim related mappings {{{

  " edit the vimrc file
  nmap <leader>vi :vs<CR>:e $MYVIMRC<CR>

  " edit the gvimrc file
  nmap <leader>vg :vs<CR>:e $MYGVIMRC<CR>

  " source the current file
  nmap <leader>vs :source %<CR>

" }}}

" OSX specific mappings {{{
if g:is_mac

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
" }}}

" abbreviations: {{{
  iabbr NG@  Nikhil Gupta
  iabbr WD@  Wicked Developers

  iabbr ng@  me@nikhgupta.com
  iabbr mg@  mestoic@gmail.com
  iabbr wd@  nikhil@wickeddevelopers.com

  iabbr ng/  http://nikhgupta.com/
  iabbr wd/  http://wickeddevelopers.com/
  iabbr gh/  http://github.com/
  iabbr ghn/ http://github.com/nikhgupta/

  iabbr nsig --<cr>Nikhil Gupta<cr>me@nikhgupta.com
  iabbr wsig --<cr>Nikhil Gupta<cr>nikhil@wickeddevelopers.com
" }}}
