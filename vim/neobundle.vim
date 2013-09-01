" VimProc to asynchronously run commands (NeoBundle, Unite) {{{
  " NeoBundle 'Shougo/vimproc', {
      " \ 'build' : {
      " \     'windows' : 'make -f make_mingw32.mak',
      " \     'cygwin' : 'make -f make_cygwin.mak',
      " \     'mac' : 'make -f make_mac.mak',
      " \     'unix' : 'make -f make_unix.mak',
      " \    },
      " \ }
" }}}

" Unite. The interface to rule almost everything {{{
  NeoBundle 'Shougo/unite.vim'
  call SourceIfReadable("~/.vim/unite.vim")
" }}}

" NeoBundles that make Vim look nicer :) {{{
  NeoBundle 'bling/vim-airline' " {{{
    " settings {{{
    let g:airline_powerline_fonts = 1
    let g:airline_left_alt_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_theme = 'solarized'
    " }}}
  " }}}
" }}}

" NeoBundles for Color themes {{{
  NeoBundle 'Pychimp/vim-luna'
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

" NeoBundles for File Browsing {{{

  NeoBundle 'scrooloose/nerdtree' " {{{
    " todos: {{{
    "    - Put focus to the NERD Tree with F2 (tricked by quickly closing it and
    "      immediately showing it again, since there is no :NERDTreeFocus command)
    " }}}
    " settings {{{
      " change NerdTree's appearance
      let NERDTreeWinPos    = "left"
      let NERDTreeWinSize   = 30
      let NERDChristmasTree = 0

      " Show hidden files, and bookmarks
      let NERDTreeShowFiles     = 1
      let NERDTreeShowHidden    = 1
      let NERDTreeShowBookmarks = 1

      " change directory, whenever tree root is changed
      let NERDTreeChDirMode = 2

      " Quit on opening files from the tree
      let NERDTreeQuitOnOpen = 0

      " Highlight the selected entry in the tree
      let NERDTreeHighlightCursorline = 1

      " Use a single click to fold/unfold directories and a double click to open files
      let NERDTreeMouseMode = 2

      " Store the bookmarks file
      let NERDTreeBookmarksFile = expand("$HOME/.vim/NERDTreeBookmarks")

      " Don't display these kinds of files
      let NERDTreeIgnore = [ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.DS_Store' ]
    " }}}
    " key mappings {{{
      nmap <leader>n :NERDTreeClose<CR>:NERDTreeToggle<CR>
      nmap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
      nmap <leader>N :NERDTreeClose<CR>
    " }}}

  " }}}

  " File explorer (needed where ranger is not available)
  " NeoBundleLazy 'Shougo/vimfiler', {'autoload' : { 'commands' : ['VimFiler']}}

" }}}

" Code Completion {{{

  " OmniCompletion behaviour {{{
    set cot-=preview                "disable doc preview in omnicomplete
    if has("autocmd") && exists("+omnifunc")
      " Enable omni completion for filetypes (Ctrl-X Ctrl-O)
      autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
      autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
      autocmd FileType c set omnifunc=ccomplete#Complete
      autocmd filetype css setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType java set omnifunc=javacomplete#Complete

      " use syntax complete if nothing else available
      autocmd Filetype * if &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
    endif
  " }}}

  " Use Snippets {{{
    " has dependencies
    NeoBundle 'tomtom/tlib_vim'
    NeoBundle 'MarcWeber/vim-addon-mw-utils'
    NeoBundle 'honza/snipmate-snippets'

    NeoBundle 'garbas/vim-snipmate'
  " }}}
" }}}

" Improve our editing pleasure with some NeoBundles {{{

  " Surround plugin {{{
    NeoBundle 'tpope/vim-surround'
  " }}}

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

" }}}

" Code / Development Helpers {{{

  " Syntastic - easy syntax checking {{{
    NeoBundle 'scrooloose/syntastic'
  " }}}

" }}}

" Some awesome NeoBundle and their settings {{{

  " Gundo :: awesome redo-undo {{{
    NeoBundle 'sjl/gundo.vim'
    nnoremap <F6> :GundoToggle<CR>
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
  NeoBundle 'matchit.zip'
" }}}

" Disabled Plugins {{{
    " NeoBundle 'YankRing.vim'
    " NeoBundle 'nvie/vim-flake8'
    " NeoBundle 'ervandew/screen'

    " VimFiler {{{
        " NeoBundle 'Shougo/vimfiler.vim'
        " let g:vimfiler_as_default_explorer = 1
        " nnoremap <silent> [unite]v :<C-u>VimFilerBufferDir -quit<CR>
        " nnoremap <silent> [unite]p :<C-u>VimFilerBufferDir -split -simple -winwidth=30 -no-quit<CR>
        " nnoremap <silent> [unite]i :<C-u>VimFiler -split -explorer -status -simple -winwidth=30 -no-quit<CR>
    " }}}
" }}}
