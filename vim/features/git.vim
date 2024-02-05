let g:which_key_map.t.g = { 'name': '+ToggleGit' }

" git
Plug 'tpope/vim-fugitive'

" browse Github repos with GBrowse
Plug 'tpope/vim-rhubarb'

" mappings
let g:which_key_map.g.o = 'Open current file in Browser'
nmap <silent> <leader>go :GBrowse<cr>

let g:which_key_map.g.b = 'View Git Blame'
nmap <leader>gb :Git blame<CR>

let g:which_key_map.g.d = 'Git describe'
nmap <leader>gd :Git describe<CR>

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


augroup CdGitRootOrFileDir
  au!
  au BufEnter,BufRead * if !empty(bufname("%")) | execute "cd " . FindRootDirectoryWithGit() | endif
augroup end

function! FindRootDirectoryWithGit()
  let s:path = FugitiveWorkTree()
  " if (len(s:path) == 0) | let s:path = FindRootDirectory() | endif
  if (len(s:path) == 0) | let s:path = fnamemodify(resolve(expand('%:p')), ":p:h") | end
  return s:path
endfunction


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
" display signs by default
let g:gitgutter_signs = 0
" ignore whitespace
let g:gitgutter_diff_args = '-w'
" use the raw grep command
" let g:gitgutter_grep_command = &grepprg
" highlight hunks by default
" let g:gitgutter_highlight_lines = 1
" let vim be snappier - don't lag.
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_async = 1

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_modified_removed = ':'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_removed_above_and_below = '_'

" remap mappings
let g:gitgutter_map_keys = 0

" highlight clear SignColumn
" highlight GitGutterAdd ctermfg=1 ctermbg=0
" highlight GitGutterChange ctermfg=2 ctermbg=0
" highlight GitGutterDelete ctermfg=3 ctermbg=0
" highlight GitGutterChangeDelete ctermfg=3 ctermbg=0

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
let g:which_key_map.g.u = 'Undo hunk'
nmap <leader>gp <Plug>(GitGutterPreviewHunk)
nmap <leader>gs <Plug>(GitGutterStageHunk)
nmap <leader>gr <Plug>(GitGutterRevertHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)

omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

" uses the following alias:
" git_web() {
"   local tmpcache=/tmp/git-web-last.dir
"   local curr=$(pwd)
"   local last=$(cat $tmpcache)
"   local query="a=summary"
"   [[ -z "$@" ]] || query="a=history;f=$@";
"   cd "${last}" && git instaweb stop && \
"     cd "${curr}" && git instaweb -d webrick start && \
"     open "http://127.0.0.1:1234/?p=.git;${query}" && \
"     echo "${curr}" > $tmpcache
" }
let g:which_key_map.g.w = 'Git Instaweb - File History'
let g:which_key_map.g.W = 'Git Instaweb - Repo Summary'
nmap <silent> <leader>gw :call OpenGitInstaweb('%')<CR>
nmap <silent> <leader>gW :call OpenGitInstaweb()<CR>
function! OpenGitInstaweb(...)
  echom 'open repo in web: ' . getcwd() . ' '
  if a:0 > 0
    execute(':Git web ' . fnamemodify(expand(a:1.':p'), ':.'))
  else
    execute(':Git web')
  endif
endfunction
