let g:python_host_prog = '/home/nikhgupta/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/nikhgupta/.pyenv/versions/neovim3/bin/python3'
let g:ruby_host_prog = '/home/nikhgupta/.rbenv/versions/2.5.1/bin/neovim-ruby-host'

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
