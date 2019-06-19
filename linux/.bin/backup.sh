#!/bin/bash
#
# Script to backup entire Ubuntu system using rsync.
#
# Developed by Nikhil Gupta <me@nikhgupta.com>
#
# Created: 02-06-19 06:23:12
# Updated: 19-06-19 01:45:16
#
#

DESTIN="/media/Backups"
BACKUP="$(which rdiff-backup)"
DESTIN_RSYNC="$DESTIN/$(/home/nikhgupta/.bin/os.sh)/"

if ! grep "$DESTIN " /proc/mounts &> /dev/null; then
  echo "$DESTIN is not mounted. Skipping..."
  exit 127
fi

# autoremove unused installs
rm -rf /home/*/.cache/pip
rm -rf /home/*/.cache/thumbnails
rm -rf /home/*/.cache/google-chrome/Default/Cache
rm -rf /home/*/.cache/google-chrome/Default/Code\ Cache

# keep journalctl logs sane
sudo /home/nikhgupta/.bin/clearlogs.sh

# backup
$BACKUP \
  --exclude-globbing-filelist /home/nikhgupta/.rsyncignore \
  --exclude-other-filesystems \
  --print-statistics -v5 \
  / ${DESTIN_RSYNC}/

echo "System Backup done at: $(date)" >> /var/log/backup.log
echo "-------------------------------------------------------" >> /var/log/backup.log
