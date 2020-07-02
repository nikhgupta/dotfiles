#!/usr/bin/env zsh

source ~/.zsh/utils.sh

# dont wait for long timeouts when switching vi modes
export KEYTIMEOUT=1
export EDITOR=vim
export GPG_TTY=$(tty)

# variables used through out dotfiles
export DOTCASTLE=~/.dotfiles
export CURRENT_RICE=$(cat $HOME/.cache/rice.lock)
source $DOTCASTLE/rices/$CURRENT_RICE/aliases.sh
path_prepend ~/.bin/$CURRENT_RICE/

# setup data home for WSL
export WIN_HOME=$HOME
if is_wsl; then
  export WIN_HOME=/mnt/c/Users/nikhgupta
  export PULSE_SERVER=tcp:$(grep nameserver /etc/resolv.conf | awk '{print $2}')
fi

# change path and source credentials
path_prepend ~/.bin
source_secret $DOTCASTLE/.encrypted/zshenv.asc
