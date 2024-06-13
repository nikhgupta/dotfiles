#!/usr/bin/env zsh

_root=$(dirname $(dirname $0))
source $_root/zsh/utils.sh

highlight "Installing asdf"
brew install asdf
asdfin() { asdf install $@ && asdf global $@; }

highlight "Installing node.js"
asdf plugin add nodejs
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdfin nodejs 12.9.1
asdfin nodejs 18.9.1
asdfin nodejs 22.2.0

# highlight "Installing erlang/elixir"
# asdf plugin add erlang
# asdf plugin add elixir
# brew install autoconf wxmac
# export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=$(brew --prefix openssl)"
# asdfin erlang 24.0.6
# asdfin elixir 1.12.3-otp-24
# unset KERL_CONFIGURE_OPTIONS

highlight "Installing ruby"
asdf plugin add ruby
asdfin ruby 2.7.2
asdfin ruby latest
asdf global ruby latest 2.7.2
gem install neovim maid
asdf reshim ruby

highlight "Installing python"
asdf plugin add python
asdfin python 2.7.18
asdfin python latest
asdf global python latest 2.7.18

highlight "Installing Lua"
asdf plugin add lua
asdfin lua latest
