#!/usr/bin/env sh

[[ -n "$UTILS_SOURCED" ]] && return
UTILS_SOURCED=1

# Check OS for various features
os_release() { lsb_release -i | cut -d: -f2 | tr '[:upper:]' '[:lower:]' | sed -e 's/[[:space:]]*//'; }
is_macosx() { [[ "$OSTYPE" = darwin* ]]; }
is_ubuntu() { [[ "$(uname -a)" = *Ubuntu* ]]; }
is_debian() { [[ -f "/etc/debian" ]]; }
is_archlinux() { [[ -f /etc/arch-release ]]; }
is_wsl() { [[ "$(uname -a)" = *microsoft* ]]; }
is_wsl_ubuntu() { is_wsl && os_release == "ubuntu" >/dev/null; }
is_svn() { [[ -d '.svn' ]]; }
is_hg() { [[ -d '.hg' ]] || command hg root &>/dev/null; }
is_git() { [[ -d '.git' ]] || \ command git rev-parse --git-dir &>/dev/null || \ command git symbolic-ref HEAD &>/dev/null; }
is_emacs() { echo $TERMINFO | grep -o emacs >/dev/null; }
is_vscode() { [[ "$TERM_PROGRAM" == "vscode" ]]; }
has_yum() { is_installed yum; }
has_pac() { is_installed pacman; }
has_apt() { is_installed apt-get; }
is_installed() { type $1 &>/dev/null; }

# Use consistent debug logs in scripts that we create
ok() { echo -ne "\e[32m✓\e[0m $@\n"; }
warn() { echo -ne "\e[4;33mWarning: $@\e[m\n\n"; }
info() { echo -ne "\e[4;32mInfo: $@\e[0m\n"; }
action() { echo -ne "\e[0;35mACTION: $@\e[0m\n"; }
highlight() { echo -ne "👉 \e[0;34m$@\e[0m\n\n"; }
error() {
  echo -ne "\e[4;31mError\e[0m: \e[31m$@\e[0m\n"
  exit 1
}

# useful snippets for zsh related config
path_append() { [[ -d "$1" ]] && export PATH="$PATH:$1"; }
path_prepend() { [[ -d "$1" ]] && export PATH="$1:$PATH"; }
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

# on archlinux, use the following to install packages in scripts
# NOTE: not meant for general usage.
pac_install() { sudo pacman -S --needed --noconfirm $@; }
yay_install() {
  if is_installed yay; then
    for package in $@; do
      yay -aS --nocleanmenu --noeditmenu --nodiffmenu $package
    done
  else
    action "Install AUR packages: $@"
  fi
}
