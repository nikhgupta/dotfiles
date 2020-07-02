#!/usr/bin/env bash

_scripts=$(realpath $(dirname $0))
_root=$(dirname $_scripts)
source ~/.zsh/utils.sh
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

highlight "Restoring mackup backups"
. $HOME/.asdf/asdf.sh # source asdf
gpip3 install mackup
asdf reshim python 3.8.3
mackup restore

highlight "Restoring VSCode extensions"
for ext in $(cat $_root/mackup/.config/Code/User/extensions.txt); do
    code --install-extension $ext
done

highlight "Remaining tasks.."
bash $_scripts/mounts.sh
action "You should follow this link to speed up Boot: https://wiki.archlinux.org/index.php/Silent_boot"
action "You should install a rice with: $_root/rices/<name>/install.sh"
