#!/bin/bash
#
# ---
# summary: backup system using rsync to external drive
# author: Nikhil Gupta
# usage: $0 [backup_directory]
#

source /home/nikhgupta/.zsh/utils.sh

if ! is_macosx && ! is_ubuntu && ! is_wsl_ubuntu; then
  error "You must be on MacOSX, Ubuntu or WSL/Ubuntu for $0 to work."
fi

if ! is_installed rdiff-backup; then
  error "You must install rdiff-backup for $0 to work."
fi

DESTIN="${1:-$XDG_BACKUP_DIR}"
BACKUP="$(which rdiff-backup)"
BIN_DIR=/home/nikhgupta/.bin
DESTIN_RSYNC="$DESTIN/$($BIN_DIR/os.sh)/"

if [[ -z $DESTIN ]] || [[ ! -d $DESTIN ]]; then
  error "$DESTIN is not a directory. Skipping..."
fi

# autoremove unused installs
rm -rf /home/*/.cache/pip
rm -rf /home/*/.cache/thumbnails
rm -rf /home/*/.cache/google-chrome/Default/Cache
rm -rf /home/*/.cache/google-chrome/Default/Code\ Cache

# keep journalctl logs sane
sudo $BIN_DIR/clearlogs.sh

# backup
mkdir -p ${DESTIN_RSYNC}
sudo $BACKUP \
    --exclude-globbing-filelist /home/nikhgupta/.rsyncignore \
    --exclude-other-filesystems \
    --print-statistics -v5 \
    / ${DESTIN_RSYNC}/

echo "System Backup done at: $(date)" >> /tmp/backup.log
echo "-------------------------------------------------------" >> /tmp/backup.log
