#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -U $UID -x polybar >/dev/null; do sleep 1; done

# kill all processes matching the current rice
ps -eo pid,command \
  | grep ~/.bin/$CURRENT_RICE \
  | grep "sh " \
  | grep -v grep \
  | awk '{print $1}' \
  | xargs -I {} kill -9 {}

polybar -q top &
polybar -q bottom &
