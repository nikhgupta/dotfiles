#!/usr/bin/env bash
# ---
# summary: |
#   decrypts $DOTCASTLE/.encrypted/security.asc to provide some
#   super secret functions written in ruby.

_file=$DOTCASTLE/.encrypted/security.asc
_destin=$HOME/.decrypted/security.rb

mkdir -p $(dirname $_destin)
gpg --decrypt $_file 2>/dev/null >$_destin

ruby $_destin $@
rm -f $_destin
