#!/usr/bin/env bash

_root=$(realpath $(dirname $(dirname $0)))

dotlink_all() {
  for fd in $(find $1/ -maxdepth 1 -mindepth 1); do
    safelink.rb -v $fd $2/$(basename $fd)
  done
}

source ~/.zsh/utils.sh
highlight "Setting up symlinks to dotfiles"

for target in \
  .bin .ipython .jupyter .git-template .tmux .zsh \
  .asdfrc .ctags .dircolors .editrc .gemrc .inputrc .murti.conf.rb .rsyncignore \
  .rtorrent.rc .tmux.conf .vimrc .zshrc .zshenv \
  .xinitrc .Xdefaults .Xresources.d; do safelink.rb -v $_root/$target; done

dotlink_all $_root/.gnupg ~/.gnupg
dotlink_all $_root/.config ~/.config
safelink.rb -v $_root/.gitignore-global ~/.gitignore
[[ -f ~/.gitconfig ]] || cp $_root/.gitconfig ~/.gitconfig
