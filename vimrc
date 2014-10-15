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
"   https://github.com/nikhgupta/dotfiles/blob/master/vimrc
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
"   tokens, etc. in `~/.zshenv.local`, so that they can be picked up by MacVim.
"
"   This VIM configuration does not split configuration between GUI and Terminal
"   VIM via a separate `~/.gvimrc`, and instead, incorporates it within this
"   file via a conditional `if` statement.
"
" }}}
" Compatibility: """""""""""""""""""""""""""""""""""""""""""""" {{{
"
"   I am on a MacOSX, and the configuration works wonderfully on it.
"
"   I have not, yet, checked this configuration for Linux environment, but
"   I am quite sure that the configuration should work nicely with it :)
"
"   Since, I never use Windows, this configuration might not be (and, I know for
"   a fact, that it won't be) compatible with it :(
"
"   I have, deliberately, removed any configuration that attempted to have such
"   a compatibility from this file, at around December, 2013.
"
" }}}
" Updated On:    """""""""""""""""""""""""""""""""""""""""""""" {{{
"
"   Here, you will find date ranges where I devoted much of my time configuring
"   this vim configuration. Note that, this section includes only major updates
"   starting from December, 2013.
"
"   :: 27/12/13 - 30/12/13  # 4 days
"   :: 30/05/14 - 31/05/14  # 2 days
"   :: 03/08/14 - 06/08/14  # 4 days
"
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORC:         """"""""""""""""""""""""""""""""""""""""""""""" {{{
"   To start vim without using this .vimrc file, use:
"     vim -u NORC
"
"   To start vim without loading any .vimrc or plugins, use:
"     vim -u NONE
" }}}
" Vim Tips:     """"""""""""""""""""""""""""""""""""""""""""""" {{{
"   - Press `F1` key on any keyword to get quick help!
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
" }}}
" Internal:                                                          {{{
" Internal:    developer-defined custom variables for this config {{{
  " os specific variables
  let g:is_gui     = has('gui_running')
  let g:is_mac     = has('mac') || has('macunix') || has('gui_macvim')
  let g:is_nix     = has('unix') && !has('macunix') && !has("win32unix")
  let g:is_macvim  = g:is_mac && g:is_gui && has('gui_macvim')
  let g:is_ubuntu  = g:is_nix && system("uname -a") =~ "Ubuntu"
  let g:is_windows = has('win16') || has('win32') || has('win64')

  " other relevant variables
  let g:is_posix   = 1 " enable better bash syntax highlighting

  " initialize plugin related dictionaries
  let g:thematic#defaults = {}
  let g:thematic#themes   = {}
" }}}
" Internal:    developer-defined custom functions for this config {{{
  " Function: Source a file, only if we can read it - display a message, optionally :) {{{
  function! SourceIfReadable(file, ...)
    let l:file = expand(a:file)
    if filereadable(l:file)
      execute "source" l:file
    elseif a:0 > 0 && a:1 == 1
      echomsg "Could not read file for sourcing: " . l:file
    endif
  endfunction " }}}
  " Function: Check if a given plugin is specified in this configuration {{{
    function! s:plugin_active(name)
      for plugin in g:bundles
        if plugin['name'] =~ a:name
          return plugin['name']
        endif
      endfor
      return ""
    endfunction
  " }}}
  " Function: Return first argument if day time, otherwise second argument {{{
  function! DayOrNight(day, night)
    let curr_hour = strftime("%H")
    return curr_hour > 7 && curr_hour < 19 ? a:day : a:night
  endfunction
  " }}}
  " Function: Quick distraction-free theme setup for Thematic {{{
  function! DistractionFree(theme)
    let l:theme = {
    \     'ruler': 1,
    \     'laststatus': 0,
    \     'sign-column-color-fix': 1,
    \     'fold-column-color-mute': 1,
    \     'number-column-color-mute': 1,
    \ }
    call extend(l:theme, a:theme)
    return l:theme
  endfunction
  " }}}
  " Function: Add a day night theme to thematic {{{
    function! AddDayNightThemeForThematic(name)
      let g:thematic#themes[a:name] = DayOrNight(
            \ g:thematic#themes[a:name . "-light"],
            \ g:thematic#themes[a:name . "-dark" ]
            \ )
    endfunction
  " }}}
" }}}
" }}}
" Preferences:                                                       {{{
" General:     has configurable leader keys {{{
  let mapleader      = ","     " change mapleader key from / to ,
  let g:mapleader    = ","     " some plugins may require this variable to be set
  let maplocalleader = "\\"    " used inside filetype settings
" }}}
" Appearance:  has configurable GUI fonts {{{
  if g:is_gui
    " Use a nice font on the specific OS
    " No support for Windows, again :)
    if g:is_mac
      set guifont=Monaco\ For\ Powerline:h15
    elseif g:is_ubuntu
      set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
    elseif g:is_nix
      set guifont=Monospace\ 11
    endif
  endif
" }}}
" Upgrade:     provides a way to customize the startup screen {{{
  " always show these bookmarks on the startup screen
  let g:startify_bookmarks = [ '~/.vimrc', '~/.zshrc', '~/.zshenv', '~/Code/__dotfiles' ]

  if executable('figlet')
    " fetch vim logo from ~/.vimlogo and update the logo if older than a day
    let s:startify_custom_footer_command = 'fortune -s; echo; echo;'.
          \ 'find ~/.vimlogo -mmin 1440 && cat ~/.vimlogo || '.
          \ '{ figlet -f "ANSI Shadow" VIM $(vim --version | '.
          \ 'head -1 | egrep "\d+\.\d+" -o) | tee ~/.vimlogo; }'
  elseif executable('fortune') && executable('cowsay')
    let s:startify_custom_footer_command = 'fortune -s | cowsay'
  elseif executable('fortune')
    let g:startify_custom_footer_command = 'fortune -s'
  endif
" }}}
" }}}

" General:                                                           {{{
" Essential:   has mouse support built-in {{{
  if has('mouse')
    set mouse=a          " enable using mouse if terminal supports it
    set mousehide        " hide mouse pointer when typing
  endif
" }}}
" Essential:   watch for file & directory changes, but don't auto-write files {{{
" TODO: if the working directory, contains a .git repo, stay on the repo root.
  set autoread                      " watch for file changes
  " FIXME: using autochdir may cause some plugins to work incorrectly
  set autochdir                     " automatically change the working directory
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
" }}}
" Tweak:       allows OS to decide when to flush to disk {{{
  set nofsync       " improves performance
" }}}
" Tweak:       ignores whitespace changes in the diff mode {{{
  if has("diff")
    set diffopt+=iwhite     " Ignore whitespace changes (focus on code changes)
  endif
" }}}
" }}}
" Plugins:                                                           {{{
" Component:   has a plugin manager to extend itself {{{
  " Auto-install Vundle, if not found
  let iCanHazVundle = 1
  if !filereadable(expand("~/.vim/bundle/vundle/README.md"))
    echo "Installing Vundle..\n"
    " :silent !mkdir -p ~/.vim/bundle
    :silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
  endif

  " turn filetype detection off (MacOSX Fix: http://bit.ly/17MENzJ)
  filetype on
  filetype off

  " initialize Vundle
  set rtp+=~/.vim/bundle/vundle
  call vundle#begin()

  " let Vundle manage Vundle:
  Plugin 'gmarik/vundle'

  " require matchit
  runtime macros/matchit.vim
" }}}
" Expected:    comes with default plugins that enhance the editor {{{
  Plugin 'bling/vim-airline'
  Plugin 'reedes/vim-thematic'
" }}}
" }}}
" Appearance:                                                        {{{
" Personalize: provides a variety of themes to choose from {{{
  Plugin 'wombat256.vim'
  Plugin 'ciaranm/inkpot'
  Plugin 'morhetz/gruvbox'
  Plugin 'DAddYE/soda.vim'
  " Plugin 'cstrahan/grb256'
  Plugin 'Pychimp/vim-luna'
  Plugin 'jnurmine/Zenburn'
  Plugin 'fugalh/desert.vim'
  Plugin 'nanotech/jellybeans.vim'
  " Plugin 'zenorocha/dracula-theme'
  Plugin '29decibel/codeschool-vim-theme'
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'minofare/VIM-Railscasts-Color-Theme'

  " collections:
  Plugin 'chriskempson/base16-vim'
  " Plugin 'chriskempson/vim-tomorrow-theme'
  " Plugin 'daylerees/colour-schemes', { 'rtp': 'vim-themes/' }
" }}}
" Personalize: highlight current line, but not the current column {{{
  set cursorline                  " highlight the current line for quick orientation
  set nocursorcolumn              " do not highlight the current column
  " toggle highlighting of cursor column - useful for manual indentation
  nnoremap <leader>tcc :set cursorcolumn!<CR>
" }}}
" Personalize: highlight column markers for several columns {{{
  if has('syntax')
    set colorcolumn=+1,+11,+21,+41
  endif
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
  nnoremap <C-n> :set relativenumber!<cr>
" }}}
" Personalize: switches to a fullscreen view on startup (default: on) {{{
" This works in close cooperation with the 'time-aware-theme-switching' feature,
" and has not been tested a lot. If you toggle this setting, and still the
" editor switches to a fullscreen view, please review settings in the aforesaid
" feature.
" NOTE: This option is only present in Macvim.
  if g:is_macvim | set fullscreen | endif
" }}}
" Expected:    maximizes editor window when using GUI {{{ todo: extract
  if g:is_gui
    set lines=999 columns=999   " maximize GUI window
    set guitablabel=%N/\ %t\ %M " show tab number, name and status
  endif
" }}}
" Expedite:    allows to highlight indentation guides (default: off) {{{
  Plugin 'nathanaelkane/vim-indent-guides'
  " NOTE: default map: <leader>ig
  nmap <silent> <Leader>igt <Plug>IndentGuidesToggle
  nmap <silent> <Leader>tig <Plug>IndentGuidesToggle

  let g:indent_guides_guide_size  = 1
  let g:indent_guides_start_level = 2
" }}}
" Upgrade:     has a beautiful startup screen (via Startify) {{{
  set shortmess+=I                " do not display intro message on Vim startup

  Plugin 'mhinz/vim-startify'
  " when opening a shortcut, switch to its directory
  let g:startify_change_to_dir = 1
  " enable 'empty buffer', and 'quit' commands
  let g:startify_enable_special = 0
  " display upto 10 recent files
  let g:startify_files_number = 5
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

  " display a fortune cookie (or output from custom command) as the footer
  if exists("s:startify_custom_footer_command")
    let g:startify_custom_footer = map(split(system(s:startify_custom_footer_command), '\n'), '"   ". v:val')
  else
    let g:startify_custom_footer = [  '    ██╗   ██╗██╗███╗   ███╗    ',
                                   \  '    ██║   ██║██║████╗ ████║    ',
                                   \  '    ██║   ██║██║██╔████╔██║    ',
                                   \  '    ╚██╗ ██╔╝██║██║╚██╔╝██║    ',
                                   \  '     ╚████╔╝ ██║██║ ╚═╝ ██║    ',
                                   \  '      ╚═══╝  ╚═╝╚═╝     ╚═╝    '  ]
  endif

  let g:startify_custom_footer = [ '   '.repeat('_', 60).' ', ''] + g:startify_custom_footer
  let g:startify_custom_footer = g:startify_custom_footer + [ '', '' ]

  " colors for startup screen
  hi! default link StartifyBracket Comment
  hi! default link StartifyFile    Type
  hi! default link StartifyFooter  String
  hi! default link StartifyHeader  String
  hi! default link StartifyNumber  Tag
  hi! default link StartifyPath    Comment
  hi! default link StartifySection Special
  hi! default link StartifySelect  Comment
  hi! default link StartifySlash   Comment
  hi! default link StartifySpecial Special

  " mappings and miscelleneous behaviour
  nmap <silent> <leader>st :Startify<CR>
  augroup vim_startup_screen
    au!
    au User Startified setl colorcolumn=0 buftype=
    au User Startified nnoremap <silent!> <buffer> <leader>st :e#<CR>
    au User Startified call airline#update_statusline()
  augroup end
" }}}
" Upgrade:     has a beautiful status line (via AirLine) {{{
  set showmode                    " always show what mode we're currently editing in
  set report=0                    " always report number of lines changed
  set shortmess+=filmnrxoOtT      " abbrev. vim-messages (avoids 'hit enter', also)

  set cmdheight=2                 " use a status bar that is 2 rows high
  set laststatus=2                " tell VIM to always put a status line in

  if has('cmdline_info')
    set ruler                     " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                   " show (partial) command in the last line of the screen this also shows visual selection info
  endif

  " variable used in statusline
  let g:ui_type = g:is_gui ? "GUI" : "TTY"

  " Use :AirlineToggle to revert to this statusline
  if has('statusline') && !exists('g:loaded_airline')
    set stl=\ \ \ \ \ [%Y/%{&ff}]\ %F\ %m%r%=[%{g:ui_type}]\ %-17.(%l,%c%V%)\ %p\%\%\ \ \ %LL\ TOTAL
  endif

  " use airline themes depending upon day or night time, as default in Thematic
  let g:airline_powerline_fonts  = 1 " use powerline symbols
  " use the given separator symbols (powerline enabled font required!)
  let g:airline_left_alt_sep     = ''
  let g:airline_right_alt_sep    = ''
  let g:thematic#defaults['airline-theme'] = DayOrNight("solarized", "base16")

  " customize the Airline sections
  let g:airline_section_x = "%{airline#util#wrap('['.g:ui_type.']', 0)}"
  let g:airline_section_y = "%{airline#util#wrap(airline#parts#ffenc() . ' ' . &ft, 0)}"

  " set a default airline theme, if none has, been defined!
  if !exists('g:airline_theme') | let g:airline_theme = 'solarized' | endif
" }}}
" Upgrade:     displays tab titles in a beautiful way (via: Airline) {{{
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 0
  " TODO: check if this works:
  let g:airline#extensions#tabline#excludes = ['*NERD*', '*Tagbar*', 'ControlP']
  let g:airline#extensions#tabline#tab_min_count = 2
  let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#show_close_button = 1
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline#extensions#tabline#right_sep = ''
  let g:airline#extensions#tabline#right_alt_sep = ''
" }}}
" Advanced:    can account for time of day, and switch themes accordingly {{{
  " use 256 colorspace support, since we want to use a base16 colorscheme.
  " NOTE: this requires `base16-shell` to be sourced by our ZSH configuration,
  " so that the terminal program can support 256 colorspace, as well.
  let base16colorspace = 256
  let g:base16_shell_path = $BASE16_SHELL
  let g:thematic#defaults["linespace"]  = 0

  if g:is_macvim
    let g:thematic#defaults["fullscreen"] = &fullscreen
    let g:thematic#defaults["fullscreen-background-color-fix"] = &fullscreen
  else
    let g:thematic#defaults["fullscreen"] = 1
    let g:thematic#defaults["fullscreen-background-color-fix"] = 1
endif

  let g:thematic#themes["default-dark"] = {
        \ 'colorscheme'  : 'base16-eighties',
        \ 'background'   : 'dark',
        \ 'airline-theme': 'base16' }
  let g:thematic#themes["default-light"] = {
        \ 'colorscheme'  : 'solarized',
        \ 'background'   : 'light',
        \ 'airline-theme': 'solarized' }
  call AddDayNightThemeForThematic('default')

  " switch theme on GUI as per day/night, but use dark version for terminal vim
  let g:thematic#theme_name = g:is_gui ? "default" : "default-dark"
  nmap <silent> <leader>csd :Thematic default<CR>
