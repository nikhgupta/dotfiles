#!/usr/bin/env bash

source ~/.zsh/utils.sh
_scripts=$(realpath $(dirname $0))
is_archlinux || error "v4 of these dotfiles are targetted at Archlinux. Please, use earlier versions on this system."

bash $_scripts/symlinks.sh
sudo bash $_scripts/sysadmin.sh
bash $_scripts/secrets.sh
bash $_scripts/asdf.sh

highlight "Installing VIM plugins"
vim +PlugInstall +qall

highlight "Installing AntiBody for ZSH"
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin
antibody bundle <~/.zsh/plugs.txt >~/.zshplugs

highlight "Remaining tasks.."
bash $_scripts/mounts.sh
action "You should follow this link to speed up Boot: https://wiki.archlinux.org/index.php/Silent_boot"
