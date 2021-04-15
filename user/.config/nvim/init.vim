let g:python_host_prog = '$HOME/.asdf/shims/python2'
let g:python3_host_prog = '$HOME/.asdf/shims/python3'
let g:ruby_host_prog = '$HOME/.asdf/shims/neovim-ruby-host'

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set shada='500,:100,@100,/20,f1,%,<200
set shadafile=~/.nviminfo
