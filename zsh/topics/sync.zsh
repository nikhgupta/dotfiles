# utility: rclone and onedrive
# sync pictures and videos with onedrive storage
onedrivesync() {
  orig=$1
  shift
  dest=$1
  shift
  rclone sync $orig $dest -P --delete-excluded --fast-list --log-level=INFO --no-check-certificate --no-update-modtime $@
}
alias onedrivesync_photos="onedrivesync /Volumes/PICTURES onedrive:Photography"
