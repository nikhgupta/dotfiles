#!/usr/bin/env bash

_file=$HOME/.dotfiles/secrets/security.asc
_destin=$HOME/.secrets/security.rb

mkdir -p $(dirname $_destin)
gpg --decrypt $_file 2>/dev/null > $_destin

ruby $_destin $@
rm -f $_destin
