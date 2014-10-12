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
" Vim color file
" Created for viewing Text based content in a distraction free mode.

highlight clear

if exists('syntax_on')
  syntax reset
endif

set background=dark

runtime colors/codeschool.vim
let g:colors_name = 'Awesome Text (dark)'

" comment: #414e58
" dull color: #9a9a9a

hi Title ctermfg=179 guifg=#e9c062 gui=bold
" hi FoldColumn ctermfg=59 ctermbg=59 guifg=#252c31 guibg=#252c31

hi MarkdownHeadingDelimiter ctermfg=179 guifg=#e9c062 gui=bold
hi MarkdownBold ctermfg=74 guifg=#68a9eb gui=bold

hi markdownItalic ctermfg=74 guifg=#68a9eb gui=underline
hi htmlSpecialChar guifg=black
hi markdownUrl guifg=#2fb3a6
hi markdownAutomaticLink guifg=#2fb3a6
hi markdownLinkText guifg=#317849
hi markdownUrlTitle guifg=#317849
hi markdownBlockquote guifg=#317849 gui=bold
hi markdownId guifg=#2fb3a6
hi markdownIdDeclaration guifg=#317849 gui=bold
hi markdownListMarker guifg=#317849

hi ColorColumn guibg=#2e373b
hi CursorColumn guibg=#2e373b