" }}}
" Advanced:    can account for time of day, and switch background accordingly {{{
  let g:thematic#defaults["background"] = DayOrNight("light", "dark")
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
" Advanced:    displays location marks visually (default: off) {{{
  Plugin 'xsunsmile/showmarks'
  let g:showmarks_enable = 0
  map <silent> <leader>smt :ShowMarksToggle<CR>
  map <silent> <leader>tms :ShowMarksToggle<CR>
  " <leader>mt : Toggles ShowMarks on and off.
  " <leader>mh : Hides an individual mark.
  " <leader>ma : Hides all marks in the current buffer.
  " <leader>mm : Places the next available mark.
" }}}
" Tweak:       uses vertical bar for insert mode in iTerm {{{ note: untested on other terminals
  " NOTE: only supported for iTerm users
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" }}}
" Tweak:       uses a non-blinking block cursor within GUI {{{
  if g:is_gui
    let &guicursor = substitute(&guicursor, 'n-v-c:', '&blinkon0-', '')
    set guicursor+=a:block-Cursor
  endif
" }}}
" Tweak:       does not update the display when executing macros, registers, etc. {{{
  set lazyredraw
" }}}
" Mappings:    supports loading of random colorschemes {{{
  nmap <silent> <leader>csr :ThematicRandom<CR>
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
  set listchars=tab:▸\ ,trail:·,extends:▶,precedes:◀,nbsp:·
