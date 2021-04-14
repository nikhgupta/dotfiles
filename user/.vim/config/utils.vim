" variables used within this config {{{
" os specific variables
let g:is_gui     = has('gui_running')
let g:is_mac     = has('mac') || has('macunix') || has('gui_macvim')
let g:is_nix     = has('unix') && !has('macunix') && !has("win32unix")
let g:is_ubuntu  = g:is_nix && system("uname -a") =~ "Ubuntu"
let g:is_windows = has('win16') || has('win32') || has('win64')
let g:is_wsl     = g:is_nix && system("uname -a") =~ "microsoft"
let g:is_nvim    = has('nvim')
let g:is_macvim  = g:is_mac && g:is_gui && has('gui_macvim')

" other relevant variables
let g:is_posix   = 1 " enable better bash syntax highlighting

" what kind of VIM UI we are working with?
if g:is_macvim                | let g:ui_type = "MVIM"
elseif g:is_gui               | let g:ui_type = "GUI"
elseif exists("$TMUX")        | let g:ui_type = "TMUX"
elseif exists("$COLORTERM")   | let g:ui_type = "CTERM"
elseif exists("$TERM")        | let g:ui_type = "TERM"
else | let g:ui_type = "????" | endif
" }}}
" functions: useful functions for this config {{{
  function! SourceConfig(path)
    for f in split(glob("~/.vim/config/" . a:path . '/**/*.vim'), '\n')
      exe 'source' f
    endfor
  endfunction

  function! SourceIfExists(path)
    if filereadable(a:path) | source a:path | endif
  endfunction

  function! InstallPlugManager()
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
  endfunction
" }}}
