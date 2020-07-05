#!/usr/bin/env bash

ON_AC_TIMEOUT=60
ON_BAT_TIMEOUT=30

source ~/.zsh/utils.sh
if ! is_installed i3lock; then
  error "Please, install i3lock-color to use $0"
fi

_font=Fira\ Code

lock() {
  i3lock --ignore-empty-password --blur 10 --indicator --clock \
    --pass-media-keys --pass-power-keys \
    --radius 110 \
    --color 666666 \
    --insidecolor 00000000 \
    --insidevercolor ffffff33 \
    --insidewrongcolor aa333333 \
    --separatorcolor ffffffff \
    --linecolor ffffff99 \
    --ringcolor ffffff33 \
    --ringvercolor ffffff66 \
    --ringwrongcolor aa333366 \
    --bshlcolor ff8888cc \
    --keyhlcolor ffffffcc \
    --verifcolor ffffffff \
    --wrongcolor ccccccff \
    --timecolor ffffffff \
    --datecolor ffffffff \
    --time-font $_font \
    --date-font $_font \
    --verif-font $_font \
    --wrong-font $_font \
    --veriftext "..." \
    --wrongtext "" \
    --noinputtext ""
}

revert() { xset s off -dpms; }
trap revert HUP INT TERM

bat=$(acpi -a)
if [ "$bat" = "Adapter 0: on-line" ]; then
  lock &
  while pgrep i3lock; do
    sleep $ON_AC_TIMEOUT && pgrep i3lock && xset dpms force off
  done
  revert
else
  lock &
  sleep $ON_BAT_TIMEOUT && pgrep i3lock && systemctl suspend
  revert
fi
