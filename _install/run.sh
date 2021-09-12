#!/usr/bin/env bash

_root=$(dirname $(dirname $0))
source $_root/zsh/utils.sh

# ensure that we are using the correct version of dotfiles
is_archlinux && error "Please checkout last supported version for Archlinux - v4.0"
is_wsl && error "Please checkout last supported version for WSL systems - v3.0"
is_debian && error "Please checkout last supported version for Ubuntu/Debian systems - v2.0"
is_macosx || error "v5 of these dotfiles target Mac OSX. Please, use earlier versions on this system."

bash $_root/_install/brew.sh
bash $_root/_install/symlinks.sh
bash $_root/_install/secrets.sh
bash $_root/_install/asdf.sh
bash $_root/_install/macos.sh

highlight "Installing VIM plugins"
\vim +PlugInstall +qall
nvim +PlugInstall +UpdateRemotePlugins +qall

highlight "Installing AntiBody for ZSH"
brew install antibody
antibody bundle <~/.zsh/plugs.txt >~/.zshplugs

# highlight "Restoring mackup backups"
# mackup restore -f

highlight "Create directories needed by some utilities"
mkdir -p ~/.mpd ~/.cache
touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpd.state}

# highlight "Adding housekeeping to cron daily"
# ln -s $DOTCASTLE/user/.bin/housekeep.sh /etc/cron.daily/

highlight "Remaining tasks.."
bash $_root/_install/remaining.sh
