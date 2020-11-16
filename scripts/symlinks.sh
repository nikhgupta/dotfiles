#!/usr/bin/env bash

_root=$(realpath $(dirname $(dirname $0)))

source $_root/user/.zsh/utils.sh
highlight "Setting up symlinks to dotfiles"

safelink() { $_root/user/.bin/safelink.rb -v $@; }
dotlink_all() {
  mkdir -p $2
  for fd in $(find $1 -maxdepth 1 -mindepth 1); do
    safelink "$fd" "$2/$(basename $fd)"
  done
}

applink() {
  _src="$_root/user/.app/$1"
  _dst="$HOME/Library/Application Support/$1"
  if [[ -n "$2" ]]; then
    shift
    while test ${#} -gt 0; do
      mkdir -p "$_dst/$(dirname $1)"
      ln -sf "$_src/$1" "$_dst/$1"
      echo "$_src/$1 -> $_dst/$1"
      shift
    done
  else
    ln -sf "$_src" "$_dst"
    echo "$_src -> $_dst"
  fi
}

for fd in $(find $_root/user -maxdepth 1 -mindepth 1); do
  case $(basename $fd) in
  .gnupg) dotlink_all $fd ~/.gnupg ;;
  .config) dotlink_all $fd ~/.config ;;
  .gitconfig) [[ -f ~/.gitconfig ]] || cp $_root/user/.gitconfig ~/.gitconfig ;;
  .app) ;; # we will handle this separately
  *) safelink $fd ;;
  esac
done

# application backup restore
applink "Übersicht"
applink "MTMR" items.json
applink "Code/User" snippets settings.json
applink "Alfred 3" Alfred.alfredpreferences

# fix permissions
find ~/.ssh -type f -exec chmod 600 {} \;
find ~/.gnupg -type f -exec chmod 600 {} \;
find ~/.ssh -type d -exec chmod 700 {} \;
find ~/.gnupg -type d -exec chmod 700 {} \;
