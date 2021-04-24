let g:python_host_prog = '$HOME/.asdf/shims/python2'
let g:python3_host_prog = '$HOME/.asdf/shims/python3'
let g:ruby_host_prog = '$HOME/.asdf/shims/neovim-ruby-host'

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set shada='500,:100,@100,/20,f1,%,<200
" let &shadafile="/tmp/.nviminfo." . expand(trim(system("whoami")))
let &shadafile=expand("$HOME") . "/.nviminfo"

if has('diff') | set diffopt+=internal,algorithm:patience | endif
