#!/usr/bin/env bash

_root=$(realpath $(dirname $(dirname $0)))

linkup() {
  rm -f $2
  ln -sf $1 $2
  if [[ "${2#$HOME/}" == "${1#$_root/}" ]]; then
    ok "${2#$HOME/}"
  else
    ok "${2#$HOME/} -> ${1#$_root/}"
  fi
}
dotlink() {
  _destin="${2:-$HOME/$(basename $1)}"
  [[ ! -L "$_destin" ]] && mv $_destin "${_destin}.pre-dotcastle"
  linkup $1 $_destin
}

dotlink_all() {
  for fd in $(find $1/ -maxdepth 1 -mindepth 1); do
    dotlink $fd $2/$(basename $fd)
  done
}

source ~/.zsh/utils.sh
highlight "Setting up symlinks to dotfiles"

for target in \
  .bin .ipython .jupyter .git-template .tmux .zsh \
  .asdfrc .ctags .dircolors .editrc .gemrc .inputrc .murti.conf.rb .rsyncignore \
  .rtorrent.rc .tmux.conf .vimrc .zshrc .zshenv; do dotlink $_root/$target; done

dotlink_all $_root/.gnupg ~/.gnupg
dotlink_all $_root/.config ~/.config
dotlink $_root/.gitignore-global ~/.gitignore
cp $_root/.gitconfig ~/.gitconfig
