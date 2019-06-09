#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export EDITOR=vim
export BROWSER=google-chrome
export TERMINAL=alacritty
source ~/.zshenv

# disable touchpad when typing
syndaemon -K -i 0.5 -R -d

[ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services" ] && mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services"
ln -sfT "/usr/share/dbus-1/services/org.knopwob.dunst.service" "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"

session=${1:-bspwm}

case $session in
  bspwm)
    exec bspwm;
    ;;
  *)
    exec $1;
    ;;
esac