" }}}
" Recommend:   wraps text automatically, when editing it {{{
  set nowrap                      " don't wrap lines
  set linebreak                   " break long lines at words, when wrap is on
  set whichwrap=b,s,h,l,<,>,[,]   " allow <BS> & cursor keys to move to prev/next line
  set showbreak=↪                 " string to put at the starting of wrapped lines
  set textwidth=80                " wrap after this many characters in a line
" }}}
" Expedite:    provides helpful movement keys to affect the surroundings of text {{{
  Plugin 'tpope/vim-surround'
" }}}
" Expedite:    adds more text objects to quickly modify the text {{{
  Plugin 'kana/vim-textobj-user'

  " indentations: i
  Plugin 'austintaylor/vim-indentobject'

  " " symbols: :
  " Plugin 'bootleq/vim-textobj-rubysymbol'

  " vertical columns by word boundary: c
  Plugin 'coderifous/textobj-word-column.vim'

  " " functions: f - does not support ruby/python/php by default
  " Plugin 'kana/vim-textobj-function'

  " " ruby blocks: r - works nearly same as indentobject
  " Plugin 'nelstrom/vim-textobj-rubyblock'

  " arguments: z
  Plugin 'kana/vim-textobj-fold'
" }}}
" Specialize:  supports multiple cursors for editing text in one go {{{
  Plugin 'terryma/vim-multiple-cursors'
  let g:multi_cursor_use_default_mapping = 0
  let g:multi_cursor_next_key='<F3>'
  let g:multi_cursor_prev_key=''
  let g:multi_cursor_skip_key=''
  let g:multi_cursor_quit_key='<Esc>'
