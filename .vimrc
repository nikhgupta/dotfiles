" Credits:       """""""""""""""""""""""""""""""""""""""""""""" {{{
"
"            _ _    _                       _        _
"           (_) |  | |                     | |      ( )
"      _ __  _| | _| |__   __ _ _   _ _ __ | |_ __ _|/ ___
"     | '_ \| | |/ / '_ \ / _` | | | | '_ \| __/ _` | / __|
"     | | | | |   <| | | | (_| | |_| | |_) | || (_| | \__ \
"     |_| |_|_|_|\_\_| |_|\__, |\__,_| .__/ \__\__,_| |___/
"                          __/ |     | |
"                         |___/      |_|
"                            _       _    __ _ _
"                           | |     | |  / _(_) |
"                         __| | ___ | |_| |_ _| | ___  ___
"                        / _` |/ _ \| __|  _| | |/ _ \/ __|
"                       | (_| | (_) | |_| | | | |  __/\__ \
"                        \__,_|\___/ \__|_| |_|_|\___||___/
"
"
"   Hello, I am Nikhil Gupta, and
"   You can find me at http://nikhgupta.com
"
"   You can find an online version of this file at:
"   https://github.com/nikhgupta/dotfiles/blob/master/ubuntu/.vimrc
"
"   This is the personal vim configuration file of Nikhil Gupta.
"   While much of it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
"   ---
"
"   Configuration inside this file is meant to be utilized by VIM editor.
"   Please, note that GUI (Macvim) cannot read environment variables defined in
"   either `~/.zshrc` or `~/.zshrc.local`, which is why you MUST define your api
"   tokens, etc. in `~/.zshenv`, so that they can be picked up by MacVim.
"
"   This VIM configuration does not split configuration between GUI and Terminal
"   VIM via a separate `~/.gvimrc`, and instead, incorporates it within this
"   file via a conditional `if` statement.
"
" }}}
" Compatibility: """""""""""""""""""""""""""""""""""""""""""""" {{{
"
"   I used to be on a MacOSX, but have recently switched to using linux,
"   and the configuration works wonderfully on it.
"
"   I have not, yet, checked the latest configuration for OSX environment, but
"   I am quite sure that the configuration should work nicely with it :)
"
"   Since, I never use Windows, this configuration might not be (and, I know for
"   a fact, that it won't be) compatible with it :(
"
"   I have, deliberately, removed any configuration that attempted to have such
"   a compatibility from this file, at around December, 2013.
"
" }}}
" NORC:         """"""""""""""""""""""""""""""""""""""""""""""" {{{
"   To start vim without using this .vimrc file, use:
"     vim -u NORC
"
"   To start vim without loading any .vimrc or plugins, use:
"     vim -u NONE
" }}}
" Vim Tips:     """"""""""""""""""""""""""""""""""""""""""""""" {{{
"   - Press `Shift`+`K` key on any keyword to get quick help!
"   - Use `:X` to set encryption on any file
"   - Use `setl key=` to disable this encryption
"   - Use `gf` to open file under cursor using default file handler
"   - Use `gx` to open the current url using default url handler
"   - Use `g:netrw_browserx_viewer` to set the binary for above command
"   - Use `''` to jump to location of the last jump
"   - Use `'.` to jump to location of your last edit
" }}}
" Inspirations: """"""""""""""""""""""""""""""""""""""""""""""" {{{
"   In no specific order:
"   - https://github.com/zenom/dotfiles
"   - https://github.com/jferris/config_files
"   - https://github.com/ryanb/dotfiles
"   - https://github.com/holman/dotfiles
"   - https://github.com/thoughtbot/dotfiles
"   - https://github.com/rtomayko/dotfiles
"   - https://github.com/garybernhardt/dotfiles
"   - https://github.com/amix/vimrc
"   - https://github.com/vgod/vimrc
"   - https://github.com/humiaozuzu/dot-vimrc
"   - https://github.com/sontek/dotfiles
"   - https://github.com/mathiasbynens/dotfiles
"   - https://github.com/nvie/vimrc
" }}}
" TodosAndIdeas: """"""""""""""""""""""""""""""""""""""""""""""" {{{
"   - use PGP keys for encryption
"   - display latest xkcd comic on Startify
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible     " No to the total compatibility with the ancient vi

" Prologue:                                                          {{{
" keys used:
" - personalize: user should personalize the config for their own purpose.
" - recommend:   config that can be personalized (modified), but is recommended.
" - expedite:    when config exists to speed up a particular workflow.
" - expected:    when config exists because the editor is expected to behave so.
" - essential:   when config exists because the feature is essential to an editor.
" - component:   configuration that provides a specific component to the editor.
" - upgrade:     configuration that updates a given component of the vim editor.
" - modernize:   configuration that fixes an obsolete practice.
" - specialize:  configuration that add special features in the editor for handling a particular task.
" - tweak:       configuration that fixes edge-cases, or smooth out user experience.
" - advanced:    configuration represents advanced usage of the editor.
" - feature:     configuration adds a new feature to the editor (not prev found or very weak support)
"
" General Mappings:
" - F1           <noop>
" - F2           toggle paste mode
" - F3           multiple cursor mode
" - F5           run make program defined for the current file
" - F8           insert current date
" - F9           obfuscate the entire buffer
" -  K           view documentation for word under cursor
" - F6           special function attached with the current file, if any.
"                 vim: view Github repo for plugin defined on current line
"
" }}}
" Internal:                                                          {{{
" Internal:    developer-defined custom variables for this config {{{
  " os specific variables
  let g:is_gui     = has('gui_running')
  let g:is_mac     = has('mac') || has('macunix') || has('gui_macvim')
  let g:is_nix     = has('unix') && !has('macunix') && !has("win32unix")
  let g:is_ubuntu  = g:is_nix && system("uname -a") =~ "Ubuntu"
  let g:is_windows = has('win16') || has('win32') || has('win64')
  let g:is_wsl     = g:is_nix && system("uname -a") =~ "microsoft"
  let g:is_nvim    = has('nvim')
  let g:is_macvim  = g:is_mac && g:is_gui && has('gui_macvim')

  " other relevant variables
  let g:is_posix   = 1 " enable better bash syntax highlighting

  " what kind of VIM UI we are working with?
  if g:is_macvim                | let g:ui_type = "MVIM"
  elseif g:is_gui               | let g:ui_type = "GUI"
  elseif exists("$TMUX")        | let g:ui_type = "TMUX"
  elseif exists("$COLORTERM")   | let g:ui_type = "CTERM"
  elseif exists("$TERM")        | let g:ui_type = "TERM"
  else | let g:ui_type = "????" | endif
" }}}
" Internal:    developer-defined custom functions for this config {{{
  " Function: Open a url/file with the default browser {{{
    function! s:open_with_browser(url, ...)
      let l:prog = "open"
      let l:prog = empty("$BROWSER") ? l:prog : expand("$BROWSER")
      let l:comm = l:prog . " '" . expand(a:url) . "'"

      if empty(l:prog)
        echoerr "Could not find a valid browser. Set one via $BROWSER variable."
      elseif a:0 > 0 && a:1 == 0
        return l:comm
      else
        silent! execute('!' . l:comm)
      endif
    endfunction
    command! -bar -nargs=1 OpenURL :call s:open_with_browser("<args>")
    command! -bar -nargs=1 OpenWithBrowser :call s:open_with_browser("<args>")
  " }}}
" }}}
" }}}
" Preferences:                                                       {{{
" General:     has configurable leader keys {{{
  let mapleader      = ","     " change mapleader key from / to ,
  let g:mapleader    = ","     " some plugins may require this variable to be set
  let maplocalleader = "\\"    " used inside filetype settings
" }}}
" Appearance:  uses distinct GUI fonts {{{
  if g:is_gui
    set guifont=Fira\ Code:h16
    "set guifont=FuraCode\ Nerd\ Font\ Mono\ Regular:h16
    "set guifont=Fira\ Code\ Regular\ Nerd\ Font\ Complete\ Windows\ Compatible:h16
    "set guifont=Droid\ Sans\ Mono\ for\ Powerline:h16

    if g:is_mac | set macligatures | endif
  endif
" }}}
" Upgrade:     provides a way to customize the startup screen {{{
  let g:startify_bookmarks = [ '~/.vimrc', '~/.zshrc', '~/.zshenv', '~/.dotfiles/ubuntu/' ]
" }}}
" }}}

" General:                                                           {{{
" Personalize: allows customizations via a local configuration {{{
  if filereadable("~/.vimrc.local.pre") | source ~/.vimrc.local.pre | endif
" }}}
" Essential:   has mouse support built-in {{{
  if has('mouse')
    set mouse=a          " enable using mouse if terminal supports it
    set mousehide        " hide mouse pointer when typing
  endif
" }}}
" Essential:   watch for file & directory changes, but don't auto-write files {{{
  set autoread                      " watch for file changes
  set noautochdir                   " do not auto change the working directory
  set noautowrite                   " do not auto write file when moving away from it.
" }}}
" Expected:    text scrolls automatically, when cursor reaches near the edges {{{
  set scrolloff=7                 " keep lines off edges of the screen when scrolling
  " set scrolljump=5                " lines to scroll when cursor leaves screen
  set sidescroll=1                " brings characters in view when side scrolling
  set sidescrolloff=15            " start side-scrolling when n chars are left
" }}}
" Modernize:   advocates UTF-8 encoding, against latin {{{
  scriptencoding utf-8
  set encoding=utf-8 nobomb " BOM often causes trouble
  set termencoding=utf-8
  set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
" }}}
" Modernize:   disables file backup, in favor of, versioning {{{
  set nobackup                      " do not keep backup files - it's 70's style cluttering
  set nowritebackup                 " do not make a write backup
  set noswapfile                    " do not write annoying intermediate swap files
  set directory=~/.vim/tmp/swaps,/tmp    " store swap files in one of these directories (in case swapfile is ever turned on)
" }}}
" Modernize:   doesn't beep - "that's rude, O' Odin!" {{{
  set noerrorbells                  " don't beep
  set visualbell t_vb=              " don't beep, remove visual bell char
" }}}
" Recommend:   adds bash like key mappings in command line {{{
  cnoremap <C-A> <Home>
  cnoremap <C-E> <End>
  cnoremap <C-K> <C-U>
  cnoremap <C-P> <Up>
  cnoremap <C-N> <Down>
" }}}
" Tweak:       timeout on key combinations, e.g. mappings & key codes {{{
  set timeout                     " timeout on :mappings and key codes
  set timeoutlen=600              " timeout duration should be sufficient to type the mapping
  set ttimeoutlen=50              " timeout duration should be small for keycodes
                                  " try pressing 'O' in normal mode in terminal editor
  set updatetime=250
" }}}
" Tweak:       allows OS to decide when to flush to disk {{{
  set nofsync       " improves performance
" }}}
" Tweak:       ignores whitespace changes in the diff mode {{{
  if has("diff")
    set diffopt+=iwhite     " Ignore whitespace changes (focus on code changes)
    set diffopt+=vertical   " use vertical splits for diff
  endif
" }}}
" }}}
" Plugs:                                                           {{{
" Component:   has a plugin manager to extend itself {{{
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  call plug#begin('~/.vim/bundle')

  " require matchit
  runtime macros/matchit.vim
" }}}
" Expected:    comes with default plugins that enhance the editor {{{
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
" }}}
" }}}
" Appearance:                                                        {{{
" Personalize: provides a variety of themes to choose from {{{
  Plug 'morhetz/gruvbox'
  Plug '29decibel/codeschool-vim-theme'
  Plug 'altercation/vim-colors-solarized'
  Plug 'minofare/VIM-Railscasts-Color-Theme'
  Plug 'dracula/vim'
  Plug 'connorholyday/vim-snazzy'
  Plug 'arcticicestudio/nord-vim'

  " collections:
  " Plug 'chriskempson/base16-vim'
  Plug 'chriskempson/vim-tomorrow-theme'
" }}}
" Personalize: highlight current line, but not the current column {{{
  set cursorline                  " highlight the current line for quick orientation
  set nocursorcolumn              " do not highlight the current column
  " toggle highlighting of cursor column - useful for manual indentation
  nnoremap <leader>tcc :set cursorcolumn!<CR>
" }}}
" Personalize: highlight column markers for several columns {{{
  if has('syntax')
    let &colorcolumn="+1,+21,+41,+81"
  end

" }}}
" Personalize: show relative line numbers where they make sense, otherwise absolute ones {{{
  set number                      " always show line numbers
  set numberwidth=4               " number of culumns for line numbers
  augroup relative_line_numbers
    au!
    autocmd FocusLost,BufLeave,InsertEnter   * if &number | :setl norelativenumber | endif
    autocmd FocusGained,BufEnter,InsertLeave * if &number | :setl relativenumber   | endif
  augroup end

  " toggle RelativeLineNumbers manually using Ctrl+n
  nnoremap <leader>rn :set relativenumber!<cr>
" }}}
" Personalize: switches to a fullscreen view on startup (default: on) {{{
" This works in close cooperation with the 'time-aware-theme-switching' feature,
" and has not been tested a lot. If you toggle this setting, and still the
" editor switches to a fullscreen view, please review settings in the aforesaid
" feature.
" NOTE: This option is only present in Macvim.
  if g:is_macvim
    set fullscreen
    set fuoptions="maxvert,maxhorz,background:Normal"
  endif
" }}}
" Expected:    maximizes editor window when using GUI {{{ todo: extract
  if g:is_gui
    set lines=999 columns=999   " maximize GUI window
    set guitablabel=%N/\ %t\ %M " show tab number, name and status
  endif
" }}}
" Expedite:    allows to highlight indentation guides (default: off) {{{
  Plug 'nathanaelkane/vim-indent-guides'
  " NOTE: default map: <leader>ig
  nmap <silent> <Leader>tig <Plug>IndentGuidesToggle

  let g:indent_guides_guide_size  = 1
  let g:indent_guides_start_level = 2
" }}}
" Upgrade:     has a beautiful startup screen (via mtartify) {{{
  set shortmess+=I                " do not display intro message on Vim startup

  Plug 'mhinz/vim-startify'
  " when opening a shortcut, switch to its directory
  let g:startify_change_to_dir = 1
  " enable 'empty buffer', and 'quit' commands
  let g:startify_enable_special = 0
  " display upto 10 recent files
  let g:startify_files_number = 7
  " also, allow 'o' to open an empty buffer
  let g:startify_empty_buffer_key = 'o'
  " change to the root repository path when opening files
  let g:startify_change_to_vcs_root = 1
  " use the given session directory
  let g:startify_session_dir = expand("~/.vim") . "/tmp/sessions/"
  " first four shortcuts should be available from home row
  let g:startify_custom_indices = [ 'a', 'd', 'f', 'l' ]
  " skip these files from the recent files list
  let g:startify_skiplist = [ 'COMMIT_EDITMSG', $VIMRUNTIME .'/doc', 'bundle/.*/doc', '/tmp' ]
  " display shortcuts in the given order
  let g:startify_list_order = [
        \ ['   Your bookmarks:'], 'bookmarks',
        \ ['   Your sessions:'], 'sessions',
        \ ['   Your recently opened files (from current directory):'], 'dir',
        \ ['   Your recently opened files (all of them):'], 'files',
        \ ]

  " let g:startify_custom_footer = ['', ''] + ['', ''] + map(split(system('fortune'), '\n'), '"   ". v:val') + ['','']
  " display a fortune cookie (or output from custom command) as the footer
  " if exists("s:startify_custom_footer_command")
  "   let g:startify_custom_footer = map(split(system(s:startify_custom_footer_command), '\n'), '"   ". v:val')
  " else
    let g:startify_custom_footer = [  '', '',
                                   \  '    ██╗   ██╗ ██╗ ███╗   ███╗    ',
                                   \  '    ██║   ██║ ██║ ████╗ ████║    ',
                                   \  '    ██║   ██║ ██║ ██╔████╔██║    ',
                                   \  '    ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║    ',
                                   \  '     ╚████╔╝  ██║ ██║ ╚═╝ ██║    ',
                                   \  '      ╚═══╝   ╚═╝ ╚═╝     ╚═╝    '  ]
  " endif

  " let g:startify_custom_footer = [ '   '.repeat('_', 60).' ', ''] + g:startify_custom_footer
  " let g:startify_custom_footer = g:startify_custom_footer + [ '', '' ]

  " colors for startup screen
  hi! default link StartifyBracket LineNr
  hi! default link StartifyFile    Keyword
  hi! default link StartifyFooter  String
  hi! default link StartifyHeader  String
  hi! default link StartifyNumber  Function
  hi! default link StartifyPath    LineNr
  hi! default link StartifySection Special
  hi! default link StartifySelect  LineNr
  hi! default link StartifySlash   LineNr
  hi! default link StartifySpecial Special

  " mappings and miscelleneous behaviour
  nmap <silent> <leader>st :Startify<CR>
  augroup vim_startup_screen
    au!
    au User Startified setl colorcolumn=0 buftype=
    au User Startified AirlineRefresh
    " au User Startified nnoremap <silent!> <buffer> <leader>st :e#<CR>
  augroup end
" }}}
" Upgrade:     has a beautiful status line (via AirLine) {{{
  set noshowmode                  " don't show vim modes - let statusline do that
  set report=0                    " always report number of lines changed
  set shortmess+=filmnrxoOtT      " abbrev. vim-messages (avoids 'hit enter', also)

  set cmdheight=2                 " use a status bar that is 2 rows high
  set laststatus=2                " tell VIM to always put a status line in

  if has('cmdline_info')
    set ruler                     " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                   " show (partial) command in the last line of the screen this also shows visual selection info
  endif

  " Use :AirlineToggle to revert to this statusline
  if has('statusline') && !exists('g:loaded_airline')
    set stl=\ \ \[_%{mode()}_]\ \ \ [%Y/%{&ff}]\ %F\ %m%r\
          \ %=[%{g:ui_type}]\ %-17.(%l,%c%V%)\ %p\%\%\ \ \ %LL\ TOTAL
  endif

  let g:airline_powerline_fonts = 1 " use powerline symbols
  let g:airline_detect_modified = 1
  " let g:airline_detect_paste = 1
  " let g:airline_detect_crypt = 1
  " let g:airline_detect_spell = 1
  " let g:airline_detect_spelllang = 1
  let g:airline_inactive_collapse = 0
  " let g:thematic#defaults['airline-theme'] = DayOrNight("solarized", "base16")

  let g:airline_skip_empty_sections = 1

  " powerline symbols
  " if get(g:, 'airline_powerline_fonts', 1)
    " let g:airline_left_sep = "\uE0C4"
    " let g:airline_right_sep = "\uE0C5"
  " endif

  " customize the Airline sections
  let g:airline_section_y = "%{airline#util#wrap(airline#parts#ffenc() . ' ' . g:ui_type, 0)}"

  " set a default airline theme, if none has, been defined!
  if !exists('g:airline_theme') | let g:airline_theme = 'onedark' | endif
  if !is_gui | let g:airline_theme = 'onedark' | endif
" }}}
" Upgrade:     displays tab titles in a beautiful way (via: Airline) {{{
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 0
  " TODO: check if this works:
  let g:airline#extensions#tabline#excludes = ['*NERD*', '*Tagbar*', 'ControlP']
  let g:airline#extensions#tabline#tab_min_count = 2
  let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline#extensions#tabline#buffers_label = 'B'
  let g:airline#extensions#tabline#tabs_label = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline#extensions#tabline#right_alt_sep = ''
  "let g:airline#extensions#tabline#left_sep = ''
  "let g:airline#extensions#tabline#right_sep = ''
" }}}
" Advanced:    disables unnecessary interfaces in GUI {{{
  if g:is_gui
    " adjust the GUI accordingly
    set guioptions-=T   " Remove the toolbar
    set guioptions-=m   " Remove the menu
    set guioptions+=c   " Use console dialogs

    " remove scrollbars
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
  endif
" }}}
" Tweak:       uses a non-blinking cursor, and switches to line cursor in insert mode {{{
  Plug 'jszakmeister/vim-togglecursor'
  if g:is_gui
    let &guicursor = substitute(&guicursor, 'n-v-c:', '&blinkon0-', '')
  endif
" }}}
" Tweak:       does not update the display when executing macros, registers, etc. {{{
  set lazyredraw
" }}}
" }}}
" Editing:                                                           {{{
" Personalize: doesn't auto-format text (later enabled for: code comments) {{{
  " do not format just about any type of text, esp. source code
  set formatoptions-=t
  " recognize numbered lists when formatting
  set formatoptions+=n
  " don't break a line after a one-letter word
  set formatoptions+=1
" }}}
" Personalize: disables spell check, by default (enabled - for text files) {{{
  " no spell check, by default - enabled via autocommands, where required
  " `public` dictionary file is versioned, while the `private` one is not.
  if has('spell')
    set dictionary=/usr/share/dict/words
    set spellfile=~/.vim/spell/public.utf-8.add,~/.vim/spell/private.utf-8.add
    set nospell

    nnoremap zG 2zg
  endif
" }}}
" Personalize: zen or distraction free mode {{{
  Plug 'junegunn/goyo.vim'

  function! GoyoEnter()
    hi! CursorLine guibg=bg ctermbg=bg
  endfunction
  function! GoyoLeave()
    hi! CursorLine term=underline ctermbg=236 guibg=#3a3d4d guisp=#3a3d4d
  endfunction

  autocmd! User GoyoEnter nested call GoyoEnter()
  autocmd! User GoyoLeave nested call GoyoLeave()
" }}}
" Recommend:   minimal set of sensible configuration for the editor {{{
  set virtualedit=onemore         " allow cursor 1 char beyond end of current line
  set backspace=indent,eol,start  " allow backspacing over everything in insert mode
  set fileformats="unix,dos,mac"  " EOL that will be tried when reading buffers
" }}}
" Recommend:   uses soft tabs (with spaces) over hard tabs - as default {{{
  set tabstop=2                   " a tab is two spaces
  set softtabstop=2               " when <BS>, pretend tab is removed, even if spaces
  set expandtab                   " expand tabs, by default
  set nojoinspaces                " prevents two spaces after punctuation on join
" }}}
" Recommend:   displays invisible whitespace e.g. hard tabs {{{
  set list                        " show invisible characters like spaces
                                  " enabled later via autocmd on certain filetypes
  set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:·
" }}}
" Recommend:   wraps text automatically, when editing it {{{
  set nowrap                      " don't wrap lines
  set linebreak                   " break long lines at words, when wrap is on
  set whichwrap=b,s,h,l,<,>,[,]   " allow <BS> & cursor keys to move to prev/next line
  " set showbreak=↪
  let &showbreak="\u21aa "        " string to put at the starting of wrapped lines
  set textwidth=120               " wrap after this many characters in a line
" }}}
" Expedite:    provides helpful movement keys to affect the surroundings of text {{{
  Plug 'tpope/vim-surround'
" }}}
" Expedite:    allows to easily and precisely jump to a location {{{
  Plug 'Lokaltog/vim-easymotion'
" }}}
" Expedite:    adds more text objects to quickly modify the text {{{
  Plug 'kana/vim-textobj-user'

  " indentations: i
  Plug 'austintaylor/vim-indentobject'

  " " symbols: :
  " Plug 'bootleq/vim-textobj-rubysymbol'

  " vertical columns by word boundary: c
  Plug 'coderifous/textobj-word-column.vim'

  " " functions: f - does not support ruby/python/php by default
  " Plug 'kana/vim-textobj-function'

  " " ruby blocks: r - works nearly same as indentobject
  " Plug 'nelstrom/vim-textobj-rubyblock'

  " arguments: z
  Plug 'kana/vim-textobj-fold'
" }}}
" Specialize:  supports multiple cursors for editing text in one go {{{
  " Plug 'terryma/vim-multiple-cursors'
  " let g:multi_cursor_use_default_mapping = 0
  " let g:multi_cursor_next_key='<F3>'
  " let g:multi_cursor_prev_key=''
  " let g:multi_cursor_skip_key=''
  " let g:multi_cursor_quit_key='<Esc>'
" }}}
" Expected:    restore cursor after joining lines {{{
  nnoremap J mjJ`j
" }}}
" Recommended: quickly get out of insert mode using 'jj' or 'jk' keys {{{
  inoremap jj <Esc>
  inoremap jk <Esc>
" }}}
" Expected:    visual shifting (does not exit Visual mode when shifting text) {{{
  vnoremap < <gv
  vnoremap > >gv
" }}}
" Mappings:    view changes in the current buffer as a diff {{{
  " Function: View changes in the current buffer {{{
  function! DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  endfunction " }}}
  nnoremap <leader>ds :call DiffWithSaved()<CR>
" }}}
" Mappings:    quickly edit files in the current directory {{{
  map <leader>er :e **/*
  map <leader>ew :e ./
  map <leader>es :sp ./
  map <leader>ev :vsp ./
  map <leader>et :tabe ./
" }}}
" Mappings:    use Q for formatting the current paragraph (or visual selection) {{{
  vmap Q gq
  nmap Q gqap
" }}}
" Mappings:    auto-indent the entire document, and jump back to current location {{{
  nmap <leader>b= ggVG=''
" }}}
" Mappings:    insert the current time by pressing <F8> {{{
  nnoremap <F8> "=strftime("%d-%m-%y %H:%M:%S")<CR>P
  inoremap <F8> <C-R>=strftime("%d-%m-%y %H:%M:%S")<CR>
" }}}
" Mappings:    allows to quickly complete file names in insert mode {{{
  imap <C-f> <C-x><C-f>
" }}}
" Mappings:    allows to quickly complete lines from current buffer in insert mode {{{
  imap <C-l> <C-x><C-l>
" }}}
" }}}
" Mappings:                                                          {{{
" NOTE: This section does not cover all the mappings for the editor. Most
" mappings are defined along with the relevant feature set.
" Recommend:   swaps generic most used key mappings with analogous mappings {{{
  " Since I never use the ; key anyway, this is a real optimization for almost
  " all Vim commands, since we don't have to press that annoying Shift key that
  " slows the commands down
  nnoremap ; :
  " nnoremap : ;    " not recommended

  " Swap implementations of ` and ' jump to markers
  nnoremap ' `
  nnoremap ` '

  " Swap implementations of 0 and ^
  nnoremap 0 ^
  nnoremap ^ 0
" }}}
" Recommend:   avoids any accidental hits with mappings {{{
  " avoid accidental hits of <F1> while aiming for <Esc>
  noremap  <F1> :echom "Use ". &keywordprg ." OR press 'K' to get help."<CR><Esc>
  noremap! <F1> <Esc>:echom "Use ". &keywordprg ." OR press 'K' to get help."<CR><Esc>a

  " avoid accidental hits of Shift key
  cmap Tabe tabe
  if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
  endif
" }}}
" Recommend:   has mappings to perform everyday tasks quicker {{{
  " quickly close the current window
  noremap <leader>wq :q<CR>

  " quick save a file
  nnoremap <leader>fs :w!<CR>

  " sudo to write
  cmap w!! w !sudo tee % >/dev/null

  " Switch between the last two files
  nnoremap <leader><leader> <C-^>
" }}}
" Recommend:   provides some easier movement related mappings {{{
  " remap j and k to act as expected when used on long, wrapped, lines
  noremap j gj
  noremap k gk

  " jump to matching pairs easily, with Tab
  nnoremap <Tab> %
  vnoremap <Tab> %

" }}}
" Recommend:   provides a mapping to save file after removing all trailing whitespace {{{
  " replaces all hard tabs and ^M to spaces, and then removes trailing WS.
  " restores cursor position by setting a marker
  nnoremap <silent> <leader>W  mw:%s/\v<C-v><C-m>//e<CR>:retab<CR>:%s/\s\+$//e<CR>:nohlsearch<CR>:w<CR>`w
" }}}
" Recommend:   provides standard OS shortcuts on MacOSX {{{
if g:is_mac

  " indentation related
  omap <D-]> >>
  omap <D-[> <<
  nmap <D-]> >>
  nmap <D-[> <<
  vmap <D-]> >gv
  vmap <D-[> <gv
  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

  " bubble lines up/down
  nmap <D-k> [e
  nmap <D-j> ]e
  vmap <D-k> [egv
  vmap <D-j> ]egv

  " map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt
endif
" }}}
" }}}
" Programming:                                                       {{{
" Personalize: considers '.', '-', & '#' characters as part of the keyword {{{
  set iskeyword-=.
  set iskeyword-=#
  set iskeyword-=-
" }}}
" Personalize: display informative text when code is folded {{{
  " Function: Text to display on folded lines {{{
  function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' ' . repeat("-",fillcharcount) . ' ' . foldedlinecount . ' '
  endfunction " }}}
  set foldtext=MyFoldText()       " function for text that appears over folds
" }}}
" Essential:   enables sane syntax highlighting of code, whenever possible {{{
  set synmaxcol=200    " don't try to highlight lines longer than 800 characters
  " syntax highlight on, when terminal has colors
  if g:is_gui || &t_Co > 2 | syntax on | endif
" }}}
" Expected:    briefly blinks matching paranthesis for quick orientation {{{
  set showmatch                   " set show matching parenthesis
  set matchtime=2                 " show matching parenthesis for 0.2 seconds
" }}}
" Expected:    automatically, indents code when editing code {{{
  set autoindent                  " always set autoindenting on
  set shiftwidth=2                " number of spaces to use for autoindenting
  set copyindent                  " copy the previous indentation on autoindenting
  set shiftround                  " use multiple of 'sw' when indenting with '<' and '>'
  set smarttab                    " insert tabs on start of line acc to 'sw' not 'ts'
" }}}
" Expected:    has support for code folding (default: based on indentation) {{{
  set nofoldenable                " do not enable folding, by default
  set foldcolumn=0                " add a fold column to the left of line-numbers
  set foldlevel=0                 " folds with a higher level will be closed
  set foldlevelstart=10           " start out with everything open
  set foldmethod=indent           " create folds based on indentation
  set foldnestmax=7               " deepest fold is 7 levels
  set foldminlines=1              " do not fold single lines, fold everything else
  " which commands trigger auto-unfold
  set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
" }}}
" Expected:    auto-formats comments, & insert comment markers where required {{{
  " automatically, insert comment marker, when possible:
  set formatoptions+=cro
  " allow 'gq' to format comments
  set formatoptions+=q
  " remove comment markers when joining lines
  silent! set formatoptions+=j    " gives error on some versions of vim 7.3 & lower
" }}}
" Expedite:    supports adding or removing comments for many languages {{{
  Plug 'tpope/vim-commentary'
  " From the FAQ:
  " > My favorite file type isn't supported!
  " > > Relax! You just have to adjust 'commentstring':
  "     autocmd FileType apache set commentstring=#\ %s
" }}}
" Expedite:    adds block-level end statements when hitting Enter key {{{
  Plug 'tpope/vim-endwise'
" }}}
" Expedite:    adds or removes punctuation pairs when typing, smartly {{{
  Plug 'kana/vim-smartinput'
" }}}
" Expedite:    Mapping: toggle fold on the current fold using a space {{{
  nnoremap <Space> za
  vnoremap <Space> za
" }}}
" Specialize:  allows switching between alternate forms of code segments {{{
  "
  " Example:
  " let's say, you've a simple ruby code:
  "   hash = { x: 'something', y: 'something-else' }
  " hitting '-' key, while the cursor is on 'x', will produce:
  "   hash = { :x => 'something', y: 'something-else' }
  "
  Plug 'AndrewRadev/switch.vim'
  nnoremap - :Switch<cr>
" }}}
" Specialize:  provides a way to quickly align code segments {{{
  Plug 'tsaleh/vim-align'
" }}}
" Advanced:    loads tag file when found, and adds some convenient mappings {{{
  set tags+=./tags,tags;/         " find and load tags file up until root
  " Plug 'ludovicchabant/vim-gutentags'
  " let g:gutentags_cache_dir = '~/.tags_cache'

  " mappings:
  " TODO: what does this correspond to?
  nnoremap <silent> <leader>j :tnext<cr>zt
  nnoremap <silent> <leader>J :tprev<cr>zt
  nnoremap <silent> <leader>k :pop<cr>zt
  map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
  map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" }}}
" Mappings:    allows to quickly fold text at a specific level {{{
  nmap <leader>f0 :set foldlevel=0<CR>
  nmap <leader>f1 :set foldlevel=1<CR>
  nmap <leader>f2 :set foldlevel=2<CR>
  nmap <leader>f3 :set foldlevel=3<CR>
  nmap <leader>f4 :set foldlevel=4<CR>
  nmap <leader>f5 :set foldlevel=5<CR>
  nmap <leader>f6 :set foldlevel=6<CR>
  nmap <leader>f7 :set foldlevel=7<CR>
  nmap <leader>f8 :set foldlevel=8<CR>
  nmap <leader>f9 :set foldlevel=9<CR>
" }}}
" Tweak:       doesn't screw up folds when inserting text {{{
  " Don't screw up folds when inserting text that might affect them, until
  " leaving insert mode. Foldmethod is local to the window. Protect against
  " screwing up folding when switching between windows.
  " http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
  augroup FixFoldInsert
    au!
    autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod |
                        \ setlocal foldmethod=manual | endif
    autocmd InsertLeave,WinLeave * if exists('w:last_fdm') |
                                \ let &l:foldmethod=w:last_fdm |
                                \ unlet w:last_fdm | endif
  augroup end
" }}}
" Essential:   supports SYNTAX highlighting , FileType detection, etc. for many languages {{{
  Plug 'vim-scripts/SyntaxRange'

  " text markup family:
  " Plug 'tpope/vim-markdown'             " mardown | #TODO: required?
  Plug 'jtratner/vim-flavored-markdown' " Github flavored markdown syntax
  Plug 'timcharper/textile.vim'         " textile markup

  " html & css family:
  Plug 'othree/html5.vim'               " html 5
  Plug 'lepture/vim-css'                " CSS3
  Plug 'groenewege/vim-less'            " Less
  Plug 'cakebaker/scss-syntax.vim'      " SCSS
  Plug 'tpope/vim-haml'                 " haml, sass and scss
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'mattn/emmet-vim'
  Plug 'chrisbra/Colorizer'
  nmap <leader>tcol :ColorToggle<CR>
  let g:colorizer_auto_filetype='css,html,scss,vue'
  let g:colorizer_colornames_disable = 1
  let g:colorizer_colornames = 0

  " javascript family:
  Plug 'pangloss/vim-javascript'        " Javascript
  Plug 'mxw/vim-jsx'
  Plug 'kchmck/vim-coffee-script'       " Coffeescript
  Plug 'itspriddle/vim-jquery'          " jQuery
  Plug 'mmalecki/vim-node.js'           " Node.js
  Plug 'posva/vim-vue'                  " Vue.js
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'thosakwe/vim-flutter'

  " php
  Plug 'spf13/PIV'                      " PHP integrated environment

  "python
  " Python integrated environment
  " adds support for linting, doc search, execution, debugging, code completion, etc.
  " Plug 'klen/python-mode'
  " let g:pymode_rope_lookup_project = 0

  " ruby
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rbenv'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rake'
  Plug 'thoughtbot/vim-rspec'

  " NOTE: `vim-bundler` uses 2 system commands that are expensive.
  "       Therefore, we replace it with autocmds instead. Look into:
  "       " Ruby: Rails: persist ctags when we move inside gem directories
  "
  " Plug 'tpope/vim-bundler'
  "
  " ' system('ruby -rubygems -e "print Gem.path.join(%(;))"')
  " ' system('ruby -rrbconfig -e "print RbConfig::CONFIG[\"ruby_version\"]"')

  " go
  Plug 'fatih/vim-go'
  let g:go_highlight_operators = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1

  " miscelleneous:
  Plug 'vim-scripts/csv.vim'                        " CSV files
" }}}
" Essential:   supports snippets for many languages {{{
  " Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
" }}}
" Essential:   supports language-specific CODE COMPLETION for many languages {{{

  set completeopt+=menu,longest     " select first item, follow typing in autocomplete
  set complete=.,w,b,u,t            " do lots of scanning on tab completion,  FIXME?
  set pumheight=6                   " Keep a small completion window

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif

  set completeopt+=preview          " enable doc preview in omnicomplete
  " Disable the neosnippet preview candidate window
  " When enabled, there can be too much visual noise
  " especially when splits are used.
  " set completeopt-=preview

  " Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
  " " enable completion from tags
  " let g:ycm_collect_identifiers_from_tags_files = 1
  " " enable completion for keywords in current language
  " let g:ycm_seed_identifiers_with_syntax = 0
  " let g:ycm_max_num_candidates = 10

  " augroup load_us_ycm
  "   autocmd!
  "   autocmd InsertEnter * call plug#load('ultisnips', 'vim-snippets', 'ZouCompleteMe')
  "         \| autocmd! load_us_ycm
  " augroup END
  " php
  Plug 'shawncplus/phpcomplete.vim'

  " Enable omni completion.
  augroup omni_complete
    au!
    if exists('+omnifunc')
      " Enable omni completion for filetypes (Ctrl-X Ctrl-O)
      autocmd filetype html,ghmarkdown set omnifunc=htmlcomplete#CompleteTags
      autocmd filetype javascript set omnifunc=javascriptcomplete#CompleteJS
      autocmd filetype python set omnifunc=pythoncomplete#Complete
      autocmd filetype xml set omnifunc=xmlcomplete#CompleteTags
      autocmd filetype c set omnifunc=ccomplete#Complete
      autocmd filetype css set omnifunc=csscomplete#CompleteCSS
      autocmd filetype java set omnifunc=javacomplete#Complete
      autocmd filetype xml set omnifunc=xmlcomplete#CompleteTags
      autocmd filetype haskell set omnifunc=necoghc#omnifunc
      autocmd filetype ruby set omnifunc=rubycomplete#Complete

      " use syntax complete if nothing else available
      autocmd filetype * if &omnifunc == '' | set omnifunc=syntaxcomplete#Complete | endif
    endif
  augroup end

  " ruby - required by rails.vim
  augroup omni_complete_ruby
    au!
    autocmd filetype ruby,eruby let g:rubycomplete_buffer_loading = 1
    autocmd filetype ruby,eruby let g:rubycomplete_rails = 1
    autocmd filetype ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd filetype ruby,eruby let g:rubycomplete_include_object = 1
    autocmd filetype ruby,eruby let g:rubycomplete_include_objectspace = 1
  augroup end
" }}}
" Essential:   properly detects filetype for weird files or corrects them and adds syntax {{{
  " Plug 'sheerun/vim-polyglot'
  augroup detect_filetypes
    au!
    " html & css family:
    au BufNewFile,BufRead *.less setl ft=less
    au BufNewFile,BufRead *.scss setl ft=scss
    au BufNewFile,BufRead *.sass setl ft=sass
    " javascript family:
    au BufNewFile,BufRead *.json setl ft=json
    au BufNewFile,BufRead *.coffee{,script} setl ft=coffee
    au BufNewFile,BufRead *.vue{,js} setl ft=vue
    " ruby:
    au BufNewFile,BufRead Rakefile,Capfile,Gemfile,Guardfile,Vagrantfile
          \,Thorfile,Do,dorc,Dofile,config.ru,.autotest,.irbrc,.pryrc
          \,.simplecov,*.thor,*.rabl setl ft=ruby
    " vim and shell files:
    au BufNewFile,BufRead *vimrc,*.vim setl ft=vim
    au BufNewFile,BufRead *zshrc*,*zprofile,*zlogin,*zshenv* setl ft=sh
    " text files
    au BufNewFile,BufRead *.md,*.mdown,*.markdown setl ft=ghmarkdown
    " messes help text files
    " au BufNewFile,BufRead *.txt,*.text setl ft=text
    " php files
    au BufNewFile,BufRead *.ctp setl ft=ctp
    " go
    au BufNewFile,BufRead *.go setl ft=go
    " elixir
    au BufNewFile,BufRead *.ex,*.exs setl ft=elixir
    au BufNewFile,BufRead *.html.eex setl ft=html
    " miscelleneous
    au BufNewFile,BufRead gemrc,*.yml,*.yaml setl ft=yaml
    au BufNewFile,BufRead config setl ft=dosini
    au BufNewFile,BufRead *.rasi setl ft=css
  augroup end

  augroup markdown_codedetect
    au!
    au filetype html :call SyntaxRange#Include("<style>", "</style>", "css")
    au filetype html :call SyntaxRange#Include("<style.*sass.*>", "</style>", "scss")
    au filetype html :call SyntaxRange#Include("<style.*scss.*>", "</style>", "scss")
    au filetype html :call SyntaxRange#Include("<style.*less.*>", "</style>", "less")
    au filetype html :call SyntaxRange#Include("<script>", "</script>", "javascript")
    au filetype html :call SyntaxRange#Include("<script.*coffee.>", "</script>", "coffee")
    au filetype html :call SyntaxRange#Include("<script.*coffeescript.>", "</script>", "coffee")
  augroup END
" }}}
" Essential:   sets up a sane editing/coding environment as per the filetype {{{
  augroup setup_environment
    au!
    au filetype css,less,sass,scss      set ts=2 sw=2 sts=2 tw=80 et
    au filetype json,javascript,coffee  set ts=2 sw=2 sts=2 tw=80 et
    au filetype python                  set ts=4 sw=4 sts=4 tw=80  et
    au filetype ruby,eruby              set ts=2 sw=2 sts=2 tw=80 et
    au filetype php,ctp                 set ts=4 sw=4 sts=4 tw=80  et
    au filetype sh,vim                  set ts=2 sw=2 sts=2 tw=72  et
    au filetype ghmarkdown,textile      set ts=4 sw=4 sts=4 tw=100 et
    au filetype rst                     set ts=4 sw=4 sts=4 tw=74  et
    au filetype yaml                    set ts=2 sw=2 sts=2 tw=72  et
    au filetype html,xhtml,haml         set ts=2 sw=2 sts=2 tw=120 et
    au filetype make                    set noet " make uses real tabs
    au filetype vue                     set ts=2 sw=2 sts=2 tw=80 et
  augroup end
" }}}
" Essential:   sets up folding for the current file as per its filetype {{{
  augroup create_folds
    au!
    au filetype css,less,sass,scss set fdm=marker fmr={,}
    au filetype coffee             set fdm=indent fdls=1
    au filetype javascript         set fdm=syntax fdls=1
    au filetype ruby,eruby         set fdm=syntax
    au filetype sh,zsh,bash,vim    set fdm=marker fmr={{{,}}} fdls=0 fdl=0
    au filetype yaml,conf          set fdm=marker fmr={{{,}}} fdls=0 fdl=0
  augroup end
" }}}
" Essential:   sets up syntax as per the filetype or other variables {{{
  augroup syntax_higlighting
    au!
    au filetype json,javascript    set syntax=javascript
    au filetype ctp                set syntax=php
    " javascript syntax should be enhanced via jquery syntax
    au syntax   javascript         set syntax=jquery
  augroup end
" }}}
" Essential:   sets up whitespace visibility as per the filetype {{{
  augroup whitespace
    au!
    au filetype ghmarkdown,textile,text,rst set nolist
    au filetype coffee,javascript set listchars=trail:·,extends:#,nbsp:·
  augroup end
" }}}
" Essential:   turns on spell checking and automatic wrap on text files {{{
  augroup text_files
    au!
    au filetype ghmarkdown,textile,rst set wrap wrapmargin=2
    au filetype ghmarkdown             set formatoptions+=w
    au filetype ghmarkdown,textile,rst set formatoptions+=qat
    au filetype ghmarkdown,textile,rst set formatoptions-=cro
  augroup end
" }}}
" Essential:   warns when text width exceeds predefined width in certain file types {{{
  augroup exceeded_text_width
    au!
    au filetype rst match ErrorMsg '\%>74v.\+'
    au filetype ruby,python match ErrorMsg '\%>80v.\+'
  augroup end
" }}}
" Essential:   has make programs defined for certain languages that does the heavy work {{{
  " Note: Dispatch does not support filename modifiers like: `%<`.
  "       Instead, use: `%:r`
  Plug 'tpope/vim-dispatch'

  " Press <F6> to run the make command.
  " To check output, open QuickFix with `<leader>qf` or `:copen`
  nnoremap <F5> :Dispatch<CR>

  augroup make_programs
    au!
    au filetype php set makeprg=php\ -l\ %    " linting
    au filetype rst set makeprg=rst2html.py\ %\ /tmp/%:r.html\ &&\ open\ /tmp/%:r.html

    " Note: for markdown, simply, open the file in Chrome, which uses an
    " extension to render this markdown file. Sweet and simple.
    " au filetype ghmarkdown setl makeprg=rdiscount\ %\ >\ /tmp/%:r.html\ &&\ open\ /tmp/%:r.html
    au filetype ghmarkdown let &l:makeprg = s:open_with_browser("%:p", 0)

    " allow the following files to run themselves when <F6> is pressed.
    au filetype sh set makeprg=chmod\ +x\ %:p\ &&\ %:p
    au BufRead,BufEnter *.{rb,py,php,js} if executable(expand("%:p")) &&
          \ ( &makeprg == "make" ) | set makeprg=%:p | endif

    " TODO: use a minifier as a make program for CSS & JS files
  augroup end
" }}}
" Essential:   provides documentation for certain languages via 'K' key {{{
  Plug 'Keithbsmiley/investigate.vim'
  map K :call investigate#Investigate()<CR><CR>

  let g:investigate_use_dash=1
  " NOTE: This does not work at the moment, as 'open' encodes the URL wrongly.
  " map docs for the following languages to http://devdocs.io
  " for fs in [ 'c', 'cpp', 'css', 'django', 'go', 'haskell', 'html',
  "           \ 'javascript', 'php', 'python', 'ruby', 'rails' ]
  "   execute( 'let g:investigate_url_for_'.fs.'="http://devdocs.io/#q='.fs.' ^s"')
  " endfor
  " let g:investigate_url_for_coffee = 'http://devdocs.io/#q=coffeescript ^s'

  augroup documentor
    au!

    " appropriately use rails docs when inside a rails buffer
    au User Rails silent! let g:investigate_syntax_for_ruby="rails"
    au BufLeave *.rb silent! let g:investigate_syntax_for_ruby="ruby"

    " vim has additional help available via 'gK' mapping
    au filetype vim silent! nmap gK :let g:investigate_use_url_for_vim = 1<CR>
          \ :call investigate#Investigate()<CR><CR>
          \ :let g:investigate_use_url_for_vim = 0<CR>
  augroup end
" }}}
" " Essential:   supports CODE LINTING (error-checking) for many languages {{{
  " Plug 'neomake/neomake'
  " autocmd! BufWritePost * Neomake
  " let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']
  " let g:neomake_python_enabled_makers = ['pep8', 'pylint']

  Plug 'Chiel92/vim-autoformat'
  noremap <F4> :Autoformat<CR>:w<CR>
"   Plug 'scrooloose/syntastic'
"   let g:syntastic_check_on_open            = 1
"   let g:syntastic_aggregate_errors         = 0
"   let g:syntastic_auto_jump                = 2
"   let g:syntastic_enable_signs             = 1
"   let g:syntastic_auto_loc_list            = 2
"   let g:syntastic_error_symbol             = '✗'
"   let g:syntastic_warning_symbol           = '⚠'
"   let g:syntastic_style_error_symbol       = '☢'
"   let g:syntastic_style_warning_symbol     = '☢'
"   let g:syntastic_always_populate_loc_list = 1
"   let g:syntastic_enable_balloons          = 1
"   let g:syntastic_enable_highlighting      = 1
"   let g:syntastic_id_checkers              = 1
"   " list of available checkers:
"   " https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers
"   " let g:syntastic_python_checkers  = ['flake8']
"   " let g:syntastic_ruby_checkers  = ['mri', 'rubocop']
"   " let g:syntastic_ruby_rubocop_exec = expand("$RBENV_ROOT/shims/rubocop-no-warning")
"   let g:syntastic_mode_map = { "mode": "passive",
"                               \ "active_filetypes": ["ruby", "php", "python"],
"                               \ "passive_filetypes": ["html"] }
"   function! ToggleErrors()
"       let old_last_winnr = winnr('$')
"       lclose
"       if old_last_winnr == winnr('$')
"           " Nothing was closed, open syntastic error location panel
"           Errors
"       endif
"   endfunction
"   nnoremap <silent> <leader>tl :<C-u>call ToggleErrors()<CR>
"   " enable integration with airline
"   let g:airline#extensions#syntastic#enabled = 1

"   " " haskell
"   " FIXME: move this into Syntastic itself?
"   " " Haskell post write lint and check with ghcmod
"   " " $ `cabal install ghcmod` if missing and ensure
"   " " ~/.cabal/bin is in your $PATH.
"   " if !executable("ghcmod")
"   "   autocmd BufWritePost *.hs GhcModCheckAndLintAsync
"   " endif
" " }}}
" }}}
" Language Specific:                                                 {{{
" Mappings:    HTML:               creates folds using tags {{{
  nnoremap <leader>ft Vatzf
" }}}
" Specialize:  HTML:               easily escape or unescape HTML {{{
  Plug 'skwp/vim-html-escape'
  " plugin mappings: <leader>he => escape | <leader>hu => unescape
" }}}
" Personalize: Ruby: Rails:        persist ctags when we move inside gem directories {{{
  augroup gem_ctags
    au!
    au filetype ruby,eruby setl tags+=$RBENV_ROOT/versions/*/lib/ruby/gems/*/gems/*/tags
  augroup END
" }}}
" Personlize: Ruby: Rails:         has command to quickly run specs {{{
" NOTE: this depends on vim-rspec plugin
  function! RunSpecs(...)
    let l:inside_app   = expand("%:h") =~ "app"
    let l:is_spec_file = expand("%:h") =~ "spec"
    if l:is_spec_file
      let l:path = expand("%")
    else
      let l:path = "spec/" . expand("%:h:t") . "/" . expand("%:t:r:r:r:r:r") . "_spec.rb"
      let l:path = substitute(l:path, "_spec_spec.rb", "_spec.rb", "g")
    end
    if filereadable(l:path)
      let l:path = a:0 && !empty(a:1) ? fnamemodify(l:path, a:1) : l:path
      let l:path = a:0 < 2 || empty(a:2) || l:inside_app ? l:path : l:path . a:2
      echo "Running specs: " . l:path
      execute substitute(g:rspec_command, "{spec}", l:path, "g")
    else
      echohl WarningMsg | echo "No such file found: " . l:path | echohl None
    endif
  endfunction
  let g:rspec_runner = "os_x_iterm2"
  if g:is_gui
    let g:rspec_command = 'Dispatch bundle exec bin/rspec {spec}'
  else
    let g:rspec_command = 'call VimuxRunCommand(" bin/rspec {spec}")'
  endif
  map <Leader>rsf :call RunSpecs()<CR>
  map <Leader>rsn :call RunSpecs("", ":" . line("."))<CR>
  map <Leader>rsl :call RunLastSpec()<CR>
  map <Leader>rsa :call RunSpecs(":h:h")<CR>
  map <Leader>rsg :call RunSpecs(":h")<CR>
" }}}
" Specialize:  Ruby:               has refactoring support for ruby code {{{
  Plug 'ecomba/vim-ruby-refactoring'
" }}}
" Specialize:  Markdown & Textile: render YAML front matter as comments {{{
  augroup yaml_front_matter
    au!
    au filetype ghmarkdown,textile syntax region frontmatter start=/\%^---$/ end=/^---$/
    au filetype ghmarkdown,textile highlight link frontmatter Comment
  augroup end
" }}}
" Specialize:  VIM:                binds <F6> to open plugin's Github URL in browser {{{
  " Test it here:   ' ''' ' \"''" \" '' \"' Plug 'nikhgupta/dotfiles' ''''''"
  " or, here: callPlugFunction 'some/asd'
  " FIXME: use regex and should also be able to open vim-scripts repos
  " Function: parses line containing a plugin, and opens it in browser {{{
  function! VimFindPlugName(line, delimiter)
    let segments = split(a:line, a:delimiter)
    let seg_len  = len(segments)
    for seg in segments
      let index = index(segments, seg)
      if ( index + 1 < seg_len ) && ( seg =~ "Plug " || seg =~ "Bundle " )
        return segments[index + 1]
      endif
    endfor
  endfunction
  function! VimPlugBrowser(line)
    let plugin = VimFindPlugName(a:line, "'")
    if empty(plugin) | let plugin = VimFindPlugName(a:line, '"') | endif
    if empty(plugin)
      echom 'Could not find a plugin definition on this line.'
    else
      execute(":OpenURL https://github.com/" . plugin)
    endif
  endfunction
  " }}}
  augroup vim_plugin_browser
    au!
    au filetype vim noremap <silent> <buffer> <F6>
          \ <Esc>:call VimPlugBrowser(getline('.'))<CR>
  augroup end
" }}}
" Mappings:    VIM:                quickly, edit or source the vim configuration {{{
  " edit the vimrc file
  nmap <leader>e. :vs<CR>:e $MYVIMRC<CR>
  " source the current file
  nmap <leader>bs :source %<CR>:set foldenable<CR>:e!<CR>
  " source a visual range
  vmap <leader>bs y:@"<CR>:echo 'Sourced the selected range.'<CR>
" }}}
" Mappings:    Help:               quickly navigate the help window {{{
  augroup help_window
    au!
    au filetype help nnoremap <buffer><cr> <c-]>
    au filetype help nnoremap <buffer><bs> <c-T>
    au filetype help nnoremap <buffer>q :q<CR>
  augroup end
" }}}
" Specialize: Elixir {{{
  Plug 'elixir-lang/vim-elixir'
  Plug 'slashmili/alchemist.vim'
  Plug 'c-brenn/phoenix.vim'
  Plug 'tpope/vim-projectionist'
  let g:alchemist_tag_disable = 1
" }}}
" }}}
" Security:                                                          {{{
" Recommend:   rejects modelines {{{
  set nomodeline                  " disable mode lines (security measure)
" }}}
" Recommend:   rejects per directory editor configuration {{{
  set noexrc                      " disble per-directory .vimrc files
  set secure                      " disable unsafe commands in them
" }}}
" Advanced:    encryption support {{{
" TODO: revisit
  " https://coderwall.com/p/hypjbg
  if exists("&cryptmethod") | set cryptmethod=blowfish | endif
  Plug 'jamessan/vim-gnupg'
  let g:GPGPreferArmor=1
  let g:GPGPreferSign=1
  let g:GPGDefaultRecipients=[$EMAIL, $EMAIL_PERSONAL, $EMAIL_WORK]
" }}}
" }}}
" Terminal:                                                          {{{
" Essential:   integrates with the user's login shell {{{
  " NOTE: DO NOT ENABLE INTERACTIVE SHELL OR TERMINAL VIM WILL SUSPEND ITSELF.
  " NOTE: For this reason, important environment variables, rbenv initialization,
  "       etc. must be placed inside ~/.zprofile, so that VIM can read them.
  if !g:is_windows
    if !empty('$SHELL')
      set shell=$SHELL\ -l
    elseif executable('zsh')
      set shell=zsh\ -l               " use a ZSH login shell
    elseif executable('bash')
      set shell=bash\ -l              " use a Bash login shell
    else
      set shell=/bin/sh
    endif
  endif
  Plug 'Shougo/vimshell.vim'
" }}}
" Expected:    uses a faster tty (terminal) & sets it title as per the file {{{
  set title                         " change the terminal's title
  set ttyfast                       " always use a fast terminal
" }}}
" Tweak:       sets appropriate terminal colors for the terminal {{{
  " set appropriate terminal colors
  " if &t_Co > 2 && &t_Co < 16
  "   set t_Co =16
  " elseif &t_Co > 16
  "   set t_Co =256
  " endif
" }}}
" }}}

" Git Workflow:                                                      {{{
" Specialize:  adds support for running git commands from within the editor {{{
  Plug 'tpope/vim-fugitive'
" }}}
" " Specialize:  displays git diff in sign column, and easily add hunks for staging {{{
  " Plug 'airblade/vim-gitgutter'
  " " enable gitgutter by default
  " let g:gitgutter_enabled = 1
  " " but do not display signs by default
  " let g:gitgutter_signs = 0
  " " ignore whitespace
  " let g:gitgutter_diff_args = '-w'
  " " use the raw grep command
  " " let g:gitgutter_grep_command = &grepprg
  " " highlight hunks by default
  " " let g:gitgutter_highlight_lines = 1
  " " let vim be snappier - don't lag.
  " let g:gitgutter_realtime = 0
  " let g:gitgutter_eager = 0
  " let g:gitgutter_async = 1

  " " remap mappings
  " let g:gitgutter_map_keys = 0
  " nmap ]h <Plug>GitGutterNextHunk
  " nmap [h <Plug>GitGutterPrevHunk
  " nmap <leader>hp <Plug>GitGutterPreviewHunk
  " nmap <leader>hs <Plug>GitGutterStageHunk
  " nmap <leader>hr <Plug>GitGutterRevertHunk
  " nmap <leader>tgg :GitGutterToggle<CR>
  " nmap <leader>tggs :GitGutterSignsToggle<CR>
  " nmap <leader>tggh :GitGutterLineHighlightsToggle<CR>
" " }}}
" Specialize:  enables support to manage Github Gists from the editor {{{
  Plug 'mattn/webapi-vim'
  Plug 'mattn/gist-vim'
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
" Specialize:  gitk like functionality inside the editor {{{
  Plug 'gregsexton/gitv'
" }}}
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
" }}}
" File Navigation:                                                   {{{
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
" Component:   provides a fuzzy finder for files, buffers, tags, etc. {{{
  if executable('fzf')
    set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " <C-p> or <C-t> to search files
    nnoremap <silent> <C-t> :FZF -m<cr>
    nnoremap <silent> <C-p> :FZF -m<cr>
    nnoremap <silent> <C-b> :Buffers<cr>
    nnoremap <silent> <C-o> :Buffers<cr>

    nnoremap <silent> <leader>fb :Buffers<cr>
    nnoremap <silent> <leader>ff :Files<cr>
    nnoremap <silent> <leader>ft :Tags<cr>
    nnoremap <silent> <leader>fh :History<cr>
    nnoremap <silent> <leader>fl :Lines<cr>
    nnoremap <silent> <leader>fgc :Commits<cr>
    nnoremap <silent> <leader>fgb :BCommits<cr>
    nnoremap <silent> <leader>fgf :GFiles<cr>
    nnoremap <silent> <leader>fft :Filetypes<cr>

    " Insert mode completion
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <expr> <c-x><c-g> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

    " Better command history with q:
    command! CmdHist call fzf#vim#command_history({'right': '40'})
    nnoremap q: :CmdHist<CR>

    " Better search history
    command! QHist call fzf#vim#search_history({'right': '40'})
    nnoremap q/ :QHist<CR>

    command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'down': '40%', 'options': --no-color'})
  else
    Plug 'ctrlpvim/ctrlp.vim'
    " notes:
    "   - when CtrlP window is open:
    "   : f5 will clear the CtrlP cache (useful if you add new files during the session)
    "   : <C-f> & <C-b> will cycle between CtrlP modes
    "   : Press <c-d> to switch to filename only search instead of full path.
    "   : Press <c-r> to switch to regexp mode.
    "   : Use <c-j>, <c-k> or the arrow keys to navigate the result list.
    "   : Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
    "   : Use <c-n>, <c-p> to select the next/previous string in the prompt's history.
    "   : Use <c-y> to create a new file and its parent directories.
    "   : Use <c-z> to mark/unmark multiple files and <c-o> to open them.
    " Set no max file limit
    let g:ctrlp_max_files = 100
    " Ignore files matching the following patterns
    let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
    " Store cache in this directory
    let g:ctrlp_cache_dir = expand("~/.vim") . "/tmp/cache/ctrlp"
    " Use ag/pt/rg in CtrlP for listing files. Lightning fast and respects .gitignore
    if executable("ag") | let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" --hidden' | endif
    if executable("pt") | let g:ctrlp_user_command = 'pt %s -l --nocolor -g "" --hidden' | endif
    if executable("rg") | let g:ctrlp_user_command = 'rg %s -l --nocolor -g "" --hidden' | endif

    " switch between buffers, easily.
    " disabling movement between buffers, because of this :)
    map <C-p> :CtrlPMRUFiles<CR>
    map <C-b> :CtrlPBuffer<CR>
    " Search from current directory instead of project root
    map <C-o> :CtrlP %:p:h<CR>
    nnoremap <leader>. :CtrlPTag<cr>
  endif
" }}}
" Upgrade:     provides a feature-rich file explorer in a sidebar {{{

  " Stop fucking netrw
  let g:netrw_silent = 1
  let g:netrw_quiet  = 1
  " let g:loaded_netrw = 1          " prevents loading of netrw, but messes 'gx'
  " let g:loaded_netrwPlug = 1    " ^ ..same.. and therefore, commented

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
" }}}
" Search And Replace:                                                {{{
" Essential:   has built-in smart search feature, which searches as you type {{{
  set ignorecase                  " makes searches ignore case
  set smartcase                   " if pattern has uppercase, be case-sensitive
  set wrapscan                    " search continues after the end of file
  set magic                       " use magic mode when searching/replacing
  set gdefault                    " search/replace globally (on a line) by default
  set incsearch                   " show search matches as you type
  if g:is_gui || &t_Co > 2 | set hlsearch | endif
  " clears the search register
  nmap <silent> <leader><cr> :nohlsearch<CR>
  Plug 'vim-scripts/IndexedSearch'
" }}}
" Expedite:    allows '*' or '#' keys to search for current word in normal or visual modes {{{
  Plug 'nelstrom/vim-visual-star-search'
" }}}
" Expedite:    allows replacing multiple variants of a word in a single go {{{
  " Supports converting to and from snake_case, camelCase, MixedCase & UPPER_CASE
  Plug 'tpope/vim-abolish'
" }}}
" Upgrade:     prefers 'rimgrep' over 'ack' for searching, when possible {{{
  if executable('rg')
    let g:ptprg='rg --vimgrep -S'
    set grepprg=rg\ --vimgrep\ -S
    Plug 'jremmen/vim-ripgrep'
    nnoremap <leader>a :Rg <Space>
  elseif executable('pt')
    Plug 'nazo/pt.vim'
    let g:ptprg='pt --vimgrep -S'
    set grepprg=pt\ --vimgrep\ -S
    nnoremap <leader>a :Pt <Space>
  elseif executable('ag')
    Plug 'rking/ag.vim'
    let g:agprg='ag --vimgrep -S'
    set grepprg=ag\ --vimgrep\ -S
    nnoremap <leader>a :Ag <Space>
  elseif executable('ack')
    Plug 'mileszs/ack.vim'
    nnoremap <leader>a :Ack --smart-case<Space>
  endif
" }}}
" Mappings:    display lines with keyword under cursor and ask to jump on one {{{
  " FIXME: when quitting from this command via <Esc>, it takes us to the first
  " match, instead of keeping the cursor in place.
  nmap <Leader>fs [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" }}}
" Mappings:    pull word under cursor into LHS of a substitute (for quick search and replace) {{{
  nmap <leader>fr :%s#\<<C-r>=expand("<cword>")<CR>\>#
" }}}
" }}}
" Undo Redo And Repeat:                                              {{{
" Essential:   has built-in persisting undo & redo, in branched form {{{
" Explaination: Persistence here means that your undo & redo data will be
" available even when you close the file, and try to edit it later.
  if has('persistent_undo')
    set undofile                  " have a long persisting undo data
    set undolevels=1000           " Maximum number of changes that can be undone
    set undoreload=10000          " Maximum number lines to save for undo on a buffer reload
    set undodir=~/.vim/tmp/undo,/tmp
  endif
" }}}
" Specialize:  allows traversing the undo/redo history as a graphical tree {{{
  Plug 'sjl/gundo.vim'

  " toggle gundo window
  nnoremap <leader>tgu :GundoToggle<CR>
" }}}
" Upgrade:     allows repeat operator (".") to work with plugins, too {{{
  " supports plugins namely: commentary, surround, abolish, unimpaired
  Plug 'tpope/vim-repeat'
" }}}
" Expected:    brings the cursor back when repeat command has been used {{{
  nmap . .`[
" }}}
" Expected:    allows using the repeat operator with visual selection {{{
  " see: http://stackoverflow.com/a/8064607/127816
  vnoremap . :normal .<CR>
" }}}
" }}}
" Clipboard And Yanking:                                             {{{
" Personalize: allows turning on paste mode with '<F2>' key {{{
  set pastetoggle=<F2>
" }}}
" Expedite:    allows pasting code easily, formats it, and reselects it for quick alignment {{{
  " function: paste using paste mode {{{
  function! PasteWithPasteMode(keys)
    if &paste
      execute("normal " . a:keys)
    else
      " Enable paste mode and paste the text, then disable paste mode.
      set paste
      execute("normal " . a:keys)
      set nopaste
    endif
  endfunction
  " }}}

  nnoremap <silent> <leader>p :call PasteWithPasteMode('p')<CR>`[v`]=`[v`]
  nnoremap <silent> <leader>P :call PasteWithPasteMode('P')<CR>`[v`]=`[v`]
" }}}
" Essential:   do share clipboard between editor and operating system {{{
  if g:is_nix && has('unnamedplus')
    set clipboard=unnamedplus,unnamed      " On Linux use + register for copy-paste
  elseif g:is_nvim && g:is_wsl && has('unnamedplus') && executable('win32yank.exe')
    set clipboard=unnamedplus,unnamed
  elseif g:is_wsl && executable('win32yank.exe')
    set clipboard=unnamed
    autocmd TextYankPost * call YankDebounced()

    function! Yank(timer)
      call system('win32yank.exe -i --crlf', @")
      redraw!
    endfunction

    let g:yank_debounce_time_ms = 500
    let g:yank_debounce_timer_id = -1

    function! YankDebounced()
      let l:now = localtime()
      call timer_stop(g:yank_debounce_timer_id)
      let g:yank_debounce_timer_id = timer_start(g:yank_debounce_time_ms, 'Yank')
    endfunction
  elseif has('unnamedplus')
    set clipboard=unnamedplus,unnamed
  else
    set clipboard+=unnamed                 " On mac and Windows, use * register for copy-paste
  endif
" }}}
" Specialize:  store and cycle through yanked text strings {{{
  Plug 'maxbrunsfeld/vim-yankstack'

  " do not use meta keys
  let g:yankstack_map_keys = 0
  " call yankstack#setup()                 " should happen after plugin indent?

  " for cycling what is pasted
  nmap <leader>pc <Plug>yankstack_substitute_older_paste

  " toggle YankStack window
  nnoremap <leader>tys :Yanks<CR>
" }}}
" Mappings:    reselects text that was just selected (or pasted) {{{
  nnoremap <leader>gv `[v`]
" }}}
" Expected:    pasting in visual mode replaces the selected text {{{
  vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
" }}}
" }}}
" Buffers Tabs And Windows:                                          {{{
" Recommend:   hide buffers instead of closing them {{{
  set hidden   " means that current buffer can be put to background without being written; and that marks and undo history are preserved.
" }}}
" Expected:    provides split editing behaviour, in an expected manner {{{
  set splitbelow                  " puts new split windows to the bottom of the current
  set splitright                  " puts new vsplit windows to the right of the current
  set equalalways                 " split windows are always of eqal size
  set switchbuf=useopen,split     " use existing buffer or else split current window
  set winheight=7               " squash splits or windows to a separator when minimized
  set winwidth=30               " squash splits or windows to a separator when minimized
  set winminheight=3              " squash splits or windows to a status bar only when minimized
  set winminwidth=12               " squash splits or windows to a separator when minimized
" }}}
" Expected:    resizes splits when the window is resized {{{
  augroup resize_splits
    au!
    au VimResized * :wincmd =
  augroup end
" }}}
" Advanced:    only opens 15 tabs when using '-p' CLI switch for the editor {{{
  set tabpagemax=15
" }}}
" Expedite:    Mappings: for easy control and navigation of windows {{{
  " resize splits/windows quickly
  map <C-W><C-=> <C-W>=
  map <C-W><C-M> <C-W>999+<C-W>999>

  " easy window navigation
  map <C-H> <C-W>h
  map <C-J> <C-W>j
  map <C-K> <C-W>k
  map <C-L> <C-W>l

  " easy window navigation with enlarged viewport (10 lines for other windows)
  map <C-W><C-H> <C-W>h<C-W><bar>
  map <C-W><C-J> <C-W>j<C-W>_
  map <C-W><C-K> <C-W>k<C-W>_
  map <C-W><C-L> <C-W>l<C-W><bar>
  map <C-W><C-T> <C-W>T
  " easily switch/rotate windows
  " for window layout: __|---
  map <C-W><space> <C-W>t<C-W>J<C-W>t<C-W>H

  " easily jump to a new buffer
  nnoremap <leader>el :buffers<CR>:buffer<Space>
  nnoremap <leader>e3 :e#
" }}}
" Expedite:    Mappings: open a new buffer with current file & switch to it {{{
  nnoremap <leader>wh <C-w>s
  nnoremap <leader>wv <C-w>v<C-w>l
" }}}
" Expedite:    Mappings: open a new buffer with previous file & switch to it {{{
  nnoremap <leader>ph :execute 'rightbelow split' bufname('#')<cr>
  nnoremap <leader>pv :execute 'leftabove vsplit' bufname('#')<cr>
" }}}
" Expected:    speeds up scrolling of the viewport slightly {{{
  nnoremap <C-e> 2<C-e>
  nnoremap <C-y> 2<C-y>
" }}}
" }}}
" Sessions:                                                          {{{
" Expected:    restores history, registers, etc. when a file is loaded {{{
  if has('viminfo')
    " ': Remember upto 500 files for which marks are remembered.
    " %: Save and restore the buffer list.
    " :: Remember upto 100 items in command-line history.
    " /: Remember upto 20  items in the search pattern history.
    " <: Remember upto 200 lines for each register.
    " f: Store file marks ('0 to '9 and 'A to 'Z)
    " Further, reading:  :h viminfo
    set viminfo='500,:100,@100,/20,f1,%,<200
    set viminfofile=$HOME/.viminfo
  endif
" }}}
" Expected:    restores editor's window's size, as well {{{
  if has('mksession')
    set sessionoptions+=resize
  endif
" }}}
" Expected:    remembers a long history of commands and searches performed {{{
  set history=1000
" }}}
" Expected:    restore cursor position on opening a file {{{
  augroup restore_cursor
    au!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
                          \ | exe "normal! g`\"" | endif
  augroup end
" }}}
" " Modernize:   automatically, saves and restores editor sessions {{{
"   " NOTE: vim-misc is required for vim-session
"   Plug 'xolox/vim-misc'
"   Plug 'xolox/vim-session'
"   let g:session_autoload = 'yes'
"   let g:session_autosave = 'yes'
"   " let g:session_default_overwrite = 1
"   let g:session_default_to_last = 1
"   " let g:session_command_aliases = 1

"   nnoremap <leader>QA :call SaveSessionWithPrompt()<CR>:qall<CR>
"   " Function: save session by prompting the user for a session name {{{
"   function! SaveSessionWithPrompt()
"     " guess name from current session, if any
"     let name = xolox#session#find_current_session()
"     let is_tab_scoped = xolox#session#is_tab_scoped()

"     " ask user for a session name, otherwise
"     if empty(name)
"       let default_name = ''
"       if g:session_default_name
"         let default_name = g:session_default_name
"       endif

"       call inputsave()
"       let name = input('save session? by what name? ', default_name)
"       call inputrestore()
"     endif

"     " use the default session name, otherwise
"     if empty(name) && g:session_default_name
"       let name = g:session_default_name
"     endif

"     " save the given session
"     if xolox#session#is_tab_scoped()
"       call xolox#session#save_tab_cmd(name, '!', 'SaveTabSession')
"     else
"       call xolox#session#save_cmd(name, '!', 'SaveSession')
"     endif

"   endfunction
"   " }}}
" " }}}
" }}}
" Utilities:                                                         {{{
" Expedite:    has helper commands to run simple unix commands, like `chmod` {{{
  Plug 'tpope/vim-eunuch'
" }}}
" Expedite:    provides mappings to quickly toggle specific editor features {{{
  " TODO: remove mappings obsolete because of this plugin
  Plug 'tpope/vim-unimpaired'
" }}}
" Mappings:    provides replaying a macro linewise on a visual selection {{{
  " note that, the macro must be recorded in the `v` register
  vnoremap <leader>qv :normal @v
" }}}
" " Expedite:    provides a way to learn VIM easily via recipes {{{
"   Plug 'esneider/recipes.vim'
"   nnoremap <Leader>r :CtrlPRecipes<CR>
" " }}}
  Plug 'irrationalistic/vim-tasks'

  let g:TasksMarkerBase = '☐'
  let g:TasksMarkerDone = '✔'
  let g:TasksMarkerCancelled = '✘'
  let g:TasksDateFormat = '%Y-%m-%d %H:%M'
  let g:TasksAttributeMarker = '@'
  let g:TasksArchiveSeparator = '＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿'

  augroup task_plugin
    au!
    autocmd BufNewFile,BufReadPost *.TODO,TODO,*.todo,*.todolist,*.taskpaper,*.tasks set filetype=tasks
  augroup end
" }}}
" Miscelleneous:                                                     {{{
" Recommend:   allows incr/decr with <C-x> & <C-a> for alphabets, numbers & hex {{{
  set nrformats-=octal            " do not treat octal as numbers
  set nrformats+=alpha            " but, allow inc/dec on alphabetical letters
" }}}
" Component:   scratchable buffer for scrappables {{{
  Plug 'duff/vim-scratch'
  nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>
" }}}
" Mappings:    toggles QuickFix window using '<leader>qf' {{{
  " Function: Quickly toggle in/out the QuickFix window {{{
  function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
      cclose
      unlet g:qfix_win
    else
      copen 10
      let g:qfix_win = bufnr("$")
    endif
  endfunction " }}}
  command! -bang -nargs=? QFix call QFixToggle(<bang>0)
  nmap <silent> <leader>qf :QFix<CR>
" }}}
" Mappings:    quickly, obfuscates the current buffer {{{
  nnoremap <F9> mzggg?G'z
" }}}
" Specialize:  has a command that shows the MD5 of the current buffer or range {{{
  command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')
" }}}
" Specialize:  SimpleNote: note-taking via vim {{{
  Plug 'mrtazz/simplenote.vim'
  let g:SimplenoteUsername=$SIMPLENOTE_USER
  let g:SimplenotePassword=$SIMPLENOTE_PASS
  let g:SimplenoteFiletype="markdown"
  let g:SimplenoteListHeight=30
" }}}
" }}}
" Abbreviations:                                                     {{{
  " auto-corrections for spellings
  " call SourceIfReadable('~/.vim/spell/autocorrect.vim')
  iabbr NG@  Nikhil Gupta
  iabbr CS@  CodeWithSense

  iabbr ng@  me@nikhgupta.com
  iabbr mg@  mestoic@gmail.com
  iabbr cs@  nick@codewithsense.com

  iabbr ng/  http://nikhgupta.com/
  iabbr cs/  https://codewithsense.com/
  iabbr gh/  http://github.com/
  iabbr ghn/ http://github.com/nikhgupta/

  iabbr nsig --<cr>Nikhil Gupta<cr>me@nikhgupta.com
  iabbr csig --<cr>Nikhil Gupta<cr>nick@codewithsense.com
" }}}
" Epilogue:                                                          {{{
  if filereadable("~/.gvimrc") | source ~/.gvimrc | endif
  if filereadable("~/.vimrc.local") | source ~/.vimrc.local | endif

  " this must come after `filetype plugin indent on` after latest vundle update
  Plug 'sonph/onehalf', {'rtp': 'vim/'}
  Plug 'trevordmiller/nova-vim'

  " if !g:is_macvim
  "   Plug 'ryanoasis/vim-devicons'
  "   let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
  "   let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  "   let g:DevIconsEnableFoldersOpenClose = 1
  "   if g:is_mac | let g:WebDevIconsOS = 'Darwin' | endif
  "   Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  "   let g:NERDTreeLimitedSyntax = 1

  "   let g:NERDTreeExtensionHighlightColor = { 'vue': '55b884',
  "         \ 'py': 'fddd55', 'sass': 'CB6F6F', 'php': '777bb3',
  "         \ 'yaml': 'ffffff', 'erb': 'CB6F6F', 'java': 'f49731',
  "         \ 'rabl': 'CB6F6F', 'thor': 'CB6F6F', 'tasks': '55b884',
  "         \ 'rb': 'CB6F6F', 'ru': 'CB6F6F' }

  "   let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {
  "         \ 'vue': '', 'yml': '', 'yaml': '', 'vim': '',
  "         \ 'c': '∁', 'cc': '∁', 'c++': '∁', 'cp': '∁', 'cpp': '∁',
  "         \ 'coffee': '♨', 'erb': '', 'rabl': '', 'tasks': '',
  "         \ 'thor': '', 'ru': '' }

  "   let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {
  "         \ '.*README.*$': '', 'Gemfile': '', 'Rakefile': '',
  "         \ '\..*zshenv.*$': '', '\..*zshrc.*$': '', '\..*vimrc.*$': '', }
  "   let g:NERDTreePatternMatchHighlightColor = {
  "         \ 'Gemfile': 'CB6F6F', 'Rakefile': 'CB6F6F' }

  "   augroup devicons_nerdtree
  "     au!
  "     autocmd FileType nerdtree setlocal nolist
  "   augroup END
  " end

  " required by vimPlug
  call plug#end()               " required

  " TrueColor support
  if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
  colorscheme snazzy
  " let base16colorspace=256
  " let g:airline_theme='nova'
  " hi! ColorColumn guibg=#556873 guifg=#F2C38F
  hi! ErrorMsg guifg=#D18EC2 guibg=#3C4C55
  hi link rubySymbol String
  " let g:gruvbox_contrast_dark = "soft"
  " colorscheme gruvbox
  " set bg=dark
  " colors dracula
  let g:airline_theme='cool'
  " colorscheme onehalflight
  " set bg=light
  " if g:is_gui
  "   colorscheme solarized
  " else
  "   colorscheme solarized
  "   set bg=light
     " hi Folded term=standout ctermfg=248 ctermbg=237 guifg=#999999 guibg=#d2d2d2
     " hi! default link NERDTreeDirSlash NonText
  " endif
" }}}
