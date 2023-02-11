#!/usr/bin/env bash

_root=$(dirname $(dirname $0))
source $_root/zsh/utils.sh
highlight "creating symlinks.."

__safelink() { $_root/bin/safelink.rb -v $@; }
__dotlink_all() {
  mkdir -p $2
  for fd in $(find $1 -maxdepth 1 -mindepth 1); do
    __safelink "$fd" "$2/$(basename $fd)"
  done
}

applink() {
  _src="$_root/app/$1"
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

for fd in $(find $_root -maxdepth 1 -mindepth 1); do
  case $(basename $fd) in
  gnupg) __dotlink_all $fd ~/.gnupg ;;
  config) __dotlink_all $fd ~/.config ;;
  gitconfig) [[ -f ~/.gitconfig ]] || cp $_root/gitconfig ~/.gitconfig ;;
  app) ;; # we will handle this separately
  _install | README.md | tags | tags.temp | .git | .gitignore ) ;; # ignore this
  *) __safelink $fd ;;
  esac
done

# application backup restore
applink "MTMR" items.json
applink "Code/User" settings.json
rm -rf "$HOME/Library/Application Support/Code/User/snippets" && applink "Code/User" snippets
rm -rf "$HOME/Library/Application Support/Übersicht/widgets" && applink "Übersicht" widgets
rm -rf "$HOME/Library/Application Support/Alfred 3/Alfred.alfredpreferences" && applink "Alfred 3" Alfred.alfredpreferences

# fix permissions
find ~/.ssh -type f -exec chmod 600 {} \;
find ~/.gnupg -type f -exec chmod 600 {} \;
find ~/.ssh -type d -exec chmod 700 {} \;
find ~/.gnupg -type d -exec chmod 700 {} \;

# phoenix
ln -sf $_root/config/phoenix/dist/phoenix.js ~/.phoenix.js
