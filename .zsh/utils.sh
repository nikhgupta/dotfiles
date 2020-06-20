#!/usr/bin/env sh

[[ -n "$UTILS_SOURCED" ]] && return
UTILS_SOURCED=1

is_macosx()    { [[ "$OSTYPE" = darwin* ]]; }
is_ubuntu()    { [[ "$(uname -a)" = *Ubuntu* ]]; }
is_wsl()       { [[ "$(uname -a)" = *microsoft* ]]; }
is_debian()    { [[ -f "/etc/debian" ]]; }
is_svn()       { [[ -d '.svn' ]]; }
is_hg()        { [[ -d '.hg'  ]] || command hg root &>/dev/null; }
is_git()       { [[ -d '.git' ]] || \ command git rev-parse --git-dir &>/dev/null || \ command git symbolic-ref HEAD &>/dev/null; }
is_emacs()     { echo $TERMINFO | grep -o emacs >/dev/null; }
is_vscode()    { [[ "$TERM_PROGRAM" == "vscode" ]]; }

path_append()      { [[ -d "$1" ]] && export PATH="$PATH:$1"; }
path_prepend()     { [[ -d "$1" ]] && export PATH="$1:$PATH"; }
is_installed()     { type $1 >/dev/null; }
source_if_exists() { [[ -s "$1" ]] && source "$1"; }
source_secret()    { source_if_exists "$1"; }

warn()     { echo "\e[4;33mWarning\e[0m: $@"; }
error()    { echo "\e[4;31mError\e[0m: $@"; exit 1; }
action()   { echo "\e[0;35mACTION\e[0m: $@"; }
highlight(){ echo -ne "\n👉  \e[0;34m$@\e[0m\n"; }

init_cache(){
  file_name=$HOME/.init-cache/$1
  if [[ -f $file_name ]]; then
    . $file_name
  else
    mkdir -p $HOME/.init-cache
    eval "$(echo $2)" > $file_name
    . $file_name
  fi
}