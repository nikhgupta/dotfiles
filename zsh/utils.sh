#!/usr/bin/env sh

[[ -n "$ZSH_UTILS_SOURCED" ]] && return
ZSH_UTILS_SOURCED=1

# export dotcastle environment var
export DOTCASTLE=$HOME/.dotfiles
export _ARCH=$(arch)

# Check OS for various features
os_release() { lsb_release -i | cut -d: -f2 | tr '[:upper:]' '[:lower:]' | sed -e 's/[[:space:]]*//'; }
is_ubuntu() { [[ "$(uname -a)" = *Ubuntu* ]]; }
is_debian() { [[ -f "/etc/debian" ]]; }
is_archlinux() { [[ -f /etc/arch-release ]]; }
is_wsl() { [[ "$(uname -a)" = *microsoft* ]]; }
is_wsl_ubuntu() { is_wsl && os_release == "ubuntu" >/dev/null; }
is_macosx() { [[ "$OSTYPE" = darwin* ]]; }
is_arm_macos() { is_macosx && [[ "$_ARCH" = arm64* ]]; }
is_intel_macos() { is_macosx && [[ "$_ARCH" == "i386" ]]; }

# check repository features
is_svn() { [[ -d '.svn' ]]; }
is_hg() { [[ -d '.hg' ]] || command hg root &>/dev/null; }
is_git() { [[ -d '.git' ]] || \ command git rev-parse --git-dir &>/dev/null || \ command git symbolic-ref HEAD &>/dev/null; }

# check editor features
is_vim() { env | grep VIM >/dev/null; }
is_emacs() { echo $TERMINFO | grep -o emacs >/dev/null; }
is_vscode() { [[ "$TERM_PROGRAM" == "vscode" ]]; }

# check package manager features
has_yum() { is_installed yum; }
has_pac() { is_installed pacman; }
has_apt() { is_installed apt-get; }
is_installed() { type $1 &>/dev/null; }

# Use consistent debug logs in scripts that we create
ok() { echo -ne "👍 \x1b[32m$@\x1b[0m\n"; }
warn() { echo -ne "🤦 \x1b[33m$@\x1b[m\n"; }
info() { echo -ne "📣 \x1b[36m$@\x1b[0m\n"; }
action() { echo -ne "🏃 \x1b[35m$@\x1b[0m\n"; }
highlight() { echo -ne "👉 \x1b[34m$@\x1b[0m\n"; }
error() { echo -ne "🔥 \x1b[31m$@\x1b[0m\n"; exit 1; }

# useful snippets for zsh related config
setenv() { export $1=$2 && [[ -z $ZSH_NAME ]] && is_macosx && [[ -z "${TMUX}" ]] && launchctl setenv $1 "$2"; }
path_append() { [[ -d "$1" ]] && setenv PATH "$PATH:$1"; }
path_prepend() { [[ -d "$1" ]] && setenv PATH "$1:$PATH"; }
source_if_exists() { [[ -s "$1" ]] && source "$1"; }
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
modify_secret_config() {
  vim $1
  rm -f $HOME/.decrypted/${1:t:r}.decrypted-cache
}
source_secret() {
  name="${1:t:r}"
  [[ -z "$name" ]] && name=$(basename ${1%.*})
  destin=$HOME/.decrypted/${name}.decrypted-cache
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
