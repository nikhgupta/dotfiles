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

session=${1:-bspwm}

case $session in
  bspwm)

    export EDITOR=vim
    export BROWSER=google-chrome-stable
    export TERMINAL=kitty
    source ~/.zshenv

    # nvidia
    xrandr --setprovideroutputsource modesetting NVIDIA-0
    xrandr --auto

    # disable touchpad when typing
    syndaemon -K -i 0.5 -R -d

    # [ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services" ] && mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services"
    # ln -sfT "/usr/share/dbus-1/services/org.knopwob.dunst.service" "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"

    exec bspwm;
    ;;
  *)
    exec $1;
    ;;
esac
