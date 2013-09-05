" GUI:
" themes:                     various templates/themes to make code in vim look pretty {{{
  " singles:
  Bundle 'wombat256.vim'
  Bundle 'DAddYE/soda.vim'
  Bundle 'Pychimp/vim-luna'
  Bundle 'cstrahan/grb256'
  Bundle 'jnurmine/Zenburn'
  Bundle 'ciaranm/inkpot'
  Bundle 'fugalh/desert.vim'
  Bundle 'nanotech/jellybeans.vim'
  Bundle '29decibel/codeschool-vim-theme'
  Bundle 'altercation/vim-colors-solarized'
  Bundle 'minofare/VIM-Railscasts-Color-Theme'

  " collections:
  Bundle 'chriskempson/base16-vim'
  Bundle 'chriskempson/vim-tomorrow-theme'
  Bundle 'daylerees/colour-schemes', { 'rtp': 'vim-themes/' }
" }}}
" airline:                    lean & mean statusline for vim that's light as air: {{{
  Bundle 'bling/vim-airline'
  " settings {{{
    let g:airline_theme            = 'solarized'
    let g:airline_left_alt_sep     = ''
    let g:airline_right_alt_sep    = ''
    let g:airline_powerline_fonts  = 1
    let g:airline_enable_syntastic = 1
    let g:airline#extensions#tabline#enabled = 1
  " }}}
" }}}

" Essentials:
" ctrlP:                      quickly search for a file/buffer {{{
  Bundle 'kien/ctrlp.vim'
  " notes: {{{
  " - when CtrlP window is open:
  "   - f5 will clear the CtrlP cache (useful if you add new files during the session)
  "   - <C-f> & <C-b> will cycle between CtrlP modes
  "   - Press <c-d> to switch to filename only search instead of full path.
  "   - Press <c-r> to switch to regexp mode.
  "   - Use <c-j>, <c-k> or the arrow keys to navigate the result list.
  "   - Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
  "   - Use <c-n>, <c-p> to select the next/previous string in the prompt's history.
  "   - Use <c-y> to create a new file and its parent directories.
  "   - Use <c-z> to mark/unmark multiple files and <c-o> to open them.
  " }}}
  " settings: {{{
    " Set no max file limit
    let g:ctrlp_max_files = 0

    " ignore files matching the following patterns
    let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  " }}}
  " key mappings: {{{
    " really needed? we can cycle between modes?
    map <C-b> :CtrlPBuffer<CR>
    " Search from current directory instead of project root
    map <C-o> :CtrlP %:p:h<CR>
  " }}}