" }}}
" Specialize:  allows focussing on a narrow region of the text {{{
  Plugin 'chrisbra/NrrwRgn'
  " remove highlighting for narrow region
  let g:nrrw_rgn_nohl = 1

  " TODO: implement a function that selects lines based on regex and opens a NRW
  " TODO: Open the current fold in a narrow region
  " nmap <leader>nf <esc><space>zRvaz<leader>nr<C-W>T<leader>f9
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
  nmap <leader>fef ggVG=''
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
  noremap <leader>q :q<CR>

  " quick save a file
  nnoremap <leader>w :w!<CR>

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
  nnoremap <silent> <leader>W  :%s/\v<C-v><C-m>//e<CR>:retab<CR>:%s/\s\+$//e<CR>:let @/=''<CR>:w<CR>
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
  set synmaxcol=800    " don't try to highlight lines longer than 800 characters
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
  Plugin 'tpope/vim-commentary'
  " From the FAQ:
  " > My favorite file type isn't supported!
  " > > Relax! You just have to adjust 'commentstring':
  "     autocmd FileType apache set commentstring=#\ %s
" }}}
" Expedite:    adds block-level end statements when hitting Enter key {{{
  Plugin 'tpope/vim-endwise'
" }}}
" Expedite:    adds or removes punctuation pairs when typing, smartly {{{
  Plugin 'kana/vim-smartinput'
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
  Plugin 'AndrewRadev/switch.vim'
  nnoremap - :Switch<cr>
" }}}
" Specialize:  provides a way to quickly align code segments {{{
  Plugin 'tsaleh/vim-align'
" }}}
" Advanced:    loads tag file when found, and adds some convenient mappings {{{
  set tags+=./tags,tags;/         " find and load tags file up until root

  " mappings:
  " TODO: what does this correspond to?
  nnoremap <silent> <leader>j :tnext<cr>zt
  nnoremap <silent> <leader>J :tprev<cr>zt
  nnoremap <silent> <leader>k :pop<cr>zt
  map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
  map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" }}}
" Component:   provides a tag browser (via: Tagbar) {{{
  Plugin 'Tagbar'
  let g:tagbar_autofocus = 1
  let g:tagbar_autoshowtag = 1
  let g:tagbar_width = 40
  let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
  nmap <leader>ttt :TagbarToggle<CR>
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
  " text markup family:
  " Plugin 'tpope/vim-markdown'             " mardown | #TODO: required?
  Plugin 'jtratner/vim-flavored-markdown' " Github flavored markdown syntax
  Plugin 'timcharper/textile.vim'         " textile markup

  " html & css family:
  Plugin 'DAddYE/html5.vim'               " html 5
  Plugin 'hail2u/vim-css3-syntax'         " CSS3
  Plugin 'groenewege/vim-less'            " Less
  Plugin 'cakebaker/scss-syntax.vim'      " SCSS
  Plugin 'tpope/vim-haml'                 " haml, sass and scss

  " javascript family:
  Plugin 'pangloss/vim-javascript'        " Javascript
  Plugin 'kchmck/vim-coffee-script'       " Coffeescript
  Plugin 'itspriddle/vim-jquery'          " jQuery
  Plugin 'mmalecki/vim-node.js'           " Node.js

  " php
  Plugin 'spf13/PIV'                      " PHP integrated environment

  "python
  " Python integrated environment
  " adds support for linting, doc search, execution, debugging, code completion, etc.
  Plugin 'klen/python-mode'

  " ruby
  Plugin 'vim-ruby/vim-ruby'
  Plugin 'tpope/vim-bundler'
  Plugin 'tpope/vim-rbenv'
  Plugin 'tpope/vim-rails'
  Plugin 'tpope/vim-rake'

  " miscelleneous:
  Plugin 'csv.vim'                        " CSV files
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

  " php
  Plugin 'shawncplus/phpcomplete.vim'

  " Plugin 'Valloric/YouCompleteMe'
  " " enable completion from tags
  " let g:ycm_collect_identifiers_from_tags_files = 1
  " " enable completion for keywords in current language
  " let g:ycm_seed_identifiers_with_syntax = 0

  if has('lua')
    Plugin 'Shougo/neocomplete.vim'
    let g:neocomplete#enable_at_startup = 1                 " enable at startup
    let g:neocomplete#enable_ignore_case = 1                " ignore case when completing
    let g:neocomplete#sources#syntax#min_keyword_length = 4 " use a minimum syntax keyword length
    let g:neocomplete#force_overwrite_completefunc = 1
    " do not complete automatically on files matching this pattern
    " let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    " let g:neocomplete#keyword_patterns['default'] = '\h\w*'
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
  else
    Plugin 'Shougo/neocomplcache.vim'
    let g:neocomplcache_enable_at_startup  = 1               " enable at startup
    let g:neocomplcache_enable_ignore_case = 1               " ignore case when completing
    let g:neocomplcache_min_syntax_length  = 4               " use a minimum syntax keyword length
    " do not complete automatically on files matching this pattern
    " let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
    " if !exists('g:neocomplcache_keyword_patterns')
      " let g:neocomplcache_keyword_patterns = {}
    " endif
    " let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
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
  endif

  " Enable omni completion.
  augroup omni_complete
    au!
    if exists('+omnifunc')
      " Enable omni completion for filetypes (Ctrl-X Ctrl-O)
      autocmd filetype html,ghmarkdown setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd filetype javascript setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd filetype python setlocal omnifunc=pythoncomplete#Complete
      autocmd filetype xml setlocal omnifunc=xmlcomplete#CompleteTags
      autocmd filetype c setlocal omnifunc=ccomplete#Complete
      autocmd filetype css setlocal omnifunc=csscomplete#CompleteCSS
      autocmd filetype java setlocal omnifunc=javacomplete#Complete
      autocmd filetype xml setlocal omnifunc=xmlcomplete#CompleteTags
      autocmd filetype haskell setlocal omnifunc=necoghc#omnifunc
      autocmd filetype ruby setlocal omnifunc=rubycomplete#Complete

      " use syntax complete if nothing else available
      autocmd filetype * if &omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif
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
" Essential:   supports CODE LINTING (error-checking) for many languages {{{
  Plugin 'scrooloose/syntastic'
  let g:syntastic_enable_signs             = 1
  let g:syntastic_auto_loc_list            = 1
  let g:syntastic_check_on_open            = 1
  let g:syntastic_error_symbol             = '✗'
  let g:syntastic_warning_symbol           = '⚠'
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_enable_balloons          = 1
  let g:syntastic_enable_highlighting      = 1

  " enable integration with airline
  let g:airline#extensions#syntastic#enabled = 1

  " " haskell
  " FIXME: move this into Syntastic itself?
  " " Haskell post write lint and check with ghcmod
  " " $ `cabal install ghcmod` if missing and ensure
  " " ~/.cabal/bin is in your $PATH.
  " if !executable("ghcmod")
  "   autocmd BufWritePost *.hs GhcModCheckAndLintAsync
  " endif
