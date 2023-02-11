" loads tag file when found, and adds some convenient mappings
set tags+=./tags,tags;/         " find and load tags file up until root
set tags+=./.tags,.tags;/         " find and load tags file up until root

" let g:gutentags_cache_dir = '/tmp/vim/tags_cache'
let g:gutentags_ctags_extra_args = ['--fields=+ainKz']
" let g:gutentags_ctags_executable_ruby = 'ripper-tags'
let g:gutentags_trace = 1
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']

let g:gutentags_file_list_command = {
      \   'markers': {
      \     '.git': 'git ls-files',
      \   },
      \ }

if executable('universal-ctags')
  let g:gutentags_ctags_executable = system('which universal-ctags')
elseif executable('ctags')
  let g:gutentags_ctags_executable = system('which ctags')
endif

nnoremap <C-]> g<C-]>
