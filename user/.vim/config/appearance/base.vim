Plug 'morhetz/gruvbox'
Plug '29decibel/codeschool-vim-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'minofare/VIM-Railscasts-Color-Theme'
Plug 'dracula/vim'
Plug 'connorholyday/vim-snazzy'
Plug 'arcticicestudio/nord-vim'

" Plug 'chriskempson/base16-vim'
Plug 'chriskempson/vim-tomorrow-theme'

" TrueColor support
if &term =~# '^screen'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" use nord theme by default
let g:nord_bold = 0
let g:nord_italics = 0
let g:nord_underline = 0
let g:nord_italic_comment = 0
let g:nord_uniform_status_lines = 1
let g:nord_uniform_diff_background = 1
let g:cursor_line_number_background = 1

hi! link rubySymbol SpecialChar
let g:airline_theme='nord'

" " old theming
" let base16colorspace=256
" let g:airline_theme='nova'
" hi! ColorColumn guibg=#556873 guifg=#F2C38F
" hi! ErrorMsg guifg=#D18EC2 guibg=#3C4C55
" let g:gruvbox_contrast_dark = "soft"
" colorscheme gruvbox
" set bg=dark
" colors dracula
" colorscheme onehalflight
" set bg=light
" if g:is_gui
"   colorscheme solarized
" else
"   colorscheme solarized
"   set bg=light
" hi Folded term=standout ctermfg=248 ctermbg=237 guifg=#999999 guibg=#d2d2d2
" hi! default link NERDTreeDirSlash NonText
" endif
