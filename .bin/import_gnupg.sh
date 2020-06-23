#!/usr/bin/env bash

_dir=$HOME/OneDrive/Backup/workstation/gpg

gpg --import $_dir/secret.key
gpg --import-ownertrust $_dir/trustdb.txt
gpg --refresh-keys

echo
echo "=> You should now add keygrip of your SSH KEY to ~/.gnupg/sshcontrol"
echo

gpg --list-keys --with-keygrip --fingerprint --keyid-format long $GPGKEY

echo
echo '=> Afterwards, you can verify your key is present via: `ssh-add -L`'
