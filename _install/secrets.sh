#!/usr/bin/env bash

_root=$(dirname $(dirname $0))
source $_root/zsh/utils.sh

highlight "Obtaining your GPG keys from OneDrive"
mkdir /tmp/gpg-backup
rclone copy onedrive:Backup/workstation/gpg /tmp/gpg-backup
$_root/bin/import_gnupg.sh /tmp/gpg-backup
rm -rf /tmp/gpg-backup

highlight "Using GPG for SSH authentications"
killall gpg-agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf &>/dev/null

highlight "Checking if I can access git@github.com with newly set GPG key"
ssh -T git@github.com 2>&1 | grep $(whoami) || error "SSH from GPG did not work!"

highlight "Checking if I can source secret files.."
source_secret $DOTCASTLE/.encrypted/zshenv.asc
source $_root/zsh/aliases.zsh 2>/dev/null

highlight "Setting up global gitconfig"
git config --global core.editor $EDITOR
git config --global user.name $NICK
git config --global user.email $EMAIL
git config --global github.user $NICK
git config --global github.token $GITHUB_TOKEN
git config --global github.password $GITHUB_TOKEN
git config --global github.oauth-token $GITHUB_TOKEN
git config --global user.signingkey $GPGKEY
git config --global commit.gpgsign true

highlight "Updating dotfiles repo origin URL"
pushd $_root
git remote set-url origin "git@github.com:nikhgupta/dotfiles.git"
popd
