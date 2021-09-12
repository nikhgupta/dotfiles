" Stop fucking netrw
let g:netrw_silent = 1
let g:netrw_quiet  = 1
let g:loaded_netrw = 1          " prevents loading of netrw, but messes 'gx'
let g:loaded_netrwPlug = 1    " ^ ..same.. and therefore, commented

Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeFind',
                            \ 'NERDTreeFocus', 'NERDTreeToggle']}

" nerdtree configuration
let NERDTreeWinPos     = "left"    " nerdtree should appear on left
let NERDTreeWinSize    = 25        " nerdtree window must be 30 char wide
let NERDTreeDirArrows  = 1         " display fancy arrows instead of ASCII
let NERDTreeMinimalUI  = 0         " I don't like the minimal UI, nerdtree!
let NERDTreeStatusLine = -1        " do not use the default status line
let NERDTreeHighlightCursorline=1  " highlight the current line in tree

let NERDTreeShowFiles         = 1  " show files as well as dirs
let NERDTreeShowHidden        = 1  " show hidden files, too.
let NERDTreeShowBookmarks     = 1  " oh, and obvously, the bookmarks, too.
let NERDTreeCaseSensitiveSort = 1  " sorting of files should be case sensitive
let NERDTreeRespectWildIgnore = 1  " ignore files ignored by `wildignore`

let NERDTreeChDirMode         = 2  " change CWD when tree root is changed
let NERDTreeMouseMode         = 2  " use single click to fold/unfold dirs
let NERDTreeQuitOnOpen        = 0  " do not quit on opening a file from tree
let NERDTreeAutoDeleteBuffer  = 1  " delete buffer when deleting the file
let NERDTreeBookmarksFile     = expand('$HOME') . "/.vim/tmp/bookmarks"

let g:nerdtree_tabs_open_on_gui_startup=0
let g:nerdtree_tabs_open_on_console_startup=0

augroup nerd_tree_open
        au!
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 1 && isdirectory(expand(argv(0)))
                                \ && !exists("s:std_in") | call plug#load('nerdtree')
                                \ | execute("NERDTree ". expand(argv(0))) | only | endif
augroup END

" Sort NERDTree to show files in a certain order
let NERDTreeSortOrder = [ '\/$', '\.rb$', '\.php$', '\.py$',
                        \ '\.js$', '\.json$', '\.css$', '\.less$', '\.sass$', '\.scss$',
                        \ '\.yml$', '\.yaml$', '\.sh$', '\..*sh$', '\.vim$',
                        \ '*', '.*file$', '\.example$', 'license', 'LICENSE', 'readme', 'README',
                        \ '\.md$', '\.markdown$', '\.rdoc$', '\.txt$', '\.text$', '\.textile$',
                        \ '\.log$', '\.info$' ]

" Don't display these kinds of files
let NERDTreeIgnore = [ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
                        \ '\.so$', '\.egg$', '^\.git$', '^\.hg$', '^\.svn$', '^\.DS_Store',
                        \ '\.zip$', '\.gz$', '\.lock$', '\.swp$', '\.bak$', '\~$' ]
" \ '\.png$', '\.jpg$', '\.jpeg$', '\.bmp$', '\.svg$', '\.gif$',


Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
let g:NERDTreeLimitedSyntax = 1

let g:NERDTreeExtensionHighlightColor = { 'vue': '55b884',
                        \ 'py': 'fddd55', 'sass': 'CB6F6F', 'php': '777bb3',
                        \ 'yaml': 'ffffff', 'erb': 'CB6F6F', 'java': 'f49731',
                        \ 'rabl': 'CB6F6F', 'thor': 'CB6F6F', 'tasks': '55b884',
                        \ 'rb': 'CB6F6F', 'ru': 'CB6F6F' }

let g:NERDTreePatternMatchHighlightColor = {
                        \ 'Gemfile': 'CB6F6F', 'Rakefile': 'CB6F6F' }

augroup devicons_nerdtree
        au!
        autocmd FileType nerdtree setlocal nolist
augroup END

" mappings
let g:which_key_map.t.u.n = 'toggle nerd-tree'
nnoremap <silent> <leader>tun :NERDTreeToggle<CR>

let g:which_key_map.f.f.t = 'find file in nerd-tree'
nnoremap <silent> <leader>fft :NERDTreeFocus<CR>:vertical resize 25<CR><C-w>p:NERDTreeFind<CR>
