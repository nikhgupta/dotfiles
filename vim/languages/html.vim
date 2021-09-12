Plug 'Chiel92/vim-autoformat'

" language specific plugins
Plug 'othree/html5.vim'                 " html 5
Plug 'lepture/vim-css'                  " CSS3
Plug 'cakebaker/scss-syntax.vim'        " SCSS
" Plug 'tpope/vim-haml'                   " haml, sass and scss
" Plug 'mattn/emmet-vim'
" Plug 'groenewege/vim-less'              " Less

Plug 'chrisbra/Colorizer'
let g:colorizer_auto_filetype='css,html,scss,vue'
let g:colorizer_colornames_disable = 1
let g:colorizer_colornames = 0

let g:which_key_map.t.e.h = 'toggle css colors'
nmap <leader>teh :ColorToggle<CR>

" creates folds using tags
let g:which_key_map.z.t = 'create folds using tags'
nnoremap <leader>zt Vatzf
