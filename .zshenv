#!/usr/bin/env zsh

source ~/.zsh/utils.sh

# dont wait for long timeouts when switching vi modes
export KEYTIMEOUT=1
export EDITOR=vim

# setup data home for WSL
export DATA_HOME=$HOME
is_wsl && export DATA_HOME=/mnt/c/Users/nikhg

# change path and source credentials
path_prepend ~/.bin
source_secret ~/.zshenv.local
