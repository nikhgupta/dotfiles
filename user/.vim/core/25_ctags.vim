" loads tag file when found, and adds some convenient mappings
set tags+=./tags,tags;/         " find and load tags file up until root
set tags+=./.tags,.tags;/         " find and load tags file up until root

Plug 'ludovicchabant/vim-gutentags'
" let g:gutentags_cache_dir = '/tmp/vim/tags_cache'
let g:gutentags_ctags_extra_args = ['--fields=+ainKz']

nnoremap <C-]> g<C-]>

