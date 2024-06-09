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
asdf install ruby 2.7.2
asdf install ruby 3.3.0
asdf global ruby 3.3.0 2.7.2
gem install neovim maid
asdf reshim ruby

highlight "Installing python"
asdf plugin add python
asdf install python 2.7.18
asdf install python 3.12.4
asdf global python 3.12.4 2.7.18
