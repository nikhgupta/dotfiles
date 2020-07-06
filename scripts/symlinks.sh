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
  .bin) dotlink_all $fd ~/.bin ;;
  .gnupg) dotlink_all $fd ~/.gnupg ;;
  .config) dotlink_all $fd ~/.config ;;
  .gitignore-global) safelink $fd ~/.gitignore ;;
  .gitconfig) [[ -f ~/.gitconfig ]] || cp $_root/user/.gitconfig ~/.gitconfig ;;
  *) safelink $fd ;;
  esac
done

mackup restore

# for target in \
#   .bin .ipython .jupyter .git-template .tmux .zsh \
#   .asdfrc .ctags .dircolors .editrc .gemrc .inputrc .murti.conf.rb .rsyncignore \
#   .rtorrent.rc .tmux.conf .vimrc .zshrc .zshenv \
#   .xinitrc .Xdefaults .Xresources.d; do safelink.rb -v $_root/user/$target; done

# dotlink_all $_root/user/.gnupg ~/.gnupg
# dotlink_all $_root/user/.config ~/.config
# safelink.rb -v $_root/user/.gitignore-global ~/.gitignore
