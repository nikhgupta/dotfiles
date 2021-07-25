#!/usr/bin/env zsh

source ~/.zsh/utils.sh

# dont wait for long timeouts when switching vi modes
export KEYTIMEOUT=1
export EDITOR=vim
export GPG_TTY=$(tty)
export ZSH_CACHE_DIR=~/.zcache

export MONITOR0="eDP-1"
export MONITOR1="HDMI-1-0"

# terminal related variables
export TERMINAL=kitty
export TERMINAL_CLASS=kitty
alias named_terminal="$TERMINAL --name"

# variables used through out dotfiles
export DOTCASTLE=~/.dotfiles
export CURRENT_RICE=$(cat $HOME/.cache/rice.lock)

# setup data home for WSL
export WIN_HOME=$HOME
if is_wsl; then
  export WIN_HOME=/mnt/c/Users/nikhgupta
  export PULSE_SERVER=tcp:$(grep nameserver /etc/resolv.conf | awk '{print $2}')
fi

# add custom scripts from dotcastle and rice to $PATH
path_prepend ~/.bin
path_prepend ~/.bin/rofi
path_prepend ~/.bin/polybar

# source secret credentials
source_secret $DOTCASTLE/user/.encrypted/zshenv.asc