" }}}
" Essential:   supports snippets for many languages {{{
  Plugin 'Shougo/neosnippet'
  Plugin 'honza/vim-snippets'
  Plugin 'Shougo/neosnippet-snippets'

  noremap <leader>nse :NeoSnippetEdit -vertical -split -direction=belowright<CR>

  " Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1
  " tell NeoSnippet about other snippets
  let g:neosnippet#snippets_directory = [
        \ expand('~/.vim') . '/bundle/vim-snippets/snippets',
        \ expand('~/.vim') . '/data/snippets' ]

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
" Essential:   properly detects filetype for weird files or corrects them and adds syntax {{{
  augroup detect_filetypes
    au!
    " html & css family:
    au BufNewFile,BufRead *.less setl ft=less
    au BufNewFile,BufRead *.scss setl ft=scss
    au BufNewFile,BufRead *.sass setl ft=sass
    " javascript family:
    au BufNewFile,BufRead *.json setl ft=json
    " ruby:
    au BufNewFile,BufRead Rakefile,Capfile,Gemfile,Guardfile  setl ft=ruby
    au BufNewFile,BufRead Vagrantfile,Thorfile,Do,dorc,Dofile setl ft=ruby
    au BufNewFile,BufRead config.ru,.autotest,.irbrc,.pryrc   setl ft=ruby
    " vim and shell files:
    au BufNewFile,BufRead *vimrc,*.vim setl ft=vim
    au BufNewFile,BufRead *zshrc,*zprofile,*zlogout,*zlogin,*zshenv setl ft=zsh
    " text files
    au BufNewFile,BufRead *.md,*.mdown,*.markdown setl ft=ghmarkdown
    " messes help text files
    " au BufNewFile,BufRead *.txt,*.text setl ft=text
    " php files
    au BufNewFile,BufRead *.ctp setl ft=ctp
    " miscelleneous
    au BufNewFile,BufRead gemrc,*.yml,*.yaml setl ft=yaml
  augroup end
" }}}
" Essential:   sets up a sane editing/coding environment as per the filetype {{{
  augroup setup_environment
    au!
    au filetype html,xhtml,haml         setl ts=4 sw=4 sts=4 tw=0  et
    au filetype css,less,sass,scss      setl ts=2 sw=2 sts=2 tw=80 et
    au filetype json,javascript,coffee  setl ts=2 sw=2 sts=2 tw=80 et
    au filetype python                  setl ts=4 sw=4 sts=4 tw=80 et
    au filetype ruby,eruby              setl ts=2 sw=2 sts=2 tw=80 et
    au filetype php,ctp                 setl ts=4 sw=4 sts=4 tw=80 et
    au filetype sh,zsh,bash,vim         setl ts=2 sw=2 sts=2 tw=72 et
    au filetype ghmarkdown,textile      setl ts=4 sw=4 sts=4 tw=72 et
    au filetype rst                     setl ts=4 sw=4 sts=4 tw=74 et
    au filetype yaml                    setl ts=2 sw=2 sts=2 tw=72 et
    au filetype make                    setl noet " make uses real tabs
  augroup end
" }}}
" Essential:   sets up folding for the current file as per its filetype {{{
  augroup create_folds
    au!
    au filetype css,less,sass,scss setl fdm=marker fmr={,}
    au filetype coffee             setl fdm=indent fdls=1
    au filetype javascript         setl fdm=syntax fdls=1
    au filetype ruby,eruby         setl fdm=syntax
    au filetype sh,zsh,bash,vim    setl fdm=marker fmr={{{,}}} fdls=0 fdl=0
  augroup end
" }}}
" Essential:   sets up syntax as per the filetype or other variables {{{
  augroup syntax_higlighting
    au!
    au filetype json,javascript    setl syntax=javascript
    au filetype ctp                setl syntax=php
    " javascript syntax should be enhanced via jquery syntax
    au syntax   javascript         setl syntax=jquery
  augroup end
" }}}
" Essential:   sets up whitespace visibility as per the filetype {{{
  augroup whitespace
    au!
    au filetype ghmarkdown,textile,text,rst setl nolist
    au filetype coffee,javascript setl listchars=trail:·,extends:#,nbsp:·
  augroup end
" }}}
" Essential:   turns on spell checking and automatic wrap on text files {{{
  augroup text_files
    au!
    au filetype ghmarkdown,textile,rst setl wrap wrapmargin=2
    au filetype ghmarkdown                  setl formatoptions+=w
    au filetype ghmarkdown,textile,rst setl formatoptions+=qat
    au filetype ghmarkdown,textile,rst setl formatoptions-=cro
  augroup end
" }}}
" Essential:   warns when text width exceeds predefined width in certain file types {{{
  augroup exceeded_text_width
    au!
    au filetype python match ErrorMsg '\%>80v.\+'
    au filetype rst    match ErrorMsg '\%>74v.\+'
  augroup end
" }}}
" Essential:   has make programs defined for certain languages that does the heavy work {{{
  augroup make_programs
    " FIXME:   hardcoded shell commands
    au!
    au filetype php setl makeprg=php\ -l\ %    " linting
    au filetype ghmarkdown setl makeprg=rdiscount\ %\ >\ /tmp/%<.html\ &&\ open\ /tmp/%<.html
    au filetype rst setl makeprg=rst2html.py\ %\ /tmp/%<.html\ &&\ open\ /tmp/%<.html
  augroup end
" }}}
" Essential:   provides documentation for certain languages via 'K' key {{{
  augroup documentor
    au!
    au filetype vim setl keywordprg=:help
  augroup end
" }}}
" }}}
" Language Specific:                                                 {{{
" Mappings:    HTML:               creates folds using tags {{{
  nnoremap <leader>ft Vatzf
" }}}
" Specialize:  HTML:               easily escape or unescape HTML {{{
  Plugin 'skwp/vim-html-escape'
  " plugin mappings: <leader>he => escape | <leader>hu => unescape
