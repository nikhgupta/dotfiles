#!/usr/bin/env bash

_file=$HOME/.dotfiles/.encrypted/security.asc
_destin=$HOME/.decrypted/security.rb

mkdir -p $(dirname $_destin)
gpg --decrypt $_file 2>/dev/null >$_destin

ruby $_destin $@
rm -f $_destin
