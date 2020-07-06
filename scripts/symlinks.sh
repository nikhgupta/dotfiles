#!/usr/bin/env bash

_root=$(realpath $(dirname $(dirname $0)))

source $DOTCASTLE/user/.zsh/utils.sh
highlight "Setting up symlinks to dotfiles"

safelink() { $DOTCASTLE/user/.bin/safelink.rb -v $@; }
dotlink_all() {
  mkdir -p $2
  for fd in $(find $1/ -maxdepth 1 -mindepth 1); do
    safelink $fd $2/$(basename $fd)
  done
}

for fd in $(find $_root/user/ -maxdepth 1 -mindepth 1); do
  case $(basename $fd) in
  .gnupg) dotlink_all $fd ~/.gnupg ;;
  .config) dotlink_all $fd ~/.config ;;
  .gitconfig) [[ -f ~/.gitconfig ]] || cp $_root/user/.gitconfig ~/.gitconfig ;;
  *) safelink $fd ;;
  esac
done

mackup restore
