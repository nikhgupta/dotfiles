Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

set noshowmode                  " don't show vim modes - let statusline do that
set report=0                    " always report number of lines changed
set shortmess+=filmnrxoOtT      " abbrev. vim-messages (avoids 'hit enter', also)

set cmdheight=2                 " use a status bar that is 2 rows high
set laststatus=2                " tell VIM to always put a status line in

if has('cmdline_info')
  set ruler                     " Show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
  set showcmd                   " show (partial) command in the last line of the screen this also shows visual selection info
endif

" Use :AirlineToggle to revert to this statusline
if has('statusline') && !exists('g:loaded_airline')
  set stl=\ \ \[_%{mode()}_]\ \ \ [%Y/%{&ff}]\ %F\ %m%r\
        \ %=[%{g:ui_type}]\ %-17.(%l,%c%V%)\ %p\%\%\ \ \ %LL\ TOTAL
endif

let g:airline_powerline_fonts = 1 " use powerline symbols
let g:airline_detect_modified = 1
" let g:airline_detect_paste = 1
" let g:airline_detect_crypt = 1
" let g:airline_detect_spell = 1
" let g:airline_detect_spelllang = 1
let g:airline_inactive_collapse = 0
" let g:thematic#defaults['airline-theme'] = DayOrNight("solarized", "base16")

let g:airline_skip_empty_sections = 1

" powerline symbols
" if get(g:, 'airline_powerline_fonts', 1)
" let g:airline_left_sep = "\uE0C4"
" let g:airline_right_sep = "\uE0C5"
" endif

" customize the Airline sections
let g:airline_section_y = "%{airline#util#wrap(airline#parts#ffenc() . ' ' . g:ui_type, 0)}"

" set a default airline theme, if none has, been defined!
if !exists('g:airline_theme') | let g:airline_theme = 'onedark' | endif
if !is_gui | let g:airline_theme = 'onedark' | endif

" displays tab titles in a beautiful way (via: Airline)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#excludes = ['*NERD*', '*Tagbar*', 'ControlP']
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffers_label = 'B'
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
"let g:airline#extensions#tabline#left_sep = ''
"let g:airline#extensions#tabline#right_sep = ''