" }}}
" " Specialize:  CSS:                view color previews {{{
"   Plugin 'skammer/vim-css-color'
" " }}}
" Specialize:  HTML & CSS:         provides a unique theme (focuses on content) {{{
  let g:thematic#themes['focus-dark']  = DistractionFree({'colorscheme': 'focus-dark' })
  let g:thematic#themes['focus-light'] = DistractionFree({'colorscheme': 'focus-light'})
  call AddDayNightThemeForThematic('focus')
  nmap <silent> <leader>csf :Thematic focus<CR>
" }}}
" Personalize: Ruby: Rails:        has command to quickly generate ctags {{{
  let g:rails_ctags_arguments = ['--languages=-javascript,sql',
        \ '--fields=+l', '--exclude=.git', '--exclude=log']
" }}}
" Specialize:  Text Markup:        provides distract-free editing theme with ByWord like UI {{{
  let g:thematic#themes['awesome-text-dark'] = DistractionFree({
        \    'colorscheme': 'awesome-text-dark',
        \    'typeface'   : 'Source Code Pro Light',
        \    'font-size'  : '24',
        \    'linespace'  : '8',
        \ })
  let g:thematic#themes['awesome-text-light'] = DistractionFree({
        \    'colorscheme': 'awesome-text-light',
        \    'typeface'   : 'Source Code Pro Light',
        \    'font-size'  : '24',
        \    'linespace'  : '8',
        \ })
  call AddDayNightThemeForThematic('awesome-text')
  nmap <silent> <leader>cst :Thematic awesome-text<CR>
" }}}
" Specialize:  Text Markup:        auto-switches to distraction-free theme {{{
  augroup distraction_free
    au!
    au BufRead,BufNewFile,BufEnter,TabEnter
          \ *.{md,mdown,markdown,rst,textile}
          \ if g:is_gui && (len(tabpagebuflist()) == 1)
          \ | execute "Thematic awesome-text" | execute "redraw!"
          \ | setl showtabline=0 rulerformat=%=%h%r%m\ %l/%LL | endif
    au BufHidden,BufLeave,TabLeave *.{md,mdown,markdown,rst,textile}
          \ if g:is_gui | execute "Thematic default"
          \ | execute "redraw!" | endif
  augroup end
" }}}
" Specialize:  Markdown & Textile: render YAML front matter as comments {{{
  augroup yaml_front_matter
    au!
    au filetype ghmarkdown,textile syntax region frontmatter start=/\%^---$/ end=/^---$/
    au filetype ghmarkdown,textile highlight link frontmatter Comment
  augroup end
" }}}
" Specialize:  Markdown:           allows quick preview via chrome browser {{{
  " NOTE: This requires that you have installed an appropriate chrome extension
  " for this purpose. What happens is that, editor opens the current file in the
  " chrome browser as a text file, which is then rendered by the extension for
  " previewing.
  " FIXME: fix this on linux
  augroup markdown_preview
    au!
    if g:is_mac
      autocmd filetype ghmarkdown exec 'noremap <F6> :silent !open %:p -a Google\ Chrome<CR>'
    elseif g:is_nix
      autocmd filetype ghmarkdown exec 'noremap <F6> :silent !xdg-open %:p<CR>'
    endif
  augroup end
" }}}
" Specialize:  VIM:                binds <F6> to open plugin's Github URL in browser {{{
  " Test it here:   ' ''' ' \"''" \" '' \"' Plugin 'nikhgupta/dotfiles' ''''''"
  " or, here: callPluginFunction 'some/asd'
  " FIXME: use regex and should also be able to open vim-scripts repos
  " Function: parses line containing a plugin, and opens it in browser {{{
  function! VimFindPluginName(line, delimiter)
    let segments = split(a:line, a:delimiter)
    let seg_len  = len(segments)
    for seg in segments
      let index = index(segments, seg)
      if ( index + 1 < seg_len ) && ( seg =~ "Plugin " || seg =~ "Bundle " )
        return segments[index + 1]
      endif
    endfor
  endfunction
  function! VimPluginBrowser(line)
    let plugin = VimFindPluginName(a:line, "'")
    if empty(plugin) | let plugin = VimFindPluginName(a:line, '"') | endif
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
          \ <Esc>:call VimPluginBrowser(getline('.'))<CR>
  augroup end
" }}}
" Mappings:    VIM:                quickly, edit or source the vim configuration {{{
  " edit the vimrc file
  nmap <leader>vi :vs<CR>:e $MYVIMRC<CR>
  " source the current file
  nmap <leader>vs :source %<CR>:set foldenable<CR>:e!<CR>
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
" }}}
" Expected:    uses a faster tty (terminal) & sets it title as per the file {{{
  set title                         " change the terminal's title
  set ttyfast                       " always use a fast terminal
" }}}
" Tweak:       prevents vim from clobbering the scrollback buffer {{{ todo: revisit
  " Prevent Vim from clobbering the scrollback buffer. See
  " http://www.shallowsky.com/linux/naltscreen.html
  set t_ti= t_te=
" }}}
" Tweak:       sets appropriate terminal colors for the terminal {{{
  " set appropriate terminal colors
  if &t_Co > 2 && &t_Co < 16
    set t_Co =16
  elseif &t_Co > 16
    set t_Co =256
  endif
" }}}
" Essential:   adds support to run shell commands and capture output in a buffer {{{
  Plugin 'sjl/clam.vim'
" }}}
" }}}

" Git Workflow:                                                      {{{
" Specialize:  adds support for running git commands from within the editor {{{
  Plugin 'tpope/vim-fugitive'
" }}}
" Specialize:  displays git diff in sign column (default: off) {{{
  Plugin 'airblade/vim-gitgutter'
  " do not enable gitgutter by default
  let g:gitgutter_enabled = 0
  " do not be eager - only work when reading/writing a file
  let g:gitgutter_eager = 0
  " ignore whitespace
  let g:gitgutter_diff_args = '-w'
  nmap <leader>ggt :GitGutterToggle<CR>
  nmap <leader>tgg :GitGutterToggle<CR>
" }}}
" Specialize:  enables support to manage Github Gists from the editor {{{
  Plugin 'mattn/webapi-vim'
  Plugin 'mattn/gist-vim'
  let g:gist_clip_command = 'pbcopy'
  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 1
  let g:gist_post_private = 0
  let g:gist_get_multiplefile = 1
  let g:gist_show_privates = 1
  let g:github_user = $GITHUB_USER
  let g:github_token = $GITHUB_TOKEN
  let g:snips_author = "$MY_NAME <$MY_MAIL>"