" }}}
" nerdtree:                   easy file browsing {{{
  Bundle 'scrooloose/nerdtree'
  " todos: {{{
  "    - Put focus to the NERD Tree with F2 (tricked by quickly closing it and
  "      immediately showing it again, since there is no :NERDTreeFocus command)
  " }}}
  " settings {{{
    " change NerdTree's appearance
    let NERDTreeWinPos    = "left"
    let NERDChristmasTree = 1

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

    " use the default Status Line for NerdTree buffers
    let NerdTreeStatusLine = -1

    " Store the bookmarks file
    let NERDTreeBookmarksFile = expand("$HOME/.vim/bookmarks")

    " Sort NerdTree to show ruby and php files earlier
    let NerdTreeSortOrder = ['\/$', '\.rb$', '\.php$', '*', '\.swp$',  '\.bak$', '\~$']

    " Don't display these kinds of files
    let NERDTreeIgnore = [ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.DS_Store' ]
  " }}}
  " key mappings {{{
    " nmap <leader>n :NERDTreeClose<CR>:NERDTreeToggle<CR>
    nmap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
    nmap <leader>N :NERDTreeClose<CR>
    nmap <Leader>n <plug>NERDTreeTabsToggle<CR>
  " }}}
" }}}
" gundo:                      awesome redo-undo {{{
  Bundle 'sjl/gundo.vim'
  nnoremap <F4> :GundoToggle<CR>
" }}}
" yankring:                   awesome yank history {{{
  Bundle 'skwp/YankRing.vim'
  " settings: {{{
    let g:yankring_min_element_length = 2
    let g:yankring_history_dir = '$HOME/.vim/.tmp'
    " let g:yankring_manual_clipboard_check = 0
    let g:yankring_replace_n_pkey = '<F7>'
    let g:yankring_replace_n_nkey = '<F8>'
    " let g:yankring_window_use_horiz = 0  " Use vertical split
  " }}}
  " key mappings: {{{
    nmap <leader>r :YRShow<CR>
  " }}}
" }}}
" clam:                       lightweight plugin to easily run shell commands in vim {{{
  Bundle 'sjl/clam.vim'
  nnoremap ! :Clam<space>
  vnoremap ! :ClamVisual<space>
" }}}
" zoomwin:                    easily maximize the current buffer {{{
  " - Press <Ctrl-W>o to toggle buffer size
  Bundle 'blueyed/ZoomWin'
" }}}
" nerdtree-tabs:              extend the power of nerdtree over tabs {{{
  Bundle "jistr/vim-nerdtree-tabs"
  " let g:nerdtree_tabs_open_on_console_startup=1
" }}}
" rename2:                    quickly rename your files {{{
  Bundle 'Rename2'
" }}}
" quicktask:                  lightweight task management for vim {{{
  Bundle 'aaronbieber/quicktask'
" }}}
" visual-star-search:         start a * or # search from a visual block: http://bit.ly/1dIKVv5{{{
  Bundle 'nelstrom/vim-visual-star-search'
" }}}
" ack:                        power of Ack in Vim {{{
  Bundle 'mileszs/ack.vim'
" }}}
" session:                    exended session management {{{
  " vim-misc is required for vim-session
  Bundle 'xolox/vim-misc'
  Bundle 'xolox/vim-session'
  let g:session_autoload = 'yes'
  let g:session_autosave = 'yes'
  " let g:session_default_overwrite = 1
  let g:session_default_to_last = 1
  " let g:session_command_aliases = 1

  nnoremap <leader>qa :call SaveSessionWithPrompt()<CR>:qall<CR>

" }}}
" showmarks:                  visual representation of the location marks {{{
  Bundle 'xsunsmile/showmarks'
  let g:showmarks_enable = 0
  " <leader>mt : Toggles ShowMarks on and off. 
  " <leader>mh : Hides an individual mark. 
  " <leader>ma : Hides all marks in the current buffer. 
  " <leader>mm : Places the next available mark. 
" }}}

" Editor:
" commentary:                 easy comments for the naive {{{
  Bundle 'tpope/vim-commentary'
" }}}
" surround:                   surround tags with a given string {{{
  Bundle 'tpope/vim-surround'
" }}}
" abolish:                    easily search for, substitute, and abbrv multiple variants of a word {{{
  Bundle 'tpope/vim-abolish'
" }}}
" unimpaired:                 handy pair of brackets to toggle settings {{{
" TODO: remove mappings obsolete because of this plugin
  Bundle 'tpope/vim-unimpaired'
" }}}
" repeat:                     enable repeating supported plugin maps with '.' {{{
  " supports plugins namely: commentary, surround, abolish, unimpaired
  Bundle 'tpope/vim-repeat'
" }}}
" endwise:                    adds end after if, do, def and several other keywords {{{
  Bundle 'tpope/vim-endwise'
" }}}
" tabular:                    easily indent your assignments {{{
  Bundle 'godlygeek/tabular'
  " key mappings {{{
    nmap <leader>a= :Tabularize /=<CR>
    vmap <leader>a= :Tabularize /=<CR>
    nmap <leader>a: :Tabularize /:\zs<CR>
    vmap <leader>a: :Tabularize /:\zs<CR>
  " }}}
" }}}
" smartinput:                 autoclose and smarter punctuation pairs in Vim {{{
  Bundle 'kana/vim-smartinput'
" }}}
" pasta:                      smart, context-aware indented pasting (no need of paste mode) {{{
  Bundle "sickill/vim-pasta"
  " disable pasta on some file types:
  let g:pasta_disabled_filetypes = ['python', 'coffee', 'yaml']
  " " enable paste on specific file types:
  " let g:pasta_enabled_filetypes = ['ruby', 'javascript', 'css', 'sh']
  " " make pasta use different mappings rather than overloading [p,P]
  " let g:pasta_paste_before_mapping = ',P'
  " let g:pasta_paste_after_mapping = ',p'
" }}}
" splitjoin:                  simplifies the transition between multiline and single-line code {{{
  " use gS to split the lines, and gJ to join them.
  Bundle 'AndrewRadev/splitjoin.vim'
" }}}
" text objects:               create our own text objects {{{
  Bundle 'kana/vim-textobj-user'
  " indentations: i
  Bundle "austintaylor/vim-indentobject"
  " symbols: :
  Bundle "bootleq/vim-textobj-rubysymbol"
  " columns: c
  Bundle "coderifous/textobj-word-column.vim"
  " functions: f
  Bundle "kana/vim-textobj-function"
  Bundle "thinca/vim-textobj-function-javascript"
  " underscored words: _
  Bundle "lucapette/vim-textobj-underscore"
  " ruby blocks: r
  Bundle "nelstrom/vim-textobj-rubyblock"
  " arguments: a
  Bundle "vim-scripts/argtextobj.vim"
" }}}

" Git Related:
" git:                        syntax highlighting and other Git niceties (<v7.2) {{{
  if (v:version < 7.2)
    Bundle 'tpope/vim-git'
  endif
" }}}
" gitv:                       gitk for vim: http://www.gregsexton.org/portfolio/gitv/ {{{
  Bundle 'gregsexton/gitv'
" }}}
" gist:                       for creating small Gist snippets {{{
  Bundle 'mattn/gist-vim'
  " settings {{{
    let g:gist_clip_command = 'pbcopy'
    let g:gist_detect_filetype = 1
    let g:gist_open_browser_after_post = 1
    let g:gist_show_privates = 1
    let g:github_user = $GITHUB_USER
    let g:github_token = $GITHUB_TOKEN
    let g:snips_author = "$MY_NAME <$MY_MAIL>"
  " }}}
" }}}
" fugitive:                   a Git wrapper so awesome, it should be illegal {{{
  Bundle 'tpope/vim-fugitive'
" }}}
" gitgutter:                  a Vim plugin which shows a git diff in the gutter (sign column) {{{
  Bundle 'airblade/vim-gitgutter'
  " todos: {{{
  "   - use the 'Switch' command to switch between git diff for the current line :)
  " }}}
  " settings: {{{
    " do not enable gitgutter by default
    let g:gitgutter_enabled = 0
    " do not be eager - only work when reading/writing a file
    let g:gitgutter_eager = 0
    " ignore whitespace
    let g:gitgutter_diff_args = '-w'
  " }}}
  " key mappings: {{{
    nmap <leader>g :GitGutterToggle<CR>
    " customize mappings for jumping to next/prev hunks
    " nmap gh <Plug>GitGutterNextHunk
    " nmap gH <Plug>GitGutterPrevHunk
  " }}}
" }}}

" Code Helpers:
" tagbar:                     display tags of the current file ordered by scope {{{
  Bundle 'Tagbar'
  " settings {{{
    let g:tagbar_autofocus = 1
    let g:tagbar_autoshowtag = 1
    let g:tagbar_width = 40
    let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
  " }}}
  " key mappings {{{
    nmap <leader>l :TagbarToggle<CR>
  " }}}
" }}}
" syntastic:                  easy syntax checking {{{
  Bundle 'scrooloose/syntastic'
  " settings {{{
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=1
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '⚠'
  " }}}
" }}}
" switch:                     switch between code easily {{{
  Bundle "AndrewRadev/switch.vim"
  nnoremap - :Switch<cr>
" }}}
" indent-guides:              visually display indent levels in code {{{
  Bundle 'nathanaelkane/vim-indent-guides'
  " default map: <leader>ig
  let g:indent_guides_guide_size  = 1
  let g:indent_guides_start_level = 2
" }}}
" multiple-cursors:           true Sublime Text style multiple cursors for vim {{{
  Bundle 'terryma/vim-multiple-cursors'
  " TODO: check that the keys do work correctly
  let g:multi_cursor_use_default_mapping = 0
  let g:multi_cursor_next_key='<F6>'
  let g:multi_cursor_prev_key=''
  let g:multi_cursor_skip_key=''
  let g:multi_cursor_quit_key='<Esc>'
" }}}

" Snippets And Code Completion:
" neocomplete/neocomplcache:  ultimate auto-completion system for Vim {{{
  if has('lua')
    Bundle 'Shougo/neocomplete.vim'
    " settings: {{{
      let g:neocomplete#enable_at_startup = 1                 " enable at startup
      let g:neocomplete#enable_smart_case = 1                 " enable SmartCase
      let g:neocomplete#sources#syntax#min_keyword_length = 3 " use a minimum syntax keyword length
      " do not complete automatically on files matching this pattern
      " let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
      " let g:neocomplete#keyword_patterns['default'] = '\h\w*'
    " }}}
    " key mappings: {{{
      inoremap <expr><C-g>     neocomplete#undo_completion()
      inoremap <expr><C-l>     neocomplete#complete_common_string()

      " <CR>: close popup and save indent.
      inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
      function! s:my_cr_function()
        return neocomplete#smart_close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
      endfunction

      " <TAB>: completion.
      inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

      " <C-h>, <BS>: close popup and delete backword char.
      inoremap <expr><C-h>  neocomplete#smart_close_popup()."\<C-h>"
      inoremap <expr><BS>   neocomplete#smart_close_popup()."\<C-h>"
      inoremap <expr><C-y>  neocomplete#close_popup()
      inoremap <expr><C-e>  neocomplete#cancel_popup()
    " }}}
  else
    Bundle 'Shougo/neocomplcache.vim'
    " settings: {{{
      let g:neocomplcache_enable_at_startup = 1               " enable at startup
      let g:neocomplcache_enable_smart_case = 1               " enable SmartCase
      let g:neocomplcache_min_syntax_length = 3               " use a minimum syntax keyword length
      " do not complete automatically on files matching this pattern
      " let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
      " let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
    " }}}
    " key mappings: {{{
      inoremap <expr><C-g>     neocomplcache#undo_completion()
      inoremap <expr><C-l>     neocomplcache#complete_common_string()

      " <CR>: close popup and save indent.
      inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
      function! s:my_cr_function()
        return neocomplcache#smart_close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
      endfunction

      " <TAB>: completion.
      inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

      " <C-h>, <BS>: close popup and delete backword char.
      inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
      inoremap <expr><BS>   neocomplcache#smart_close_popup()."\<C-h>"
      inoremap <expr><C-y>  neocomplcache#close_popup()
      inoremap <expr><C-e>  neocomplcache#cancel_popup()
    " }}}
  endif

" }}}
" neosnippet:                 ultra fast snippets {{{
  Bundle 'Shougo/neosnippet'
  " settings: {{{
    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1

    " tell NeoSnippet about other snippets
    let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif
  " }}}
  " key mappings: {{{
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \ : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \ : "\<TAB>"
  " }}}
" }}}
" honza-snippets:             snippets for various languages: {{{
  Bundle 'honza/vim-snippets'
" }}}

" Language Helpers:
" html:                       html5 {{{
  " html5 syntax and omni-complete
  Bundle 'DAddYE/html5.vim'
  " convert to and from html entities
  Bundle 'skwp/vim-html-escape'
" }}}
" php:                        PIV {{{
  Bundle 'spf13/PIV'
" }}}
" node.js:                    node.js {{{
  Bundle 'mmalecki/vim-node.js'
" }}}
" ruby/rails:                 ruby, rails, rake, bundler, endwise, haml, rspec, cucumber {{{
  " essential for ruby code writing, eh?
  Bundle 'vim-ruby/vim-ruby'

  " rails power tools for vim: http://git.io/rails.vim
  Bundle 'tpope/vim-rails'
  " it's like rails.vim without the rails
  Bundle 'tpope/vim-rake'
  " lightweight support for Ruby's Bundler
  Bundle 'tpope/vim-bundler'

  " syntax support
  Bundle 'tpope/vim-haml'
  " Bundle 'DAddYE/vim-slim'
  Bundle 'tpope/vim-rspec'
  Bundle 'tpope/vim-cucumber'
" }}}
" stylesheets:                less, css3-syntax, scss-syntax {{{
  Bundle 'groenewege/vim-less'
  Bundle 'hail2u/vim-css3-syntax'
  Bundle 'cakebaker/scss-syntax.vim'
" }}}
" text/markdown:              markdown, textile {{{
  Bundle 'tpope/vim-markdown'
  Bundle 'timcharper/textile.vim'
  Bundle 'jtratner/vim-flavored-markdown'
  Bundle 'nelstrom/vim-markdown-preview'
" }}}
" javascript:                 coffeescript, javascript {{{
  Bundle 'pangloss/vim-javascript'
  Bundle 'kchmck/vim-coffee-script'
  Bundle 'itspriddle/vim-jquery'
" }}}
" miscelleneous:              csv {{{
  Bundle 'csv.vim'
" }}}

" Miscelleneous:
" matchit:                    extended % matching for HTML, LaTeX, etc. {{{
  Bundle 'matchit.zip'
" }}}
" vim-scratch:                scratchable buffer for scrappables {{{
  Bundle 'duff/vim-scratch'
  " key mappings {{{
    nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>
  " }}}
" }}}

" Disabled Plugins:
" " unite:                      interface to rule almost everything {{{
  " Bundle 'Shougo/unite.vim'
  " call SourceIfReadable('~/.vim/lib/unite.vim')
" " }}}
" " vimfiler:                   easy file browsing that integrates with unite {{{
  " Bundle 'Shougo/vimfiler.vim'
  " " settings {{{
    " let g:vimfiler_as_default_explorer = 1
  " " }}}
  " " key mappings {{{
    " nnoremap <silent> [unite]v :<C-u>VimFilerBufferDir -quit<CR>
    " nnoremap <silent> [unite]p :<C-u>VimFilerBufferDir -split -simple -winwidth=30 -no-quit<CR>
    " nnoremap <silent> [unite]i :<C-u>VimFiler -split -explorer -status -simple -winwidth=30 -no-quit<CR>
  " " }}}
" " }}}
" " vimproc:                    asynchronously runs commands (Bundle, Unite) {{{
  " Bundle 'Shougo/vimproc', {
      " \ 'build' : {
      " \     'windows' : 'make -f make_mingw32.mak',
      " \     'cygwin' : 'make -f make_cygwin.mak',
      " \     'mac' : 'make -f make_mac.mak',
      " \     'unix' : 'make -f make_unix.mak',
      " \    },
      " \ }
" " }}}
" " yankring:                   maintains a history of previous yanks, changes and deletes {{{
  " Bundle 'YankRing.vim'
" " }}}
" " flake8:                     automatic syntax checker for Python {{{
  " Bundle 'nvie/vim-flake8'
" " }}}
" " screen:                     simulate a split shell in vim using gnu screen or tmux {{{
  " Bundle 'ervandew/screen'
" " }}}
" " easytags:                   automated tag generation and syntax highlighting in Vim {{{
  " Bundle 'easytags.vim'
  " " settings {{{
    " let g:easytags_cmd = '/usr/local/bin/ctags'
    " let g:easytags_dynamic_files = 1
    " let g:easytags_by_filetype = '~/.ctags'
    " let g:easytags_resolve_links = 1
    " " let g:easytags_file = '~/.easytags'
  " " }}}
" " }}}
" " nerdcommenter:              easy comments for the naive {{{
  " Bundle 'scrooloose/nerdcommenter'
  " " settings {{{
    " let NERDSpaceDelims = 1
    " " let NERDRemoveExtraSpaces = 1
  " " }}}
" " }}}
