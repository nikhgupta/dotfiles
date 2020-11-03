#!/usr/bin/env bash
#
# ---------------------------------------------------------------------
#
#   Summary:     Upgrade all available installed packages in MacOS
#   Author:      Nikhil Gupta
#   Description: Get macOS Software Updates, and update installed Rubygems,
#                Homebrew, npm, and their installed packages.
#   Usage:       housekeep.sh
#
# ---------------------------------------------------------------------

_user=nikhgupta
_backup=$XDG_BACKUP_DIR/macbookpro

echo -ne "\n\n\n=> Running housekeeping at $(date)\n"
source $HOME/.zsh/utils.sh

is_macosx || error "This housekeep.sh is intended for MacOSX."

highlight "Upgrading system packages using package manager.."
sudo softwareupdate -i -a
brew update
brew upgrade
brew cleanup

highlight "Upgrading NPM.."
npm install npm -g
npm update -g

highlight "Upgrading system ruby gems.."
gem update
gem cleanup
sudo gem update --system
sudo gem update
sudo gem cleanup

highlight "update antibody scripts"
antibody bundle <~/.zsh/plugs.txt >~/.zshplugs
antibody update

highlight "Emptying trash and space consuming files on MacOSX.."
rm -rfv $HOME/.Trash
rm -rfv /Volumes/*/.Trashes
rm -rfv /private/var/log/asl/*.asl
sqlite3 $HOME/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'

highlight "Cleanup caches"
dscacheutil -flushcache && killall -HUP mDNSResponder # Flush Directory Service cache

highlight "Clearing journalctl logs on Ubuntu.."
sudo journalctl --flush --rotate
sudo journalctl --vacuum-size=10M
sudo journalctl --verify

# Clean up LaunchServices to remove duplicates in the “Open With” menu
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder

# Recursively delete `.DS_Store` files
find $HOME -type f -name '*.DS_Store' -ls -delete

# gpg, ssh related
highlight "Backing up SSH and GPG configuration.."
mkdir -p $_backup/{ssh,gpg}
cp -r $HOME/.ssh/{config,known_hosts} $_backup/ssh/
gpg --export-ownertrust >$_backup/gpg/trustdb.txt
gpg --refresh-keys

highlight "Backing app configurations and VS Code extensions"
mackup backup
code --list-extensions >$_backup/mackup/Library/Application\ Support/Code/User/extensions.txt

# tput bel
highlight "Finished."
exit 0
