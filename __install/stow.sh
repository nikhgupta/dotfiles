#!/usr/bin/env zsh

root=$HOME/Code/dotfiles
source $root/zsh/.zsh/utils.sh

stow -t $HOME -R zsh
stow -t $HOME -R misc
stow -t $HOME -R vim
stow -t $HOME -R terminal
mkdir -p $HOME/.gnupg && stow -t $HOME/.gnupg -R gpg
stow -t "$HOME/Library/Application Support/Cursor/User" -R cursor
cp $root/_copied/.gitconfig $HOME/.gitconfig
