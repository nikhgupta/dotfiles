" VimProc to asynchronously run commands (NeoBundle, Unite) {{{
  NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
" }}}

" Unite. The interface to rule almost everything {{{
  NeoBundle 'Shougo/unite.vim'

  " customize our unite matching options {{{
  let bundle = neobundle#get('unite.vim')
  function! bundle.hooks.on_source(bundle)
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#set_profile('files', 'smartcase', 1)
    call unite#custom#source('line,outline','matchers','matcher_fuzzy')
  endfunction
  " }}}

  " customize unite's features {{{
  let g:unite_prompt='» '
  " let g:unite_enable_start_insert=1
  let g:unite_source_history_yank_enable=1
  let g:unite_source_rec_max_cache_files=5000
  let g:unite_data_directory='~/.vim/.cache/unite'
  call EnsureExists("~/.vim/.cache/unite")
  " }}}

  " customize unite's searching behaviour {{{
  if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
    let g:unite_source_grep_recursive_opt=''
  elseif executable('ack')
    let g:unite_source_grep_command='ack'
    let g:unite_source_grep_default_opts='--no-heading --no-color -a -C4'
    let g:unite_source_grep_recursive_opt=''
  endif
  " }}}

  " make unite exit itself on specified keys in normal mode {{{
  function! s:unite_settings()
    nmap <buffer> Q <plug>(unite_exit)
    nmap <buffer> <esc> <plug>(unite_exit)
  endfunction
  autocmd FileType unite call s:unite_settings()
  " }}}

  " unite related plugins/bundles {{{
    NeoBundleLazy 'tsukkee/unite-help', {'autoload':{'unite_sources':'help'}}
    NeoBundleLazy 'osyo-manga/unite-filetype', { 'autoload' : {'unite_sources' : 'filetype', }}
    NeoBundleLazy 'thinca/vim-unite-history', { 'autoload' : { 'unite_sources' : ['history/command', 'history/search']}}
    NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}
    NeoBundleLazy 'tsukkee/unite-tag', {'autoload':{'unite_sources':['tag','tag/file']}}
    NeoBundleLazy 'tacroe/unite-mark', {'autoload':{'unite_sources':'mark'}}
    NeoBundleLazy 'osyo-manga/unite-airline_themes', {'autoload':{'unite_sources':'airline_themes'}}
    NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload':{'unite_sources': 'colorscheme'}}
    NeoBundleLazy 'Shougo/junkfile.vim', {'autoload':{'commands':'JunkfileOpen', 'unite_sources':['junkfile','junkfile/new']}}
    call EnsureExists("~/.vim/.cache/junk")
    let g:junkfile#directory=expand("~/.vim/.cache/junk")

    " Not quite sure how these work:
      " NeoBundleLazy 'osyo-manga/unite-fold', {'autoload':{'unite_sources':'fold'}}
      " NeoBundleLazy 'Shougo/unite-session', {'autoload':{'unite_sources':'session', 'commands' : ['UniteSessionSave', 'UniteSessionLoad']}}
      " NeoBundleLazy 'ujihisa/unite-locate', {'autoload':{'unite_sources':'locate'}}
      " NeoBundleLazy 'osyo-manga/unite-quickfix', {'autoload':{'unite_sources': ['quickfix', 'location_list']}}
  " }}}

  " key mappings for unite {{{
  nnoremap [unite] <nop>
  nmap <leader>u [unite]

  if g:is_windows
    nnoremap <silent> [unite]u :<C-u>Unite -toggle -start-insert -auto-resize -buffer-name=mixed file_rec buffer file_mru bookmark<cr><c-u>
    nnoremap <silent> [unite]f :<C-u>Unite -toggle -start-insert -auto-resize -buffer-name=files file_rec<cr><c-u>
  else
    nnoremap <silent> [unite]u :<C-u>Unite -toggle -start-insert -auto-resize -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr><c-u>
    nnoremap <silent> [unite]f :<C-u>Unite -toggle -start-insert -auto-resize -buffer-name=files file_rec/async<cr><c-u>
  endif

  nnoremap <silent> [unite]/  :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
  nnoremap <silent> [unite]b  :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
  nnoremap <silent> [unite]k  :<C-u>Unite -start-insert -auto-resize -buffer-name=mappings mapping<cr>
  nnoremap <silent> [unite]l  :<C-u>Unite -start-insert -auto-resize -buffer-name=line line<cr>
  nnoremap <silent> [unite]r  :<C-u>Unite -buffer-name=resume resume<cr>
  nnoremap <silent> [unite]s  :<C-u>Unite -quick-match buffer<cr>
  nnoremap <silent> [unite]y  :<C-u>Unite -buffer-name=yanks history/yank<cr>

    " plugin related mappings - sorted alphabetically {{{
    nnoremap <silent> [unite]a  :<C-u>Unite -winheight=10 -auto-preview -buffer-name=airline_themes airline_themes<cr>
    nnoremap <silent> [unite]c  :<C-u>Unite -auto-resize -buffer-name=commands history/command history/search<cr>
    nnoremap <silent> [unite]cs :<C-u>Unite -winheight=10 -auto-preview -buffer-name=colorschemes colorscheme<cr>
    nnoremap <silent> [unite]ft :<C-u>Unite -start-insert -auto-resize -buffer-name=filetypes filetype<cr>
    nnoremap <silent> [unite]h  :<C-u>Unite -start-insert -auto-resize -buffer-name=help help<cr>
    nnoremap <silent> [unite]j  :<C-u>Unite -auto-resize -buffer-name=junk junkfile junkfile/new<cr>
    nnoremap <silent> [unite]n  :<C-u>Unite -auto-resize -buffer-name=bundles neobundle<cr>
    nnoremap <silent> [unite]m  :<C-u>Unite -auto-resize -buffer-name=marks mark<cr>
    nnoremap <silent> [unite]o  :<C-u>Unite -auto-resize -buffer-name=outline outline<cr>
    nnoremap <silent> [unite]t  :<C-u>Unite -auto-resize -buffer-name=tags tag tag/file<cr>
    " }}}

    " key mapping list -- sorted alphabetically {{{
    "     /     :     search for a given pattern
    "     a     :     list available airline themes and allow auto-preview
    "     b     :     list all available buffers
    "     c     :     list commands and searches from vim's history
    "     cs    :     list available colorschemes and allow auto-preview
    "     f     :     open files recursively
    "     ft    :     list available filetypes and allow setting it for current buffer
    "     h     :     search vim's help for a particular word
    "     j     :     list available junk files and allow creating a new one
    "     k     :     list all available mappings
    "     l     :     list lines in the current buffer
    "     m     :     list available marks for current session
    "     n     :     list all available bundles on this machine
    "     o     :     outline the current buffer
    "     r     :     list available unite windows
    "     s     :     quick open a given buffer
    "     t     :     list available tags and tag-files
    "     u     :     open bookmarks, recent files and other files (recursively)
    "     y     :     list available clipboard contents
    " }}}
  " }}}
