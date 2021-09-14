" Plug 'vim-scripts/SyntaxRange'

" don't try to highlight lines longer than 800 characters
set synmaxcol=800

" tree-sitter for better syntax highlighting
if g:is_nvim
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()

  function! SyntaxHighlightWithTreesitter()
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  ignore_install = { "clang" },
  textobjects = { enable = true },
  highlight = {
    enable = true,
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF
  endfunction

  autocmd VimEnter * call SyntaxHighlightWithTreesitter()
  autocmd BufEnter * TSBufEnable highlight
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

" better treesitter themes
augroup theme_fix_highlights
  au!
  autocmd ColorScheme * hi! link TSSymbol Float

  " autocmd ColorScheme * hi! ColorColumn guibg=#556873 guifg=#F2C38F
  " autocmd ColorScheme * hi! ErrorMsg guifg=#c89899 guibg=bg
  " autocmd ColorScheme * hi Folded term=standout ctermfg=248 ctermbg=237 guifg=#999999 guibg=#d2d2d2
  " autocmd ColorScheme * hi! default link NERDTreeDirSlash NonText
augroup end
