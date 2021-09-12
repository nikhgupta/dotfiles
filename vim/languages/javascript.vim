Plug 'mmalecki/vim-node.js'           " Node.js

" javascript and variants
Plug 'pangloss/vim-javascript'        " Javascript
" Plug 'kchmck/vim-coffee-script'       " Coffeescript

" typescript
Plug 'leafgarland/typescript-vim'

" ui libraries
Plug 'itspriddle/vim-jquery'          " jQuery

" ui frameworks
Plug 'mxw/vim-jsx'                    " jsx (react)
" Plug 'posva/vim-vue'                  " Vue.js

" js related frameworks
" Plug 'dart-lang/dart-vim-plugin'
" Plug 'thosakwe/vim-flutter'

" set filetypes as typescriptreact
augroup reactscript
  au!
  autocmd BufNewFile,BufRead *.tsx   set filetype=typescriptreact
  autocmd BufNewFile,BufRead *.jsx   set filetype=javascriptreact
augroup END
