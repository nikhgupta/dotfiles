let g:python_host_prog = '/home/nikhgupta/.bin/shims/python2'
let g:python3_host_prog = '/home/nikhgupta/.bin/shims/python3'
let g:ruby_host_prog = '/home/nikhgupta/.asdf/installs/ruby/2.7.1/bin/neovim-ruby-host'

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
