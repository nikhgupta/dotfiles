#!/usr/bin/env zsh

source ~/.zsh/utils.sh

# dont wait for long timeouts when switching vi modes
export KEYTIMEOUT=1
export EDITOR=vim
export GPG_TTY=$(tty)

# setup data home for WSL
export WIN_HOME=$HOME
if is_wsl; then
  export WIN_HOME=/mnt/c/Users/nikhg
  export PULSE_SERVER=tcp:$(grep nameserver /etc/resolv.conf | awk '{print $2}')
fi

# change path and source credentials
path_prepend ~/.bin
source_secret ~/.dotfiles/.encrypted/zshenv.asc
