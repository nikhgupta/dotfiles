#!/usr/bin/env sh

[[ -n "$UTILS_SOURCED" ]] && return
UTILS_SOURCED=1

os_release() { lsb_release -i | cut -d: -f2 | tr '[:upper:]' '[:lower:]' | sed -e 's/[[:space:]]*//'; }

is_macosx() { [[ "$OSTYPE" = darwin* ]]; }
is_ubuntu() { [[ "$(uname -a)" = *Ubuntu* ]]; }
is_debian() { [[ -f "/etc/debian" ]]; }
is_wsl() { [[ "$(uname -a)" = *microsoft* ]]; }
is_wsl_ubuntu() { is_wsl && os_release == "ubuntu" >/dev/null; }
is_svn() { [[ -d '.svn' ]]; }
is_hg() { [[ -d '.hg' ]] || command hg root &>/dev/null; }
is_git() { [[ -d '.git' ]] || \ command git rev-parse --git-dir &>/dev/null || \ command git symbolic-ref HEAD &>/dev/null; }
is_emacs() { echo $TERMINFO | grep -o emacs >/dev/null; }
is_vscode() { [[ "$TERM_PROGRAM" == "vscode" ]]; }

warn() { echo "\e[4;33mWarning\e[0m: $@"; }
error() {
  echo -ne "\e[4;31mError\e[0m: \e[31m$@\e[0m\n"
  exit 1
}
action() { echo "\e[0;35mACTION\e[0m: $@"; }
highlight() { echo -ne "\n👉  \e[0;34m$@\e[0m\n"; }

init_cache() {
  file_name=$HOME/.init-cache/$1
  if [[ -f $file_name ]]; then
    . $file_name
  else
    mkdir -p $HOME/.init-cache
    eval "$(echo $2)" >$file_name
    . $file_name
  fi
}

path_append() { [[ -d "$1" ]] && export PATH="$PATH:$1"; }
path_prepend() { [[ -d "$1" ]] && export PATH="$1:$PATH"; }
is_installed() { type $1 &>/dev/null; }

source_if_exists() { [[ -s "$1" ]] && source "$1"; }

modify_secret_config() {
  vim $1
  rm -f $HOME/.decrypted/${1:t:r}.decrypted-cache
}
source_secret() {
  destin=$HOME/.decrypted/${1:t:r}.decrypted-cache
  if [[ -s $destin ]]; then
    source $destin
  elif [[ -f $1 ]]; then
    mkdir -p $HOME/.decrypted
    gpg --decrypt $1 2>/dev/null >$destin
    chmod +x $destin
    source $destin
  else
    echo "No such secret file found: $1"
  fi
}
