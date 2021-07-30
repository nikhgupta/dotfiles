#!/usr/bin/env bash

source ~/.zsh/utils.sh

highlight "Installing asdf"
brew install asdf
asdfin() { asdf install $@ && asdf global $@; }

highlight "Installing node.js"
asdf plugin add nodejs
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdfin nodejs 14.4.0

highlight "Installing erlang/elixir"
asdf plugin add erlang
asdf plugin add elixir
brew install autoconf wxmac
export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=$(brew --prefix openssl)"
asdfin erlang 23.0.2
asdfin elixir 1.10.3-otp-23
unset KERL_CONFIGURE_OPTIONS

highlight "Installing ruby"
asdf plugin add ruby
asdfin ruby 2.7.2 2.4.6 2.4.10
gem install neovim maid
asdf reshim ruby

highlight "Installing python"
asdf plugin add python
asdf install python 2.7.18
asdf install python 3.8.3
asdf global python 3.8.3 2.7.18