" }}}

" File explorer (needed where ranger is not available)
NeoBundleLazy 'Shougo/vimfiler', {'autoload' : { 'commands' : ['VimFiler']}}

" NeoBundles for Color themes {{{
  NeoBundle 'jnurmine/Zenburn'
  NeoBundle 'fugalh/desert.vim'
  NeoBundle 'ciaranm/inkpot'
  NeoBundle 'nanotech/jellybeans.vim'
  NeoBundle 'minofare/VIM-Railscasts-Color-Theme'
  NeoBundle 'altercation/vim-colors-solarized'
  NeoBundle 'wombat256.vim'
  NeoBundle 'Getafe'
  " NeoBundle 'daylerees/colour-schemes', { 'rtp': 'vim-themes/' }
" }}}

" NeoBundles that make Vim look nicer :) {{{
  " Powerline configuration {{{
    NeoBundle 'Lokaltog/vim-powerline'
    let g:Powerline_symbols = 'unicode'
  " }}}

  " Airline configuration (experimental - disabled) {{{
    " NeoBundle 'bling/vim-airline'
    " let g:airline_powerline_fonts = 0
  " }}}

  NeoBundle 'nathanaelkane/vim-indent-guides'
" }}}

" Some awesome NeoBundle and their settings {{{

  " NERDTree settings {{{
    NeoBundle 'scrooloose/nerdtree'
    " Put focus to the NERD Tree with F3 (tricked by quickly closing it and
    " immediately showing it again, since there is no :NERDTreeFocus command)
    nmap <leader>n :NERDTreeClose<CR>:NERDTreeToggle<CR>
    nmap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
    nmap <leader>N :NERDTreeClose<CR>

    " Store the bookmarks file
    let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

    " Show the bookmarks table on startup
    let NERDTreeShowBookmarks=1

    " Show hidden files, too
    let NERDTreeShowFiles=1
    let NERDTreeShowHidden=1

    " Quit on opening files from the tree
    let NERDTreeQuitOnOpen=0

    " Highlight the selected entry in the tree
    let NERDTreeHighlightCursorline=1

    " Use a single click to fold/unfold directories and a double click to open
    " files
    let NERDTreeMouseMode=2

    " Don't display these kinds of files
    let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$' ]

  " }}}

  " Gundo :: awesome redo-undo {{{
    NeoBundle 'sjl/gundo.vim'
    nnoremap <F6> :GundoToggle<CR>
  " }}}

  " Surround plugin {{{
    NeoBundle 'tpope/vim-surround'
  " }}}

  " Scratch Buffer {{{
    NeoBundle 'duff/vim-scratch'

    " scratch
    nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>
  " }}}

  " CtrlP - Quickly search for a file/buffer {{{
    NeoBundle 'kien/ctrlp.vim'
    let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  " }}}

  " Supertab {{{
    NeoBundle 'ervandew/supertab'
    let g:SuperTabSetDefaultCompletionType = "context"
  " }}}

  " YankRing (disabled) {{{
    " let g:yankring_history_dir = '$HOME/.vim/.tmp'
    " let g:yankring_manual_clipboard_check = 0
    " let g:yankring_replace_n_pkey = '<F7>'
    " let g:yankring_replace_n_nkey = '<F8>'
    " nmap <leader>r :YRShow<CR>
  " }}}

  " VimWiki {{{
    " NeoBundle 'vimwiki'
    " let g:vimwiki_list = [{'path': '~/Dropbox/wiki/'}]
  " }}}

  " ZoomWin {{{
    NeoBundle 'ZoomWin'

    " adjust viewport as needed
    nmap <leader>w=  <C-w>=
    nmap <leader>w<bar> <C-w><bar>
    nmap <leader>w_  <C-w>_
    nmap <leader>w@  <C-w>_<C-w><bar>

    " switch to an alternate buffer and  maximize its viewport
    nmap <leader>wH <C-w>h<C-w>_<C-w><bar>
    nmap <leader>wJ <C-w>j<C-w>_<C-w><bar>
    nmap <leader>wK <C-w>k<C-w>_<C-w><bar>
    nmap <leader>wL <C-w>l<C-w>_<C-w><bar>

  " }}}

  " Power of Ack in Vim {{{
    NeoBundle 'mileszs/ack.vim'
  " }}}

  " EasyMotion (<leader><leader>) {{{
    NeoBundle 'Lokaltog/vim-easymotion'
    hi link EasyMotionTarget ErrorMsg
    hi link EasyMotionShade  Comment
  " }}}

  " Syntastic - easy syntax checking {{{
    NeoBundle 'scrooloose/syntastic'
  " }}}

