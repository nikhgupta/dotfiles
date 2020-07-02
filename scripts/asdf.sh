#!/usr/bin/env bash

source ~/.zsh/utils.sh

highlight "Installing asdf"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
pushd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
popd
. $HOME/.asdf/asdf.sh # source now
asdfin() { asdf install $@ && asdf global $@; }

highlight "Installing node.js"
asdf plugin add nodejs
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdfin nodejs 14.4.0

highlight "Installing erlang/elixir"
asdf plugin add erlang
asdf plugin add elixir
asdfin erlang 23.0.2
asdfin elixir 1.10.3-otp-23

highlight "Installing ruby"
asdf plugin add ruby
asdfin ruby 2.7.1

highlight "Installing python"
asdf plugin add python
asdf install python 2.7.18
asdf install python 3.8.3
asdf global python 3.8.3 2.7.18

highlight "Installing useful gems and pips"
gpip3 install pywal
asdf rehash python
asdf rehash ruby
