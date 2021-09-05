" GUI Fonts
if g:is_mac && g:is_gui && !g:is_vimr
  set guifont=FiraCode-Regular:h16
  set macligatures
elseif !g:is_mac
  set guifont=Fira\ Code\ 12
  "set guifont=FuraCode\ Nerd\ Font\ Mono\ Regular:h16
  "set guifont=Fira\ Code\ Regular\ Nerd\ Font\ Complete\ Windows\ Compatible:h16
  "set guifont=Droid\ Sans\ Mono\ for\ Powerline:h16
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
if g:is_gui && !g:is_vimr
  if has("guiheadroom") | set guiheadroom=0 | endif
  set lines=999 columns=999   " maximize GUI window
  set guitablabel=%N/\ %t\ %M " show tab number, name and status
endif
