#!/bin/sh

if xrandr -q | grep 'HDMI-1-0 connected'; then
  export MONITOR=$MONITOR1

  xrandr --output $MONITOR0 --mode 1920x1080
  xrandr --output $MONITOR1 --mode 2560x1440 --right-of eDP-1 --primary

  bspc monitor $MONITOR0 -d music files mail chat settings misc 14
  bspc monitor $MONITOR1 -d web term code 4 5 6 7

  bspc wm -O $MONITOR1 $MONITOR0
else
  export MONITOR=$MONITOR0

  xrandr --output $MONITOR0 --primary --mode 1920x1080
  bspc monitor -d web term code music files mail chat settings misc 0
fi
