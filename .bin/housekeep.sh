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

# show help
[[ "$1" == "-h" ]] || [[ "$1" == "--help" ]] && list-commands $0 && exit 1
backup=$HOME/OneDrive/Backup/workstation/

_os=$(~/.bin/os.sh)
if [[ $_os == "wsl/ubuntu" ]]; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove
elif [[ $_os == "mac" ]]; then
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

if [[ $_os == "mac" ]]; then
  sudo rm -rfv ~/.Trash
  sudo rm -rfv /Volumes/*/.Trashes
  sudo rm -rfv /private/var/log/asl/*.asl
  sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
fi

mkdir -p $backup/{ssh,gpg}
cp -r ~/.ssh/{config,knownhosts} $backup/ssh/
gpg --export-ownertrust >$backup/gpg/trustdb.txt
gpg --refresh-keys
tput bel
