#!/usr/bin/env bash

case "$1" in
highlight_mode_default)
  yabai -m config window_border_width 1
  yabai -m config active_window_border_color 0x00444444
  yabai -m config normal_window_border_color 0x00444444
  ;;
highlight_mode_active) # white
  yabai -m config window_border_width 128
  yabai -m config active_window_border_color 0xb2000000
  yabai -m config normal_window_border_color 0xb2000000
  ;;
highlight_mode_focus) # green
  yabai -m config window_border_width 128
  yabai -m config normal_window_border_color 0xb266cc66
  yabai -m config active_window_border_color 0xb299ff99
  ;;
highlight_mode_grid) # orange
  yabai -m config window_border_width 128
  yabai -m config normal_window_border_color 0xb2cc9966
  yabai -m config active_window_border_color 0xb2ffcc99
  ;;
highlight_mode_swap) # red
  yabai -m config window_border_width 128
  yabai -m config normal_window_border_color 0xb2cc6666
  yabai -m config active_window_border_color 0xb2ff9999
  ;;
highlight_mode_move) # yellow
  yabai -m config window_border_width 128
  yabai -m config normal_window_border_color 0xb2cccc66
  yabai -m config active_window_border_color 0xb2ffff99
  ;;
highlight_mode_resize) # cyan
  yabai -m config window_border_width 128
  yabai -m config normal_window_border_color 0xb266cccc
  yabai -m config active_window_border_color 0xb299ffff
  ;;
highlight_mode_toggle) # purple
  yabai -m config window_border_width 128
  yabai -m config normal_window_border_color 0xb2cc66cc
  yabai -m config active_window_border_color 0xb2ff99ff
  ;;
highlight_mode_launch) # blue
  yabai -m config window_border_width 128
  yabai -m config normal_window_border_color 0xb26666cc
  yabai -m config active_window_border_color 0xb29999ff
  ;;
highlight_mode_window)
  yabai -m config window_border_width 192
  yabai -m config normal_window_border_color 0xb2444444
  ;;
highlight_mode_space)
  yabai -m config window_border_width 320
  ;;
highlight_mode_display)
  yabai -m config window_border_width 2048
  ;;
esac
