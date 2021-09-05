" allows to highlight indentation guides (default: off)
Plug 'nathanaelkane/vim-indent-guides'

let g:which_key_map.t.e.i = 'toggle indent guides'
nmap <silent> <Leader>tei <Plug>IndentGuidesToggle

let g:indent_guides_guide_size  = 1
let g:indent_guides_start_level = 2
