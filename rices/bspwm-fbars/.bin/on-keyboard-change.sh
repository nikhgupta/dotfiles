#!/usr/bin/env bash

mxkeys=$(xinput list | sed -n 's/.*MX Keys Keyboard.*id=\([0-9]*\).*keyboard.*/\1/p')

# reset
setxkbmap -option

if [[ -n "$mxkeys" ]]; then
  # swap left alt and super on MX keys
  setxkbmap -option altwin:swap_lalt_lwin -device $mxkeys
fi
