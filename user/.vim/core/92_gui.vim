" GUI Fonts
if g:is_mac && g:is_gui && !g:is_vimr
  set guifont=FiraCode\ Nerd\ Font:h16
  if has("macligatures") | set macligatures | endif
elseif !g:is_vimr
  set guifont=Fira\ Code:h20
endif

" disables unnecessary interfaces in GUI
if g:is_gui
  " adjust the GUI accordingly
  set guioptions-=T   " Remove the toolbar
  set guioptions-=m   " Remove the menu
  set guioptions+=c   " Use console dialogs

  " remove scrollbars
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
endif

" switches to a fullscreen view on startup (default: on)
" This works in close cooperation with the 'time-aware-theme-switching' feature,
" and has not been tested a lot. If you toggle this setting, and still the
" editor switches to a fullscreen view, please review settings in the aforesaid
" feature.
" NOTE: This option is only present in Macvim.
if g:is_macvim
  set fuoptions="maxvert,maxhorz,background:Normal"
endif

" maximizes editor window when using GUI
if g:is_macvim
  if has("guiheadroom") | set guiheadroom=0 | endif
  set lines=999 columns=999   " maximize GUI window
  set guitablabel=%N/\ %t\ %M " show tab number, name and status
endif

if g:is_neovide
  let g:neovide_refresh_rate=140
  let g:neovide_fullscreen=v:false
  let g:neovide_input_use_logo=v:false
  let g:neovide_cursor_animation_length=0.01
  let g:neovide_cursor_trail_length=0.4
  let g:neovide_cursor_antialiasing=v:true
  let g:neovide_cursor_vfx_mode = "railgun"
  " let neovide_remember_window_size = v:true
  let g:neovide_input_use_logo=v:true
  let g:neovide_input_use_logo=v:true
endif
