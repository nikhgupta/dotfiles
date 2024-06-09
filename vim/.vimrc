set nocompatible             " No to the total compatibility with the ancient vi

let mapleader      = "<\Space>"     " change mapleader key from / to space
let g:mapleader    = "<\Space>"     " some plugins may require this variable to be set
let maplocalleader = ","           " used inside filetype settings

source ~/.vim/utils.vim
call SourceIfExists(expand("$HOME")."/.vimrc.local.pre")

call InstallPlugManager()
call plug#begin(expand("$HOME") . "/.cache/vim/bundle")
runtime macros/matchit.vim " require matchit

" ==========================================
call SourceConfig("core")
call SourceConfig("features")
call SourceConfig("languages")
" ==========================================

call SourceIfExists(expand("$HOME")."/.vimrc.local")
call plug#end()
call ApplyThemeSettings('dark')

" open `whichkey` after single Space press and small wait
call which_key#register('<Space>', "g:which_key_map")
