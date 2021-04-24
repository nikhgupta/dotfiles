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
  set directory=~/.tmp/vim/swaps,/tmp/vim/swaps  " store swap files in one of these directories (in case swapfile is ever turned on)
" }}}
" Modernize:   doesn't beep - "that's rude, O' Odin!" {{{
  set noerrorbells                  " don't beep
  set visualbell t_vb=              " don't beep, remove visual bell char
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
    set diffopt-=internal
    set diffopt+=iwhiteall  " Ignore whitespace changes (focus on code changes)
    set diffopt+=vertical   " use vertical splits for diff
    set diffopt+=hiddenoff
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
  nnoremap <leader>rn :set relativenumber!<cr>
" }}}
" Tweak:       does not update the display when executing macros, registers, etc. {{{
  set lazyredraw
" }}}
" Essential:   has mouse support built-in {{{
  if has('mouse')
    set mouse=a          " enable using mouse if terminal supports it
    set mousehide        " hide mouse pointer when typing
  endif
" }}}
