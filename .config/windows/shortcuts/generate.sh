#!/usr/bin/env bash

source ~/.zsh/utils.sh

if ! is_wsl; then
  error "Not generating shortcuts meant for Windows on a non-WSL OS."
fi

_dir=$(dirname $0)
wsltty_config=$(wslpath -w $HOME/.config/wsltty)

# generate icon for vim using mintty - simulates graphical vim
win_shortcut.sh $_dir/vim $_dir/icons/vim.ico $WIN_HOME/AppData/Local/wsltty/bin/mintty.exe --WSL= --configdir=$wsltty_config -w full -t NeoVim nvim

# generate icon for tmux using mintty
win_shortcut.sh $_dir/tmux $_dir/icons/tmux.ico $WIN_HOME/AppData/Local/wsltty/bin/mintty.exe -o Padding=1 --WSL= --configdir=$wsltty_config -w full -t TMux tmux

# music player for the Windows
win_shortcut.sh $_dir/play $_dir/icons/play.ico $WIN_HOME/AppData/Local/wsltty/bin/mintty.exe -o Padding=1 --WSL= --configdir=$wsltty_config -w full -t MusicPlayer ncmpcpp

cp $_dir/*.lnk $WIN_HOME/Desktop
