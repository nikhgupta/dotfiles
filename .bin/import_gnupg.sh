#!/usr/bin/env bash
# summary: restore gnupg data from backup

_dir=${1:-$XDG_ONEDRIVE_BACKUP_DIR/workstation/gpg}

gpg --import $_dir/secret.key
gpg --import-ownertrust $_dir/trustdb.txt
gpg --refresh-keys

echo
echo "=> You should now add keygrip of your SSH KEY to ~/.gnupg/sshcontrol"
echo

gpg --list-keys --with-keygrip --fingerprint --keyid-format long $GPGKEY

echo
echo '=> Afterwards, you can verify your key is present via: `ssh-add -L`'
