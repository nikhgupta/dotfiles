" Personalize: considers '.', '-', & '#' characters as part of the keyword {{{
  set iskeyword-=.
  set iskeyword-=#
  set iskeyword-=-
" }}}
" Expected:    briefly blinks matching paranthesis for quick orientation {{{
  set showmatch                   " set show matching parenthesis
  set matchtime=2                 " show matching parenthesis for 0.2 seconds
" }}}
" Expedite:    adds or removes punctuation pairs when typing, smartly {{{
  Plug 'kana/vim-smartinput'
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
" Essential:   supports snippets for many languages {{{
  " Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
" }}}
" Essential:   provides language support for various languages       {{{
Plug 'sheerun/vim-polyglot'
" }}}
