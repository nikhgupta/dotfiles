" TrueColor support
if &term =~# '^screen'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

Plug 'morhetz/gruvbox'
Plug '29decibel/codeschool-vim-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'minofare/VIM-Railscasts-Color-Theme'
Plug 'dracula/vim'
Plug 'connorholyday/vim-snazzy'
Plug 'arcticicestudio/nord-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ayu-theme/ayu-vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'chriskempson/vim-tomorrow-theme'
" Plug 'chriskempson/base16-vim'

" nord theme settings
let g:nord_bold = 1
let g:nord_italics = 0
let g:nord_underline = 0
let g:nord_italic_comment = 0
let g:nord_uniform_status_lines = 1
let g:nord_uniform_diff_background = 1
let g:cursor_line_number_background = 1

" ayu theme settings
let ayucolor="light"

" gruvbox theme settings
let g:gruvbox_contrast_dark = "soft"

" set theme and other related features via a function
" - should be called after plug#end()
function! ApplyThemeSettings(mode)
  if a:mode ==? "light" || (a:mode == "" && &background ==? "dark")
    set background=light
    let g:airline_theme = "solarized"
    colorscheme ayu
  elseif a:mode ==? "dark" || (a:mode == "" && &background ==? "light")
    set background=dark
    let g:airline_theme = "nord"
    colorscheme nord
  endif
endfunction

" press F10 to find highlight group for word under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" toggle light/dark mode via keybindings
let g:which_key_map.t.u.m = 'toggle UI light/dark mode'
nnoremap <silent> <leader>tum :call ApplyThemeSettings("")<CR>

" better ale themes
augroup theme_fix_highlights
  au!
  autocmd ColorScheme * hi! link rubySymbol Float

  " autocmd ColorScheme * hi! ColorColumn guibg=#556873 guifg=#F2C38F
  " autocmd ColorScheme * hi! ErrorMsg guifg=#c89899 guibg=bg
  " autocmd ColorScheme * hi Folded term=standout ctermfg=248 ctermbg=237 guifg=#999999 guibg=#d2d2d2
  " autocmd ColorScheme * hi! default link NERDTreeDirSlash NonText
augroup end