" }}}

" Improve our editing pleasure with some NeoBundles {{{

  " NerdCommenter {{{
    NeoBundle 'scrooloose/nerdcommenter'
    let NERDSpaceDelims = 1
    " let NERDRemoveExtraSpaces = 1
  " }}}

  " Tabularize {{{
    NeoBundle 'godlygeek/tabular'
    nmap <leader>a= :Tabularize /=<CR>
    vmap <leader>a= :Tabularize /=<CR>
    nmap <leader>a: :Tabularize /:\zs<CR>
    vmap <leader>a: :Tabularize /:\zs<CR>
  " }}}

  " Vim Unimpaired {{{
    " handy pair of brackets
    NeoBundle 'tpope/vim-unimpaired'
  " }}}

  " CloseTag - for HTML and XML files {{{
    NeoBundle 'closetag.vim'
  " }}}

  " Narrow Region - Only modify a part of the file (no settings specified) {{{
    NeoBundle 'chrisbra/NrrwRgn'
    " TODO: create commands that allow selecting several lines individually
    " using the :NRPrepare command and then edit them using :NRMulti command
  " }}}

  " Use Snippets {{{
    " has dependencies
    NeoBundle 'tomtom/tlib_vim'
    NeoBundle 'MarcWeber/vim-addon-mw-utils'
    NeoBundle 'honza/snipmate-snippets'

    NeoBundle 'garbas/vim-snipmate'
  " }}}

