Plug 'vim-scripts/SyntaxRange'

" don't try to highlight lines longer than 800 characters
set synmaxcol=200

" syntax highlight on, when terminal has colors
if g:is_gui || &t_Co > 2 | syntax on | endif

" Essential:   warns when text width exceeds predefined width in certain file types {{{
  augroup exceeded_text_width
    au!
    au filetype rst match ErrorMsg '\%>74v.\+'
    au filetype ruby match ErrorMsg '\%>120v.\+'
    au filetype python match ErrorMsg '\%>80v.\+'
  augroup end
" }}}
