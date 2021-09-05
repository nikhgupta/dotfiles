" variables used within this config
" os specific variables
let g:is_mac     = has('mac') || has('macunix') || has('gui_macvim')
let g:is_nix     = has('unix') && !has('macunix') && !has("win32unix")
let g:is_ubuntu  = g:is_nix && system("uname -a") =~ "Ubuntu"
let g:is_windows = has('win16') || has('win32') || has('win64')
let g:is_wsl     = g:is_nix && system("uname -a") =~ "microsoft"

" which type of vim we are working with?
let g:is_nvim    = has('nvim')
let g:is_gui     = has('gui_running')
let g:is_macvim  = has('gui_macvim')
let g:is_vimr    = has('gui_vimr')
let g:is_vv      = exists("g:vv")

" other relevant variables
let g:is_posix   = 1 " enable better bash syntax highlighting
let g:data_dir   = g:is_nvim ? stdpath('data') . '/site' : '~/.vim'

" source config from a given directory
function! SourceConfig(path)
  for f in split(glob("~/.vim/" . a:path . '/**/*.vim'), '\n')
    exe 'source' f
  endfor
endfunction

" source a file if it exists
function! SourceIfExists(path)
  if filereadable(a:path) | source a:path | endif
endfunction

" install our plugin manager if not available
function! InstallPlugManager()
  if empty(glob(g:data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.g:data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endfunction
