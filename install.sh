#!/usr/bin/env bash

_root=$(dirname $0)
_scripts=$_root/scripts
source $_root/user/.zsh/utils.sh
is_macosx || error "v5 of these dotfiles target Mac OSX. Please, use earlier versions on this system."

# bash $_scripts/brew.sh
# bash $_scripts/symlinks.sh
bash $_scripts/secrets.sh
# bash $_scripts/asdf.sh
# bash $_scripts/macos.sh

highlight "Installing VIM plugins"
vim +PlugInstall +qall

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
bash $_scripts/remaining.sh
