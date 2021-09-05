let g:which_key_map.t.g = { 'name': '+ToggleGit' }

" git
Plug 'tpope/vim-fugitive'

" browse Github repos with GBrowse
Plug 'tpope/vim-rhubarb'
let g:which_key_map.g.o = 'Open current file in Browser'
nmap <silent> <leader>go :GBrowse<cr>

" git branch viewer
Plug 'rbong/vim-flog'
let g:which_key_map.g.v = 'Open Git Viewer'
let g:which_key_map.t.g.v = 'Open Git Viewer'
nmap <leader>gv :FlogSplit<CR>
nmap <leader>tgv :FlogSplit<CR>

" highlights conflict markers & provides a way to jump to them
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'  " highlight conflict markers

" shortcut to jump to next conflict marker
let g:which_key_map.g.j = 'Jump to next conflict '
nmap <silent> <leader>gj /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

" git commit messages have spell check enabled, and text width of 72 chars
augroup git_files
  au!
  autocmd BufRead,BufNewFile GHI_* set ft=gitcommit
  autocmd FileType gitcommit setlocal spell textwidth=72
augroup end

" enables support to manage Github Gists from the editor
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

" displays git diff in sign column, and easily add hunks for staging
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

let g:which_key_map.t.g.g = 'Toggle GitGutter'
let g:which_key_map.t.g.s = 'Toggle GitGutter Signs'
let g:which_key_map.t.g.l = 'Toggle GitGutter Line Highlights'
nmap <leader>tgg :GitGutterToggle<CR>
nmap <leader>tgs :GitGutterSignsToggle<CR>
nmap <leader>tgl :GitGutterLineHighlightsToggle<CR>

let g:which_key_map.g[']'] = 'Jump to prev hunk'
let g:which_key_map.g['['] = 'Jump to next hunk'
nmap <leader>g] <Plug>(GitGutterNextHunk)
nmap <leader>g[ <Plug>(GitGutterPrevHunk)

let g:which_key_map.g.p = 'Preview hunk'
let g:which_key_map.g.s = 'Stage hunk'
let g:which_key_map.g.r = 'Revert hunk'
nmap <leader>gp <Plug>(GitGutterPreviewHunk)
nmap <leader>gs <Plug>(GitGutterStageHunk)
nmap <leader>gr <Plug>(GitGutterRevertHunk)
