#!/usr/bin/env bash

source ~/.zsh/utils.sh
_root=$(dirname $(dirname $(realpath $0)))

action "Modify the following entries and add them to /etc/fstab"
cat <<ENTRIES
  # HDD
  PARTLABEL="Data"       /media/nikhgupta/Data        ext4      defaults                        0       0
  PARTLABEL="Gallery"    /media/nikhgupta/Gallery     ntfs-3g   defaults,uid=1000,gid=998,rw    0       0
  PARTLABEL="JukeBox"    /media/nikhgupta/JukeBox     ntfs-3g   defaults,uid=1000,gid=998,rw    0       0
  
  # # External HDD
  # PARTLABEL="ExData"     /media/nikhgupta/ExData     ntfs-3g   noauto,defaults,uid=1000,gid=998,rw,nofail,x-systemd.device-timeout=1ms    0       0
  # PARTLABEL="ExGallery"  /media/nikhgupta/ExGallery  ntfs-3g   noauto,defaults,uid=1000,gid=998,rw,nofail,x-systemd.device-timeout=1ms    0       0
  # PARTLABEL="ExMovies"   /media/nikhgupta/ExMovies   ntfs-3g   noauto,defaults,uid=1000,gid=998,rw,nofail,x-systemd.device-timeout=1ms    0       0
  # PARTLABEL="ExJukeBox"  /media/nikhgupta/ExJukeBox  ntfs-3g   noauto,defaults,uid=1000,gid=998,rw,nofail,x-systemd.device-timeout=1ms    0       0
ENTRIES
echo

action "You should now create appropriate directory structure, and add permissions."
echo "  sudo mkdir -p /media/nikhgupta/{Data,Gallery,JukeBox}"
echo "  sudo chown -R $(whoami):wheel /media/nikhgupta/Data"
echo

action "You can auto mount with:"
echo "  sudo mount -a"
echo

action "Setup OneDrive for backups and sync"
echo "  mkdir -p /media/nikhgupta/Data/OneDrive"
echo "  onedrivesync onedrive:Backup /media/nikhgupta/Data/OneDrive/Backup"
echo

action "Setup links to various XDG directories"
cat <<ENTRIES
  safelink.rb -v /media/nikhgupta/JukeBox/Movies
  safelink.rb -v /media/nikhgupta/JukeBox/Music
  safelink.rb -v /media/nikhgupta/JukeBox/Videos
  safelink.rb -v /media/nikhgupta/JukeBox/Documents
  safelink.rb -v /media/nikhgupta/JukeBox/Downloads
  safelink.rb -v /media/nikhgupta/Data/Backups
  safelink.rb -v /media/nikhgupta/Data/OneDrive
  safelink.rb -v /media/nikhgupta/Gallery ~/Pictures
ENTRIES
echo

action "Check if XDG directories are propertly setup"
echo "  check_xdg_dirs"
echo

action "You should follow this link to speed up Boot: https://wiki.archlinux.org/index.php/Silent_boot"
action "You should install a rice with: $_root/rices/<name>/install.sh"
