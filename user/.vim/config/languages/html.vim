Plug 'othree/html5.vim'                 " html 5
Plug 'lepture/vim-css'                  " CSS3
Plug 'groenewege/vim-less'              " Less
Plug 'cakebaker/scss-syntax.vim'        " SCSS
Plug 'tpope/vim-haml'                   " haml, sass and scss
" Plug 'mustache/vim-mustache-handlebars' " handlebars
" Plug 'mattn/emmet-vim'

Plug 'chrisbra/Colorizer'
let g:colorizer_auto_filetype='css,html,scss,vue'
let g:colorizer_colornames_disable = 1
let g:colorizer_colornames = 0
nmap <leader>tcol :ColorToggle<CR>

" Mapping: creates folds using tags
nnoremap <leader>ft Vatzf

" Specialize:  easily escape or unescape HTML
Plug 'skwp/vim-html-escape'
" plugin mappings: <leader>he => escape | <leader>hu => unescape
