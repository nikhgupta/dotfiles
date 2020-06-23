#!/usr/bin/env bash
#
# ---------------------------------------------------------------------
#
#   Summary:     Upgrade all available installed packages in MacOS
#   Author:      Nikhil Gupta
#   Description: Get macOS Software Updates, and update installed Rubygems,
#                Homebrew, npm, and their installed packages.
#   Usage:       upgrade
#
# ---------------------------------------------------------------------

_home=/home/nikhgupta
_backup=$_home/OneDrive/Backup/workstation/

source $_home/.zsh/utils.sh

if is_ubuntu || is_wsl_ubuntu; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove
elif is_macosx; then
  sudo softwareupdate -i -a
  brew update
  brew upgrade
  brew cleanup
fi

npm install npm -g
npm update -g
sudo gem update --system
sudo gem update
sudo gem cleanup

if is_macosx; then
  sudo rm -rfv $_home/.Trash
  sudo rm -rfv /Volumes/*/.Trashes
  sudo rm -rfv /private/var/log/asl/*.asl
  sqlite3 $_home/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
fi

# gpg, ssh related
mkdir -p $_backup/{ssh,gpg}
cp -r $_home/.ssh/{config,knownhosts} $_backup/ssh/
gpg --export-ownertrust >$_backup/gpg/trustdb.txt
gpg --refresh-keys

if is_wsl; then
  # backup windows terminal settings
  cp $DATA_HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json \
    $_home/.dotfiles/.config/windows-terminal/settings.json
fi

# elevated priviledges
if is_ubuntu; then
  sudo $_home/.bin/clearlogs.sh
fi

tput bel