" }}}

" NeoBundles used for Rails development {{{
  NeoBundle 'vim-ruby/vim-ruby'
  NeoBundle 'tpope/vim-rails'
  NeoBundle 'tpope/vim-endwise'
  NeoBundle 'tpope/vim-haml'
  NeoBundle 'tpope/vim-cucumber'
  NeoBundle 'skwp/vim-rspec'
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'cakebaker/scss-syntax.vim'
  " NeoBundle 'skalnik/vim-vroom'
" }}}

" NeoBundles used for PHP development {{{
  NeoBundle 'spf13/PIV'
" }}}

" Filetype specific NeoBundles {{{
  NeoBundle 'csv.vim'
  NeoBundle 'tpope/vim-markdown'
  NeoBundle 'timcharper/textile.vim'
  NeoBundle 'pangloss/vim-javascript'
  NeoBundle 'mmalecki/vim-node.js'
  NeoBundle 'rosstimson/scala-vim-support'
  NeoBundle 'ajf/puppet-vim'
  NeoBundle 'Vim-R-plugin'
" }}}

" NeoBundles that help in Ctags management {{{

  " find and load tags file up until root {{{
  set tags=./tags;/
  " }}}

  " load all tags files in the ~/.ctags directory {{{
  " http://stackoverflow.com/questions/12916743/include-ctags-files-recursively-from-a-directory
  set tags=~/.ctags/*/*/tags;
  " }}}

  " don't show ctags for Ruby in a PHP project :) {{{
  " http://stackoverflow.com/questions/12921750/ctags-only-show-relevant-or-contextual-tags
  " augroup TagFileType
      " autocmd!
      " autocmd FileType * setl tags<
      " autocmd FileType * exe 'setl tags+=~/.ctags/' . &filetype . '/*/tags'
  " augroup END
  " }}}

  " Easy Code Browsing when we have multiple matching tags {{{
  nnoremap <silent> <leader>j :tnext<cr>zt
  nnoremap <silent> <leader>J :tprev<cr>zt
  nnoremap <silent> <leader>k :pop<cr>zt
  map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
  map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
  " }}}

  " Tagbar Settings {{{
  NeoBundle 'Tagbar'
  let g:tagbar_autofocus = 1
  let g:tagbar_autoshowtag = 1
  let g:tagbar_width = 40
  let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
  nmap <leader>l :TagbarToggle<CR>
  " }}}

  " EasyTags settings (disabled) {{{
  " NeoBundle 'easytags.vim'
  " let g:easytags_cmd = '/usr/local/bin/ctags'
  " let g:easytags_dynamic_files = 1
  " let g:easytags_by_filetype = '~/.ctags'
  " let g:easytags_resolve_links = 1
  " " let g:easytags_file = '~/.easytags'
  " }}}

" }}}

" NeoBundles interacting with Git {{{
  NeoBundle 'tpope/vim-fugitive'
  " Gist - for creating small Gist snippets {{{
  NeoBundle 'mattn/gist-vim'
  let g:gist_clip_command = 'pbcopy'
  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 1
  let g:gist_show_privates = 1
  let g:github_user = $GITHUB_USER
  let g:github_token = $GITHUB_TOKEN
  let g:snips_author = "$MY_NAME <$MY_MAIL>"
  " }}}
  NeoBundle 'tpope/vim-git'
  NeoBundle 'gregsexton/gitv'
" }}}

" Other helpful NeoBundles {{{
  " Rename current file nicely
  NeoBundle 'Rename2'

  " Disabled Plugins {{{
    " NeoBundle 'YankRing.vim'
    " NeoBundle 'nvie/vim-flake8'
    " NeoBundle 'ervandew/screen'
  " }}}
" }}}
