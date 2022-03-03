set nocompatible             " No to the total compatibility with the ancient vi

let mapleader      = "<\Space>"     " change mapleader key from / to space
let g:mapleader    = "<\Space>"     " some plugins may require this variable to be set
let maplocalleader = ","           " used inside filetype settings

source ~/.vim/utils.vim
call SourceIfExists(expand("$HOME")."/.vimrc.local.pre")

call InstallPlugManager()
call plug#begin(g:data_dir . "/bundle")
runtime macros/matchit.vim " require matchit

" ==========================================
call SourceConfig("core")
call SourceConfig("features")
call SourceConfig("languages")
" ==========================================

call SourceIfExists(expand("$HOME")."/.vimrc.local")
call plug#end()
call ApplyThemeSettings('dark')
call which_key#register('<space>', "g:which_key_map")
