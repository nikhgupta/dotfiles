#!/usr/bin/env bash

source ~/.zsh/utils.sh

_root=$(dirname $0)
if is_ubuntu || is_wsl_ubuntu; then
  bash $_root/bootstrap/ubuntu.sh
elif is_archlinux; then
  bash $_root/botostrap/archlinux.sh
fi

pushd ~/.dotfiles
git remote rm origin
git remote add origin git@github.com:nikhgupta/dotfiles
popd
