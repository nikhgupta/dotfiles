Plug 'dense-analysis/ale'
let g:ale_fix_on_save = 1
let g:ale_use_global_executables = 1
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'html': ['remove_trailing_lines', 'trim_whitespace', 'prettier'],
      \ 'css': ['remove_trailing_lines', 'trim_whitespace', 'prettier'],
      \ 'javascript': ['remove_trailing_lines', 'trim_whitespace', 'prettier', 'eslint'],
      \ 'ruby': ['remove_trailing_lines', 'trim_whitespace', 'rubocop', 'rufo', 'sorbet', 'standardrb'],
      \ 'eruby': ['remove_trailing_lines', 'trim_whitespace', 'prettier'],
      \ }

let g:ale_javascript_prettier_options = '--single-quote --trailing-comma all'

let g:which_key_map.d.s = 'ALE Symbols'
nnoremap <leader>ds :ALESymbolSearch<space>
