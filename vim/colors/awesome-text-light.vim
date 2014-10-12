" Vim color file
" Created for viewing Text based content in a distraction free mode.

highlight clear

if exists('syntax_on')
  syntax reset
endif

set background=light

runtime colors/default.vim
let g:colors_name = 'Awesome Text (light)'

hi Normal guibg=gray95
hi NonText guifg=gray95
hi CursorLine guibg=gray90
hi Cursor guibg=#15abdd
hi ColorColumn guibg=gray90
hi CursorColumn guibg=gray90
" hi FoldColumn guibg=gray90 guifg=gray95

hi Title gui=bold guifg=gray25
hi MarkdownHeadingDelimiter gui=bold guifg=gray25
hi htmlSpecialChar guifg=black
hi markdownBold gui=bold guifg=gray25
hi markdownItalic guifg=gray25 gui=underline
hi markdownUrl guifg=#2fb3a6
hi markdownAutomaticLink guifg=#2fb3a6
hi markdownLinkText guifg=#317849
hi markdownUrlTitle guifg=#317849
hi markdownBlockquote guifg=#317849 gui=bold
hi markdownId guifg=#2fb3a6
hi markdownIdDeclaration guifg=#317849 gui=bold
hi markdownListMarker guifg=#317849
