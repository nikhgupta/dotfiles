" watch for file & directory changes, but don't auto-write files
set autoread                      " watch for file changes
set noautochdir                   " do not auto change the working directory
set noautowrite                   " do not auto write file when moving away from it.

" text scrolls automatically, when cursor reaches near the edges
set scrolloff=7                 " keep lines off edges of the screen when scrolling
set sidescroll=1                " brings characters in view when side scrolling
set sidescrolloff=15            " start side-scrolling when n chars are left
" set scrolljump=5                " lines to scroll when cursor leaves screen

" advocates UTF-8 encoding, against latin
scriptencoding utf-8
set encoding=utf-8 nobomb " BOM often causes trouble
set termencoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

" disables file backup, in favor of, versioning
set nobackup                      " do not keep backup files - it's 70's style cluttering
set nowritebackup                 " do not make a write backup
set noswapfile                    " do not write annoying intermediate swap files
" store swap files in one of these directories (in case swapfile is ever turned on)
if g:is_nvim
  set directory=~/.tmp/nvim/swaps,/tmp/nvim/swaps
else
  set directory=~/.tmp/vim/swaps,/tmp/vim/swaps
endif

" doesn't beep
set noerrorbells                  " don't beep
set visualbell t_vb=              " don't beep, remove visual bell char

" timeout on key combinations, e.g. mappings & key codes
set updatetime=250
set timeout                     " timeout on :mappings and key codes
set timeoutlen=600              " timeout duration should be sufficient to type the mapping
set ttimeoutlen=50              " timeout duration should be small for keycodes
" try pressing 'O' in normal mode in terminal editor

" allows OS to decide when to flush to disk
set nofsync       " improves performance

" ignores whitespace changes in the diff mode
if has("diff")
  set diffopt-=internal
  set diffopt+=iwhiteall  " Ignore whitespace changes (focus on code changes)
  set diffopt+=vertical   " use vertical splits for diff
  set diffopt+=hiddenoff
endif

" does not update the display when executing macros, registers, etc.
set lazyredraw

" has mouse support built-in
if has('mouse')
  set mouse=a          " enable using mouse if terminal supports it
  set mousehide        " hide mouse pointer when typing
endif
