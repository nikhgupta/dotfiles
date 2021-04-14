Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv' " gitk like functionality inside the editor

" Specialize:  highlights conflict markers & provides a way to jump to them {{{
  match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'  " highlight conflict markers

  " shortcut to jump to next conflict marker
  nmap <silent> <leader>co /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
  " nmap <silent> <leader>co /\v^[<\|=>]{7}( .*\|$)<CR>
" }}}
" Specialize:  git commit messages have spell check enabled, and text width of 72 chars {{{
  augroup git_files
    au!
    autocmd BufRead,BufNewFile GHI_* set ft=gitcommit
    autocmd FileType gitcommit setlocal spell textwidth=72
  augroup end
" }}}
" Specialize:  enables support to manage Github Gists from the editor {{{
  Plug 'mattn/webapi-vim'
  Plug 'mattn/vim-gist'
  let g:gist_clip_command = 'pbcopy'
  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 1
  let g:gist_post_private = 0
  let g:gist_get_multiplefile = 1
  let g:gist_show_privates = 1
  let g:github_user = $GITHUB_USER
  let g:github_token = $GITHUB_TOKEN
  let g:snips_author = "$NAME <$EMAIL>"
" }}}
" Specialize:  displays git diff in sign column, and easily add hunks for staging {{{
  Plug 'airblade/vim-gitgutter'
  " enable gitgutter by default
  let g:gitgutter_enabled = 1
  " but do not display signs by default
  let g:gitgutter_signs = 0
  " ignore whitespace
  let g:gitgutter_diff_args = '-w'
  " use the raw grep command
  " let g:gitgutter_grep_command = &grepprg
  " highlight hunks by default
  " let g:gitgutter_highlight_lines = 1
  " let vim be snappier - don't lag.
  let g:gitgutter_realtime = 0
  let g:gitgutter_eager = 0
  let g:gitgutter_async = 1

  " remap mappings
  let g:gitgutter_map_keys = 0
  nmap ]h <Plug>(GitGutterNextHunk)
  nmap [h <Plug>(GitGutterPrevHunk)
  nmap <leader>hp <Plug>(GitGutterPreviewHunk)
  nmap <leader>hs <Plug>(GitGutterStageHunk)
  nmap <leader>hr <Plug>(GitGutterRevertHunk)
  nmap <leader>tgg :GitGutterToggle<CR>
  nmap <leader>tggs :GitGutterSignsToggle<CR>
  nmap <leader>tggh :GitGutterLineHighlightsToggle<CR>
" }}}
