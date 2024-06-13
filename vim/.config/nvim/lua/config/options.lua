-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.guifont = "FiraCode Nerd Font:h16"

-- resolve health check issues
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = vim.env.HOME .. "/.asdf/shims/python3"
vim.g.ruby_host_prog = vim.env.HOME .. "/.asdf/installs/ruby/3.2.0/bin/neovim-ruby-host"
