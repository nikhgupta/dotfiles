#!/usr/bin/env bash

_name=$(basename $(dirname $0))
_root=$(dirname $(dirname $0))

source ~/.zsh/utils.sh
_lock=~/.cache/rice.lock
touch $_lock
_current=$(cat $_lock)

if [[ -n "$_current" ]] && [[ $_current != "$_name" ]]; then
  error "Please, run '$_root/$_current/uninstall.sh' to uninstall currently installed rice, first."
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

mkdir -p ~/.bin/$_name
dotlink_all $_root/.bin ~/.bin/$_name
dotlink_all $_root/.config ~/.config
safelink.rb -v $_root/.Xdefaults
safelink.rb -v $_root/.Xresources.d

echo $_name >$_lock
exit 0
