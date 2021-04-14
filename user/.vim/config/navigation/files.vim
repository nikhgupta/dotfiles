" quickly edit files in the current directory
map <leader>er :e **/*
map <leader>ew :e ./
map <leader>es :sp ./
map <leader>ev :vsp ./
map <leader>et :tabe ./

" Expected:    make <tab> completion for files/buffers act like bash {{{
  set wildmenu
  set wildmode=list:longest,full      " show a list when pressing tab, then longest common part and then full name.
  " set wildignore+=*/vendor/*          " stuff to ignore when tab completing ...
  set wildignore+=*/.hg/*,*/.svn/*
  set wildignore+=*vim/backups*       " ...
  set wildignore+=*/smarty/*          " ...
  " set wildignore+=*/node_modules/*    " ...
  set wildignore+=*/.sass-cache/*     " ...
  " set wildignore+=*/tmp/*,tmp/**      " ...
  set wildignore+=*/out/**,log/**     " ... phew!!
  " file suffixes that can be safely ignored for file name completion
  set suffixes+=.swo,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.DS_Store,.class,.so
  set suffixes+=.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll,.zip
  set suffixes+=.avi,.mkv,.psd
  set suffixes+=.gem,.pdf
  set suffixes+=.png,.jpg,.gif
" }}}
" Upgrade:     provides a feature-rich file explorer in a sidebar {{{
  " Stop fucking netrw
  let g:netrw_silent = 1
  let g:netrw_quiet  = 1
  let g:loaded_netrw = 1          " prevents loading of netrw, but messes 'gx'
  let g:loaded_netrwPlug = 1    " ^ ..same.. and therefore, commented

  Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeFind',
        \ 'NERDTreeFocus', 'NERDTreeToggle']}
  Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeToggle' }

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
  let NERDTreeBookmarksFile     = expand("~/.vim") . "/tmp/bookmarks"

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

  " mappings
  nmap <leader>ntf <leader>nto<C-w>p:NERDTreeFind<CR>
  nmap <leader>ntc :NERDTreeClose<CR>
  nmap <leader>nto :NERDTreeFocus<CR>:vertical resize 25<CR>
  " nmap <Leader>ntt :NERDTreeTabsToggle<CR>
  " nmap <Leader>tnt :NERDTreeTabsToggle<CR>
" }}}
