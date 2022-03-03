" considers '.', '-', & '#' characters as part of the keyword
set iskeyword-=.
set iskeyword-=:
set iskeyword-=#
set iskeyword-=-

" briefly blinks matching paranthesis for quick orientation
set showmatch                   " set show matching parenthesis
set matchtime=2                 " show matching parenthesis for 0.2 seconds

" SLOW: " adds or removes punctuation pairs when typing, smartly
" Plug 'kana/vim-smartinput'

" allows switching between alternate forms of code segments
Plug 'AndrewRadev/switch.vim'
nnoremap - :Switch<cr>

" supports snippets for many languages
Plug 'honza/vim-snippets'

" provides language support for various languages
Plug 'sheerun/vim-polyglot'

Plug 'pantharshit00/vim-prisma'
