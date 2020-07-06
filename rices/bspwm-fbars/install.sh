#!/usr/bin/env bash

_rice=$(dirname $(realpath $0))
_name=$(basename $_rice)
_root=$(dirname $(dirname $_rice))

source ~/.zsh/utils.sh
_lock=~/.cache/rice.lock
touch $_lock
_current=$(cat $_lock)

if [[ -n "$_current" ]] && [[ $_current != "$_name" ]]; then
  error "Please, run '$_root/rices/$_current/uninstall.sh' to uninstall currently installed rice, first."
fi

dotlink_all() {
  for fd in $(find $1/ -maxdepth 1 -mindepth 1); do
    safelink.rb -v $fd $2/$(basename $fd)
  done
}

pac_install bspwm sxhkd redshift polybar \
  ttf-font-awesome noto-fonts powerline-fonts i3lock-color \
  network-manager-applet xdotool extra/xorg-xev xautolock xss-lock

yay_install rofi-git dunst-git picom-ibhagwan-git light-git \
  ttf-font-awesome-4 ttf-material-design-icons

dotlink_all $_rice/.bin ~/.bin
dotlink_all $_rice/.config ~/.config
safelink.rb -v $_rice/.Xdefaults
safelink.rb -v $_rice/.Xresources.d

echo $_name >$_lock
exit 0
