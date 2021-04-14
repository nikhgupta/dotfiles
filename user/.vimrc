" Credits:       """""""""""""""""""""""""""""""""""""""""""""" {{{
"
"            _ _    _                       _        _
"           (_) |  | |                     | |      ( )
"      _ __  _| | _| |__   __ _ _   _ _ __ | |_ __ _|/ ___
"     | '_ \| | |/ / '_ \ / _` | | | | '_ \| __/ _` | / __|
"     | | | | |   <| | | | (_| | |_| | |_) | || (_| | \__ \
"     |_| |_|_|_|\_\_| |_|\__, |\__,_| .__/ \__\__,_| |___/
"                          __/ |     | |
"                         |___/      |_|
"                            _       _    __ _ _
"                           | |     | |  / _(_) |
"                         __| | ___ | |_| |_ _| | ___  ___
"                        / _` |/ _ \| __|  _| | |/ _ \/ __|
"                       | (_| | (_) | |_| | | | |  __/\__ \
"                        \__,_|\___/ \__|_| |_|_|\___||___/
"
"
"   Hello, I am Nikhil Gupta, and
"   You can find me at http://nikhgupta.com
"
"   You can find an online version of this file at:
"   https://github.com/nikhgupta/dotfiles/blob/master/ubuntu/.vimrc
"
"   This is the personal vim configuration file of Nikhil Gupta.
"   While much of it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
"   ---
"
"   Configuration inside this file is meant to be utilized by VIM editor.
"   Please, note that GUI (Macvim) cannot read environment variables defined in
"   either `~/.zshrc` or `~/.zshrc.local`, which is why you MUST define your api
"   tokens, etc. in `~/.zshenv`, so that they can be picked up by MacVim.
"
"   This VIM configuration does not split configuration between GUI and Terminal
"   VIM via a separate `~/.gvimrc`, and instead, incorporates it within this
"   file via a conditional `if` statement.
"
" }}}
" Compatibility: """""""""""""""""""""""""""""""""""""""""""""" {{{
"
"   I used to be on a MacOSX, but have recently switched to using linux,
"   and the configuration works wonderfully on it.
"
"   I have not, yet, checked the latest configuration for OSX environment, but
"   I am quite sure that the configuration should work nicely with it :)
"
"   Since, I never use Windows, this configuration might not be (and, I know for
"   a fact, that it won't be) compatible with it :(
"
"   I have, deliberately, removed any configuration that attempted to have such
"   a compatibility from this file, at around December, 2013.
"
" }}}
" NORC:         """"""""""""""""""""""""""""""""""""""""""""""" {{{
"   To start vim without using this .vimrc file, use:
"     vim -u NORC
"
"   To start vim without loading any .vimrc or plugins, use:
"     vim -u NONE
" }}}
" Vim Tips:     """"""""""""""""""""""""""""""""""""""""""""""" {{{
"   - Press `Shift`+`K` key on any keyword to get quick help!
"   - Use `:X` to set encryption on any file
"   - Use `setl key=` to disable this encryption
"   - Use `gf` to open file under cursor using default file handler
"   - Use `gx` to open the current url using default url handler
"   - Use `''` to jump to location of the last jump
"   - Use `'.` to jump to location of your last edit
" }}}
" Inspirations: """"""""""""""""""""""""""""""""""""""""""""""" {{{
"   In no specific order:
"   - https://github.com/zenom/dotfiles
"   - https://github.com/jferris/config_files
"   - https://github.com/ryanb/dotfiles
"   - https://github.com/holman/dotfiles
"   - https://github.com/thoughtbot/dotfiles
"   - https://github.com/rtomayko/dotfiles
"   - https://github.com/garybernhardt/dotfiles
"   - https://github.com/amix/vimrc
"   - https://github.com/vgod/vimrc
"   - https://github.com/humiaozuzu/dot-vimrc
"   - https://github.com/sontek/dotfiles
"   - https://github.com/mathiasbynens/dotfiles
"   - https://github.com/nvie/vimrc
" }}}
" TodosAndIdeas: """"""""""""""""""""""""""""""""""""""""""""""" {{{
"   - use PGP keys for encryption
"   - display latest xkcd comic on Startify
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible             " No to the total compatibility with the ancient vi

let mapleader      = ","     " change mapleader key from / to ,
let g:mapleader    = ","     " some plugins may require this variable to be set
let maplocalleader = "\\"    " used inside filetype settings

source ~/.vim/config/utils.vim
call SourceIfExists("~/.vimrc.local.pre")

call InstallPlugManager()
call plug#begin('~/.vim/bundle')
runtime macros/matchit.vim " require matchit

call SourceConfig("defaults")
call SourceConfig("security")
call SourceConfig("appearance")
call SourceConfig("editor")
call SourceConfig("versioning")
call SourceConfig("programming")
call SourceConfig("languages")
call SourceConfig("mappings")
call SourceConfig("navigation")
call SourceConfig("graphical_ui")
call SourceConfig("integrations")

call SourceIfExists("~/.gvimrc")
call SourceIfExists("~/.vimrc.local")

call plug#end()
colorscheme nord
