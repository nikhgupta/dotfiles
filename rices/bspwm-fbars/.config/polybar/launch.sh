#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -U $UID -x polybar >/dev/null; do sleep 1; done

# kill all processes matching the current rice
kill_matching_bin() {
  ps -eo pid,command |
    grep ~/.bin/$@ |
    grep -v grep |
    awk '{print $1}' |
    xargs -I {} kill -9 {}
}

kill_matching_bin microphone.sh
kill_matching_bin polybar/window.sh
kill_matching_bin screencast.sh

polybar -q top &
polybar -q bottom &

if [[ -n "$MONITOR1" ]]; then
  polybar -q top_external &
  polybar -q bottom_external &
fi
