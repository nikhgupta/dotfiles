#!/usr/bin/env zsh

source ~/.zsh/utils.sh

# dont wait for long timeouts when switching vi modes
export KEYTIMEOUT=1
export EDITOR=vim
export GPG_TTY=$(tty)
unset DISPLAY

# setup data home for WSL
export WIN_HOME=$HOME
is_wsl && export WIN_HOME=/mnt/c/Users/nikhg

# change path and source credentials
path_prepend ~/.bin
source_secret ~/.dotfiles/.encrypted/zshenv.asc
