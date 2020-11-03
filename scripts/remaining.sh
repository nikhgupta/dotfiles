#!/usr/bin/env bash

_root=$(dirname $(dirname $(realpath $0)))
source $_root/user/.zsh/utils.sh

action "Enable ntfs-3g support by overriding CSF and replace mount_ntfs script"

action "Setup OneDrive and Dropbox for backups and sync"

action "Check if XDG directories are propertly setup"
echo "  check_xdg_dirs"
echo
