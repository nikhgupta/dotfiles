Plug 'vim-scripts/SyntaxRange'

" don't try to highlight lines longer than 800 characters
set synmaxcol=200

" tree-sitter for better syntax highlighting
if g:is_nvim
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

" syntax highlight on, when terminal has colors
if g:is_gui || &t_Co > 2 | syntax on | endif

" warns when text width exceeds predefined width in certain file types
augroup exceeded_text_width
  au!
  au filetype rst match ErrorMsg '\%>74v.\+'
  au filetype ruby match ErrorMsg '\%>120v.\+'
  au filetype python match ErrorMsg '\%>80v.\+'
augroup end
hi! ErrorMsg guifg=#c89899 guibg=bg

