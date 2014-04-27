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
hi FoldColumn ctermfg=59 ctermbg=59 guifg=#252c31 guibg=#252c31

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
