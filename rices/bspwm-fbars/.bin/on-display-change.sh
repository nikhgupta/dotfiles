#!/usr/bin/env bash

if xrandr -q | grep 'HDMI-1-0 connected'; then
  export MONITOR=$MONITOR1

  xrandr --output $MONITOR0 --mode 1920x1080
  xrandr --output $MONITOR1 --mode 2560x1440 --right-of eDP-1 --primary

  bspc monitor $MONITOR0 -d music files chat mail settings automation 0
  bspc monitor $MONITOR1 -d web term code

  bspc wm -O $MONITOR1 $MONITOR0
else
  export MONITOR1=
  export MONITOR=$MONITOR0

  xrandr --output $MONITOR0 --primary --mode 1920x1080
  bspc monitor -d web term code music files chat mail settings automation 0
fi
