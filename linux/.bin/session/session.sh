#!/usr/bin/env zsh
# Things to do when session starts.
# Only useful for deepin DE. For others, should be configured
# in ~/.xinitrc

# add primary ssh key to agent
eval $(ssh-agent)
ssh-add ~/.ssh/nikhgupta

if [[ "$XDG_SESSION_DESKTOP" == "deepin" ]]; then
  killall -9 sxhkd compton dunst redshift syndaemon polybar
  feh --bg-fill $XDG_WALLPAPER_DIR/_default.jpg
  xrdb -merge ~/.Xdefaults

  # set backlight to 25%
  light -S 25

  mpd
  while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
  polybar -q deepin &
fi

