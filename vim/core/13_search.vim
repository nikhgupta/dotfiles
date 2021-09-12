" has built-in smart search feature, which searches as you type
set ignorecase                  " makes searches ignore case
set smartcase                   " if pattern has uppercase, be case-sensitive
set wrapscan                    " search continues after the end of file
set magic                       " use magic mode when searching/replacing
set gdefault                    " search/replace globally (on a line) by default
set incsearch                   " show search matches as you type
if g:is_gui || &t_Co > 2 | set hlsearch | endif

" clears the search register
let g:which_key_map.f.q = 'clear search'
nmap <silent> <leader>fq <Esc>:nohlsearch<CR>

" display search index
Plug 'google/vim-searchindex'

" allows replacing multiple variants of a word in a single go
" Supports converting to and from snake_case, camelCase, MixedCase & UPPER_CASE
Plug 'tpope/vim-abolish'

" pull word under cursor into LHS of a substitute (for quick search and replace)
let g:which_key_map.r.w = 'replace word under cursor'
nmap <leader>rw :%s#\<<C-r>=expand("<cword>")<CR>\>#

" prefers 'rimgrep' over 'ack' for searching, when possible
let g:which_key_map.f['/'] = 'find word'
let g:which_key_map.f.w = 'find word under cursor'

if executable('rg')
  let g:ptprg='rg --vimgrep -S'
  set grepprg=rg\ --vimgrep\ -S
elseif executable('pt')
  let g:ptprg='pt --vimgrep -S'
  set grepprg=pt\ --vimgrep\ -S
elseif executable('ag')
  let g:agprg='ag --vimgrep -S'
  set grepprg=ag\ --vimgrep\ -S
endif
