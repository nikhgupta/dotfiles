Plug 'dense-analysis/ale'

let g:ale_sign_error = '◉'
let g:ale_sign_warning = '◉'
let g:ale_sign_info = '◉'
let g:ale_echo_msg_format = '%linter%: %code: %%s [%severity%]'

let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = "●⬤  "

let g:ale_lint_delay = 400
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_filetype_changed = 0

let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_use_global_executables = 1

let g:ale_hover_cursor = 0
let g:ale_hover_to_preview = 1
let g:ale_hover_to_floating_preview = 1
" let g:ale_floating_window_border=['│', '─', '╭', '╮', '╯', '╰']
" let g:ale_cursor_detail=1
" let g:ale_close_preview_on_insert=1
" let g:ale_set_quickfix = 1
let g:ale_maximum_file_size = 500000  " Don't lint large files (> 500KB), it can slow things down

let g:ale_typescript_standard_use_global = 1
let g:ale_typescript_tslint_use_global = 1
let g:ale_typescript_tsserver_use_global = 1
let g:ale_typescript_tslint_executable = 'tslint'
let g:ale_ruby_rubocop_executable = 'bundle'

let g:ale_linters                = {}
let g:ale_linters['json']        = ['fixjson']
let g:ale_linters['jsonc']       = ['fixjson']

let g:ale_fixers                 = {}
let g:ale_fixers['*']            = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers.c               = ['clang-format']
let g:ale_fixers.cpp             = ['clang-format']
let g:ale_fixers.css             = ['stylelint', 'prettier']
let g:ale_fixers.elixir          = ['mix_format']
let g:ale_fixers.go              = ['gofmt', 'goimports']
let g:ale_fixers.graphql         = ['prettier']
let g:ale_fixers.html            = ['prettier']
let g:ale_fixers.javascript      = ['eslint', 'prettier']
let g:ale_fixers.javascriptreact = ['eslint', 'prettier']
let g:ale_fixers.json            = ['prettier', 'fixjson']
let g:ale_fixers.jsonc           = ['prettier', 'fixjson']
let g:ale_fixers.markdown        = ['prettier']
let g:ale_fixers.python          = ['autopep8']
let g:ale_fixers.ruby            = ['rubocop', 'rufo']
let g:ale_fixers.eruby           = ['prettier']
let g:ale_fixers.scss            = ['prettier']
let g:ale_fixers.sh              = ['shfmt']
let g:ale_fixers.typescript      = ['prettier']
let g:ale_fixers.typescriptreact = ['prettier']
let g:ale_fixers.yaml            = ['prettier']

let g:ale_javascript_prettier_options = '--single-quote --trailing-comma all --print-width 120'
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_typescript_prettier_use_local_config = 1
let g:ale_json_prettier_use_local_config = 1

let g:which_key_map.d.s = 'ALE Symbols'
nnoremap <leader>ds :ALESymbolSearch<space>

" better ale themes
augroup ale_fix_colors
  au!
  autocmd ColorScheme * hi ALEError gui=none
  autocmd ColorScheme * hi ALEWarning gui=none
  autocmd ColorScheme * hi! link ALEInfo CocInfoSign
  autocmd ColorScheme * hi! link ALEInfoSign CocInfoSign
  autocmd ColorScheme * hi! link ALEVirtualTextInfo CocInfoSign
  autocmd ColorScheme * hi! clear ALEInfoLine
augroup end
