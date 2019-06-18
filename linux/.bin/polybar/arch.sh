#!/usr/bin/env sh
# pacman-contrib needed

[ "$1" == "--check" ] && notify-send "Packages: " "$(checkupdates)" && exit
[ "$1" == "--list" ] && notify-send "Update with:" "pacman -Qu | wc -l" && exit

updates_arch=0
if [ "$(checkupdates 2> /dev/null | wc -l)" -gt 0 ];  then
    updates_arch=$(sudo checkupdates 2> /dev/null | wc -l )
fi

updates_aur=0
if [ "$(trizen -Su --aur --quiet | wc -l)" -gt 0 ]; then
  updates_aur=$(trizen -Su --aur --quiet | wc -l)
fi

echo "$(($updates_arch + $updates_aur))"
