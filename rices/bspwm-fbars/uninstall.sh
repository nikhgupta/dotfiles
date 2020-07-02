#!/usr/bin/env bash

_name=$(basename $(dirname $0))
_root=$(dirname $(dirname $0))

source ~/.zsh/utils.sh
_lock=~/.cache/rice.lock
_current=$(cat $_lock)
remove() { [[ -L $1 ]] && rm -f $1; }

if [[ -z "$_current" ]]; then
  error "You do not have a rice installed."
fi

if [[ $_current != "$_name" ]]; then
  error "Please, run: '$_root/$_current/uninstall.sh' to uninstall currently installed rice."
fi

if [[ "${XDG_SESSION_DESKTOP}" == "bspwm" ]]; then
  error "Will not uninstall bspwm from within bspwm session."
fi

sudo pacman -R bspwm sxhkd redshift light polybar rofi \
  ttf-font-awesome ttf-icomoon-icons i3lock-color \
  network-manager-applet xautolock xss-lock

yay -R rofi-git dunst-git picom-ibhagwan-git light-git \
  ttf-font-awesome-4 ttf-material-design-icons

rm -rf ~/.bin/$_name
remove ~/.Xdefaults
remove ~/.Xresources.d
remove ~/.config/bspwm
remove ~/.config/dunst
remove ~/.config/polybar
remove ~/.config/rofi
remove ~/.config/sxhkd
remove ~/.config/picom.conf

rm $_lock
exit 0
