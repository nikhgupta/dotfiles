" Essential:   has built-in smart search feature, which searches as you type {{{
  set ignorecase                  " makes searches ignore case
  set smartcase                   " if pattern has uppercase, be case-sensitive
  set wrapscan                    " search continues after the end of file
  set magic                       " use magic mode when searching/replacing
  set gdefault                    " search/replace globally (on a line) by default
  set incsearch                   " show search matches as you type
  if g:is_gui || &t_Co > 2 | set hlsearch | endif
  " clears the search register
  nmap <silent> <leader><cr> :nohlsearch<CR>
  Plug 'vim-scripts/IndexedSearch'
" }}}
" Expedite:    allows '*' or '#' keys to search for current word in normal or visual modes {{{
  Plug 'nelstrom/vim-visual-star-search'
" }}}
" Expedite:    allows replacing multiple variants of a word in a single go {{{
  " Supports converting to and from snake_case, camelCase, MixedCase & UPPER_CASE
  Plug 'tpope/vim-abolish'
" }}}
" Upgrade:     prefers 'rimgrep' over 'ack' for searching, when possible {{{
  if executable('rg')
    let g:ptprg='rg --vimgrep -S'
    set grepprg=rg\ --vimgrep\ -S
    Plug 'jremmen/vim-ripgrep'
    nnoremap <leader>a :Rg <Space>
  elseif executable('pt')
    Plug 'nazo/pt.vim'
    let g:ptprg='pt --vimgrep -S'
    set grepprg=pt\ --vimgrep\ -S
    nnoremap <leader>a :Pt <Space>
  elseif executable('ag')
    Plug 'rking/ag.vim'
    let g:agprg='ag --vimgrep -S'
    set grepprg=ag\ --vimgrep\ -S
    nnoremap <leader>a :Ag <Space>
  elseif executable('ack')
    Plug 'mileszs/ack.vim'
    nnoremap <leader>a :Ack --smart-case<Space>
  endif
" }}}
" Mappings:    display lines with keyword under cursor and ask to jump on one {{{
  " FIXME: when quitting from this command via <Esc>, it takes us to the first
  " match, instead of keeping the cursor in place.
  nmap <Leader>fs [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" }}}
" Mappings:    pull word under cursor into LHS of a substitute (for quick search and replace) {{{
  nmap <leader>fr :%s#\<<C-r>=expand("<cword>")<CR>\>#
" }}}

