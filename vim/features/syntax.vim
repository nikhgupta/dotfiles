" Plug 'vim-scripts/SyntaxRange'

" don't try to highlight lines longer than 800 characters
set synmaxcol=800

" tree-sitter for better syntax highlighting
if g:is_nvim
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()

  autocmd VimEnter * call SyntaxHighlightWithTreesitter()
  autocmd BufEnter * TSBufEnable highlight
endif

" syntax highlight on, when terminal has colors
if g:is_gui || &t_Co > 2 | syntax on | endif

" " warns when text width exceeds predefined width in certain file types
" augroup exceeded_text_width
"   au!
"   au filetype rst match ErrorMsg '\%>74v.\+'
"   au filetype ruby match ErrorMsg '\%>120v.\+'
"   au filetype python match ErrorMsg '\%>80v.\+'
" augroup end
" hi! ErrorMsg guifg=#c89899 guibg=bg

" better treesitter themes
augroup treesitter_fix_syntax_colors
  au!
  autocmd ColorScheme * hi! link TSSymbol Float
augroup end

function! SyntaxHighlightWithTreesitter()
  lua <<EOF

  -- -- for norg module
  -- local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
  -- parser_configs.norg = {
  --     install_info = {
  --         url = "https://github.com/nvim-neorg/tree-sitter-norg",
  --         files = { "src/parser.c", "src/scanner.cc" },
  --         branch = "main"
  --     },
  -- }

  require'nvim-treesitter.configs'.setup {
    ensure_installed = "",
    ignore_install = {},
    textobjects = { enable = true },
    highlight = {
      enable = true,
      disable = { },  -- list of language that will be disabled
    },
  }
EOF
endfunction
