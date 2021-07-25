#!/usr/bin/env bash

ON_AC_TIMEOUT=60
ON_BAT_TIMEOUT=60

source ~/.zsh/utils.sh
if ! is_installed i3lock || ! is_installed ffmpeg || ! is_installed xrandr; then
  error "Please, install i3lock-color, ffmpeg and extra/xorg-xrandr to use $0"
fi

_image=/tmp/i3lock.png
_text="${1:-Screen Locked}"
_font="Fira Code"
_font_path=/usr/share/fonts/TTF/FiraCode-Bold.ttf
_lock=$DOTCASTLE/rices/$CURRENT_RICE/assets/lock.png
_resolution=$(xrandr --current | grep '*' | uniq | awk '{print $1}')
_boxsize=$(expr $(echo $_resolution | cut -d 'x' -f1) / 2)
_boxblur=10
_gblur_steps=1
_gblur_sigma=10

_filter="boxblur=$_boxblur"
_filter="$_filter,gblur=sigma=${_gblur_sigma}:steps=${_gblur_steps},drawtext=fontfile=$_font_path"
_filter="$_filter:text=$_text:fontcolor='#ffffffe0':fontsize=40:x=(w-tw)/2:y=(h/PHI)+th"
_filter="$_filter:shadowcolor='#1d1f21d0':shadowx=2:shadowy=2"
_filter="$_filter:box=1:boxcolor=#1a1b22@0.4:boxborderw=$_boxsize,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2"

lock() {
  ffmpeg -f x11grab -video_size $_resolution -y -i $DISPLAY -i $_lock -filter_complex "$_filter" -vframes 1 $_image &>/dev/null
  i3lock --ignore-empty-password --blur 10 --indicator \
    --pass-media-keys --pass-power-keys \
    --radius 110 \
    --color 666666 \
    --inside-color 00000000 \
    --insidever-color ffffff33 \
    --insidewrong-color aa333333 \
    --separator-color ffffffff \
    --line-color ffffff99 \
    --ring-color ffffff33 \
    --ringver-color ffffff66 \
    --ringwrong-color aa333366 \
    --bshl-color ff8888cc \
    --keyhl-color ffffffcc \
    --verif-color ffffffff \
    --wrong-color ccccccff \
    --verif-font $_font \
    --wrong-font $_font \
    --verif-text "..." \
    --wrong-text "" \
    --noinput-text "" \
    --lock-text "" \
    --lockfailed-text "" \
    -i $_image
    rm -f $image
  }

revert() { xset s off -dpms; rm -f $_image; }
trap revert HUP INT TERM

lock &

if acpi -a | grep -q "off-line"; then
  sleep ${ON_BAT_TIMEOUT:-60}s && pgrep i3lock && echo "Suspending in ${ON_BAT_TIMEOUT}s.." && systemctl suspend
else
  while :; do
    sleep ${ON_AC_TIMEOUT:-60}s && pgrep i3lock && echo "Screen off in ${ON_AC_TIMEOUT}s.." && xset dpms force off
    pgrep i3lock || break
  done
fi

revert