" }}}
" Specialize:  gitk like functionality inside the editor {{{
  Plugin 'gregsexton/gitv'
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
  set wildignore+=*/vendor/*          " stuff to ignore when tab completing ...
  set wildignore+=*/.hg/*,*/.svn/*
  set wildignore+=*vim/backups*       " ...
  set wildignore+=*/smarty/*          " ...
  set wildignore+=*/node_modules/*    " ...
  set wildignore+=*/.sass-cache/*     " ...
  set wildignore+=*/tmp/*,tmp/**      " ...
  set wildignore+=*/out/**,log/**     " ... phew!!
  " file suffixes that can be safely ignored for file name completion
  set suffixes+=.swo,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.DS_Store,.class,.so
  set suffixes+=.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll,.zip
  set suffixes+=.gem,.pdf,.avi,.mkv,.png,.jpg,.gif,.psd
" }}}
" Component:   provides a fuzzy finder for files, buffers, tags, etc. {{{
  Plugin 'kien/ctrlp.vim'
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
  let g:ctrlp_max_files = 0
  " Ignore files matching the following patterns
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  " Store cache in this directory
  let g:ctrlp_cache_dir = expand("~/.vim") . "/tmp/cache/ctrlp"
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  if executable("ag") | let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' | endif
  " switch between buffers, easily.
  " disabling movement between buffers, because of this :)
  map <C-b> :CtrlPBuffer<CR>
  " Search from current directory instead of project root
  map <C-o> :CtrlP %:p:h<CR>
  nnoremap <leader>. :CtrlPTag<cr>
" }}}
" Upgrade:     provides a feature-rich file explorer in a sidebar {{{

  " Stop fucking netrw
  let g:netrw_silent = 1
  let g:netrw_quiet  = 1
  " TODO: use `g:netrw_browserx_viewer` to set the binary for above command
  " let g:loaded_netrw = 1          " prevents loading of netrw, but messes 'gx'
  " let g:loaded_netrwPlugin = 1    " ^ ..same.. and therefore, commented

  Plugin 'scrooloose/nerdtree'

  " focus on nerdtree window
  nmap <leader>ntf :NERDTreeClose<CR>:NERDTreeFind<CR>

  " close nerdtree window
  nmap <leader>ntc :NERDTreeClose<CR>

  " toggle nerdtree window
  nmap <Leader>ntt <plug>NERDTreeToggle<CR>
  nmap <Leader>tnt <plug>NERDTreeToggle<CR>

  " change NerdTree's appearance
  let NERDTreeWinPos    = "left"
  let NERDChristmasTree = 1

  " Show hidden files, and bookmarks
  let NERDTreeShowFiles     = 1
  let NERDTreeShowHidden    = 0
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
  let NERDTreeBookmarksFile = expand("~/.vim") . "/tmp/bookmarks"

  " Sort NerdTree to show ruby php, vim and markdown files earlier
  let NerdTreeSortOrder = ['\/$', '\.rb$', '\.php$', '\.vim', '\.md', '\.markdown',
                          \ '*', '\.swp$',  '\.bak$', '\~$']

  " Don't display these kinds of files
  let NERDTreeIgnore = [ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
                      \ '\.so$', '\.egg$', '^\.git$', '^\.DS_Store' ]
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
" }}}
" Expedite:    allows '*' or '#' keys to search for current word in normal or visual modes {{{
  Plugin 'nelstrom/vim-visual-star-search'
" }}}
" Expedite:    allows replacing multiple variants of a word in a single go {{{
  " Supports converting to and from snake_case, camelCase, MixedCase & UPPER_CASE
  Plugin 'tpope/vim-abolish'
" }}}
" Upgrade:     prefers 'silver-searcher' over 'ack' for searching, when possible {{{
  if executable('ag')
    Plugin 'rking/ag.vim'
    let g:agprg='ag --nogroup --nocolor --column'
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    nnoremap <leader>a :Ag -S<Space>
  elseif executable('ack')
    Plugin 'mileszs/ack.vim'
    nnoremap <leader>a :Ack --smart-case<Space>
  endif
" }}}
" Upgrade:     pulsate the line when jumping to search term, and center the window over it {{{
  " Function: Pulsate the line containing the cursor {{{
  function! PulseCursorLine()
    let current_window = winnr()

    windo set nocursorline
    execute current_window . 'wincmd w'

    setlocal cursorline

    redir => old_hi
    silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 20m

    hi CursorLine guibg=#4a4a4a
    redraw
    sleep 30m

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 30m

    hi CursorLine guibg=#2a2a2a
    redraw
    sleep 20m

    execute 'hi ' . old_hi

    windo set cursorline
    execute current_window . 'wincmd w'
  endfunction
  " }}}
  nnoremap <silent> n   n:call PulseCursorLine()<cr>zz
  nnoremap <silent> N   N:call PulseCursorLine()<cr>zz
  nnoremap <silent> *   *:call PulseCursorLine()<cr>zz
  nnoremap <silent> #   #:call PulseCursorLine()<cr>zz
  nnoremap <silent> g* g*:call PulseCursorLine()<cr>zz
  nnoremap <silent> g# g#:call PulseCursorLine()<cr>zz
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
  Plugin 'sjl/gundo.vim'

  " toggle gundo window
  nnoremap <leader>gut :GundoToggle<CR>
  nnoremap <leader>tgu :GundoToggle<CR>
" }}}
" Upgrade:     allows repeat operator (".") to work with plugins, too {{{
  " supports plugins namely: commentary, surround, abolish, unimpaired
  Plugin 'tpope/vim-repeat'
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
" Personalize: allows pasting code easily with '<F2>' or '<leader>pp' keys {{{
  set pastetoggle=<F2>
  " toggle paste mode on and off
  map <leader>pp :setlocal paste!<cr>
" }}}
" Essential:   do share clipboard between editor and operating system {{{
  if g:is_nix && has('unnamedplus')
    set clipboard=unnamedplus,unnamed      " On Linux use + register for copy-paste
  else
    set clipboard+=unnamed                 " On mac and Windows, use * register for copy-paste
  endif
" }}}
" Expected:    context-aware indented pasting without enabling paste mode {{{
  Plugin 'sickill/vim-pasta'
  " disable pasta on some file types:
  let g:pasta_disabled_filetypes = ['python', 'coffee', 'yaml']
  " " enable paste on specific file types:
  " let g:pasta_enabled_filetypes = ['ruby', 'javascript', 'css', 'sh']
  " " make pasta use different mappings rather than overloading [p,P]
  " let g:pasta_paste_before_mapping = ',P'
  " let g:pasta_paste_after_mapping = ',p'
" }}}
" Specialize:  store and cycle through yanked text strings {{{
  Plugin 'maxbrunsfeld/vim-yankstack'

  " do not use meta keys
  let g:yankstack_map_keys = 0

  " use <left> and <right> keys for cycling what is pasted
  nnoremap <left>  <Plug>yankstack_substitute_older_paste
  nnoremap <right> <Plug>yankstack_substitute_newer_paste

  " toggle YankStack window
  nnoremap <leader>yst :Yanks<CR>
  nnoremap <leader>tys :Yanks<CR>
" }}}
" Mappings:    reselects text that was just pasted {{{
  nnoremap <leader>gv `[v`]
  nnoremap <leader>p  p`[v`]
  nnoremap <leader>P  P`[v`]
" }}}
" Mappings:    reselects text that was just pasted after formatting it {{{
  nnoremap <leader>gp p`[v`]=`[v`]
  nnoremap <leader>gP P`[v`]=`[v`]
" }}}
" Mappings:    deletes a line without adding it to the yanked stack {{{
  nmap <silent> <leader>d "_d
  vmap <silent> <leader>d "_d
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
" }}}
" Expected:    resizes splits when the window is resized {{{
  augroup resize_splits
    au!
    au VimResized * :wincmd =
  augroup end
" }}}
" Expected:    uses existing buffer, else splits the current window when opening a new file {{{
  set switchbuf=useopen,split
" }}}
" Expedite:    easily maximize the current buffer/split by pressing <C-w>o {{{
  " TODO: use a toggle key for this
    Plugin 'blueyed/ZoomWin'
  " }}}
" Advanced:    only opens 15 tabs when using '-p' CLI switch for the editor {{{
  set tabpagemax=15
" }}}
" Expedite:    Mappings: to resize windows easily {{{
  map <leader>= <C-w>=
" }}}
" Expedite:    Mappings: for easy navigation within windows {{{
  " easy window navigation
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
  " easy window navigation with maximize
  map <leader><C-h> <C-w>h<C-w><bar>
  map <leader><C-j> <C-w>j<C-w>_
  map <leader><C-k> <C-w>k<C-w>_
  map <leader><C-l> <C-w>l<C-w><bar>
" }}}
" Expedite:    Mappings: open a new buffer with current file & switch to it {{{
  nnoremap <leader>wh <C-w>s<C-w>k
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
"   Plugin 'xolox/vim-misc'
"   Plugin 'xolox/vim-session'
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
  Plugin 'tpope/vim-eunuch'
" }}}
" Expedite:    provides mappings to quickly toggle specific editor features {{{
  " TODO: remove mappings obsolete because of this plugin
  Plugin 'tpope/vim-unimpaired'
" }}}
" Mappings:    provides replaying a macro linewise on a visual selection {{{
  " note that, the macro must be recorded in the `v` register
  vnoremap <leader>qv :normal @v
" }}}
" }}}
" Miscelleneous:                                                     {{{
" Recommend:   allows incr/decr with <C-x> & <C-a> for alphabets, numbers & hex {{{
  set nrformats-=octal            " do not treat octal as numbers
  set nrformats+=alpha            " but, allow inc/dec on alphabetical letters
" }}}
" Component:   scratchable buffer for scrappables {{{
  Plugin 'duff/vim-scratch'
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
  nnoremap <f9> mzggg?G'z
" }}}
" Specialize:  has a command that shows the MD5 of the current buffer or range {{{
  command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')
" }}}
" Specialize:  SimpleNote: note-taking via vim {{{
  Plugin 'mrtazz/simplenote.vim'
  let g:SimplenoteUsername=$SIMPLENOTE_USER
  let g:SimplenotePassword=$SIMPLENOTE_PASS
  let g:SimplenoteFiletype="markdown"
  let g:SimplenoteListHeight=30
" }}}
" }}}
" Abbreviations:                                                     {{{
  " auto-corrections for spellings
  call SourceIfReadable('~/.vim/spell/autocorrect.vim')
  iabbr NG@  Nikhil Gupta
  iabbr WD@  Wicked Developers

  iabbr ng@  me@nikhgupta.com
  iabbr mg@  mestoic@gmail.com
  iabbr wd@  nikhil@wickeddevelopers.com

  iabbr ng/  http://nikhgupta.com/
  iabbr wd/  http://wickeddevelopers.com/
  iabbr gh/  http://github.com/
  iabbr ghn/ http://github.com/nikhgupta/

  iabbr nsig --<cr>Nikhil Gupta<cr>me@nikhgupta.com
  iabbr wsig --<cr>Nikhil Gupta<cr>nikhil@wickeddevelopers.com
" }}}
" Epilogue:                                                          {{{
  call SourceIfReadable("~/.gvimrc")
  call SourceIfReadable("~/.vimrc.local")
  " required by Vundle
  call vundle#end()               " required
  filetype plugin indent on       " enable detection, plugins and indenting in one step

  " install Plugins, if we just installed Vundle
  if iCanHazVundle == 0
    echo "Installing Plugins, please ignore key map error messages"
    :PluginInstall
  endif
" }}}

" TODOs:        """"""""""""""""""""""""""""""""""""""""""""""" {{{
"   - create a command that opens urls {{{
  if g:is_mac
    command! -bar -nargs=1 OpenURL :!open <args>
  endif
" }}}
"   - create functions to quickly add day-night themes via a simple function "   call
"   - add mappings for conque shell
"   - convert common functionality into a plugin
"   - display whether working in terminal or gui mode inside the airline statusbar
"   - revisit: http://learnvimscriptthehardway.stevelosh.com/
"   - implement Ranger file browser
"   - display syntax highlighting in foldtext
"   - auto-open fold when a search match is found or when it is jumped upon
"   - read and implement vim configuration from:
"     - https://github.com/skwp/dotfiles
"     - https://github.com/gf3/dotfiles
"     - https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
" }}}

" Learn More:
" 1. tpope/vim-eunuch
" 2. yankstack
" 3. nerdtree-tabs
