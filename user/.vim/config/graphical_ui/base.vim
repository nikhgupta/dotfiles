" GUI Fonts
if g:is_mac && g:is_gui
  set guifont=FiraCode-Regular:h16
  set macligatures
else
  set guifont=Fira\ Code\ 12
  "set guifont=FuraCode\ Nerd\ Font\ Mono\ Regular:h16
  "set guifont=Fira\ Code\ Regular\ Nerd\ Font\ Complete\ Windows\ Compatible:h16
  "set guifont=Droid\ Sans\ Mono\ for\ Powerline:h16
endif

" Personalize: switches to a fullscreen view on startup (default: on) {{{
" This works in close cooperation with the 'time-aware-theme-switching' feature,
" and has not been tested a lot. If you toggle this setting, and still the
" editor switches to a fullscreen view, please review settings in the aforesaid
" feature.
" NOTE: This option is only present in Macvim.
  if g:is_macvim
    set fuoptions="maxvert,maxhorz,background:Normal"
  endif
" }}}
" Expected:    maximizes editor window when using GUI {{{ todo: extract
  if g:is_gui
    set guiheadroom=0
    set lines=999 columns=999   " maximize GUI window
    set guitablabel=%N/\ %t\ %M " show tab number, name and status
  endif
" }}}
" Advanced:    disables unnecessary interfaces in GUI {{{
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
" }}}
