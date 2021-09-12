#!/usr/bin/env bash

source ~/.zsh/utils.sh

_name=$(os_release)

if is_macosx; then
  echo "mac"
elif is_ubuntu; then
  echo "ubuntu"
elif is_wsl; then
  echo "wsl/$_name"
else
  echo $_name
fi
