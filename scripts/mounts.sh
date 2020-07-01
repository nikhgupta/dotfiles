#!/usr/bin/env bash

source ~/.zsh/utils.sh

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

action "You should now create appropriate directory structure, and add permissions."
echo "  sudo mkdir -p /media/nikhgupta/{Data,Gallery,JukeBox}"
echo "  sudo chown -R $(whoami):wheel /media/nikhgupta/Data"

action "You can auto mount with:"
echo "  sudo mount -a"

action "Setup OneDrive for backups and sync"
echo "  mkdir -p /media/nikhgupta/Data/OneDrive"
echo "  onedrivesync onedrive:Backup /media/nikhgupta/Data/OneDrive/Backup"

action "Setup links to various XDG directories"
cat <<ENTRIES
  linkdir /media/nikhgupta/JukeBox/Movies
  linkdir /media/nikhgupta/JukeBox/Music
  linkdir /media/nikhgupta/JukeBox/Videos
  linkdir /media/nikhgupta/JukeBox/Documents
  linkdir /media/nikhgupta/JukeBox/Downloads
  linkdir /media/nikhgupta/Data/Backups
  linkdir /media/nikhgupta/Data/OneDrive
  linkdir /media/nikhgupta/Gallery ~/Pictures
ENTRIES

action "Check if XDG directories are propertly setup"
echo "  check_xdg_dirs"
