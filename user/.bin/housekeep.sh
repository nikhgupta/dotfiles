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

_user=nikhgupta
_home=/home/$_user
_home=$(su - $_user -c "echo \$HOME")
_dotcastle=$(su - $_user -c "echo \$DOTCASTLE")
_backup=$_home/OneDrive/Backup/workstation/

echo -ne "\n\n\n=> Running housekeeping at $(date)"
source $_home/.zsh/utils.sh

(($UID)) && error "You must run $0 with sudo priviledges."

as_user() { su - $_user -c "source ~/.zshrc > /dev/null; $@"; }

highlight "Upgrading system packages using package manager.."
if is_ubuntu || is_wsl_ubuntu; then
  apt update
  apt upgrade -y
  apt autoremove
elif is_macosx; then
  softwareupdate -i -a
  as_user "brew update"
  as_user "brew upgrade"
  as_user "brew cleanup"
fi

highlight "Upgrading NPM for user: $_user .."
as_user "npm install npm -g"
as_user "npm update -g"

highlight "Upgrading system ruby gems.."
gem update --system
gem update
gem cleanup

if is_macosx; then
  highlight "Emptying trash and space consuming files on MacOSX.."
  rm -rfv $_home/.Trash
  rm -rfv /Volumes/*/.Trashes
  rm -rfv /private/var/log/asl/*.asl
  sqlite3 $_home/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
fi

# gpg, ssh related
highlight "Backing up SSH and GPG configuration.."
mkdir -p $_backup/{ssh,gpg}
cp -r $_home/.ssh/{config,known_hosts} $_backup/ssh/
as_user "gpg --export-ownertrust >$_backup/gpg/trustdb.txt"
as_user "gpg --refresh-keys"

# backup various app configs and vscode extensions list
as_user "mackup backup"
as_user "code --list-extensions" >$_dotcastle/.mackup/.config/Code/User/extensions.txt

highlight "Clearing journalctl logs on Ubuntu.."
$_home/.bin/clearlogs.sh

if [[ -f $_home/.cache/rice.lock ]]; then
  _path=$_home/.bin/$(cat $_home/.cache/rice.lock)/launcher.sh
  [[ -f $_path ]] && as_user "$_path cache"
fi

# tput bel
highlight "Finished."
exit 0
