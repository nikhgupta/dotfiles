#!/usr/bin/env bash

if which spacebar >/dev/null; then
  case "$1" in
    highlight_default) # default
      # spacebar -m config space_icon_strip             﫯      
      spacebar -m config space_icon_color             0xff5af78e &
      spacebar -m config space_icon_color_secondary   0xff5af78e &
      spacebar -m config space_icon_color_tertiary    0xff5af78e &
      spacebar -m config display_separator_icon_color 0xffffffff &
      spacebar -m config background_color 0x88282a36 &
      spacebar -m config foreground_color 0x88eff0eb &
      ;;
    highlight_active) # white
      spacebar -m config space_icon_color             0xff282a36 &
      spacebar -m config space_icon_color_secondary   0xff282a36 &
      spacebar -m config space_icon_color_tertiary    0xff282a36 &
      spacebar -m config display_separator_icon_color 0xff282a36 &
      spacebar -m config background_color 0xfff1f1f0             &
      spacebar -m config foreground_color 0xff282a36             &
      ;;
    highlight_focus) # green
      spacebar -m config space_icon_color             0xff282a36 &
      spacebar -m config space_icon_color_secondary   0xff282a36 &
      spacebar -m config space_icon_color_tertiary    0xff282a36 &
      spacebar -m config display_separator_icon_color 0xff282a36 &
      spacebar -m config background_color 0xff5af78e             &
      spacebar -m config foreground_color 0xff282a36             &
      ;;
    highlight_grid) # orange/magenta
      spacebar -m config space_icon_color             0xff282a36 &
      spacebar -m config space_icon_color_secondary   0xff282a36 &
      spacebar -m config space_icon_color_tertiary    0xff282a36 &
      spacebar -m config display_separator_icon_color 0xff282a36 &
      spacebar -m config background_color 0xffff6ac1             &
      spacebar -m config foreground_color 0xff282a36             &
      ;;
    highlight_swap) # red
      spacebar -m config space_icon_color             0xffeff0eb &
      spacebar -m config space_icon_color_secondary   0xffeff0eb &
      spacebar -m config space_icon_color_tertiary    0xffeff0eb &
      spacebar -m config display_separator_icon_color 0xffeff0eb &
      spacebar -m config background_color 0xffff5c57             &
      spacebar -m config foreground_color 0xffeff0eb             &
      ;;
    highlight_move) # yellow
      spacebar -m config space_icon_color             0xff282a36 &
      spacebar -m config space_icon_color_secondary   0xff282a36 &
      spacebar -m config space_icon_color_tertiary    0xff282a36 &
      spacebar -m config display_separator_icon_color 0xff282a36 &
      spacebar -m config background_color 0xfff3f99d             &
      spacebar -m config foreground_color 0xff282a36             &
      ;;
    highlight_resize) # cyan
      spacebar -m config space_icon_color             0xff282a36 &
      spacebar -m config space_icon_color_secondary   0xff282a36 &
      spacebar -m config space_icon_color_tertiary    0xff282a36 &
      spacebar -m config display_separator_icon_color 0xff282a36 &
      spacebar -m config background_color 0xff9aedfe             &
      spacebar -m config foreground_color 0xff282a36             &
      ;;
    highlight_toggle) # purple
      spacebar -m config space_icon_color             0xff282a36 &
      spacebar -m config space_icon_color_secondary   0xff282a36 &
      spacebar -m config space_icon_color_tertiary    0xff282a36 &
      spacebar -m config display_separator_icon_color 0xff282a36 &
      spacebar -m config background_color 0xffcc66cc             &
      spacebar -m config foreground_color 0xff282a36             &
      ;;
    highlight_launch) # blue
      spacebar -m config space_icon_color             0xff282a36 &
      spacebar -m config space_icon_color_secondary   0xff282a36 &
      spacebar -m config space_icon_color_tertiary    0xff282a36 &
      spacebar -m config display_separator_icon_color 0xff282a36 &
      spacebar -m config background_color 0xff57c7ff             &
      spacebar -m config foreground_color 0xff282a36             &
      ;;
    highlight_window)
      spacebar -m config space_icon_strip WINDOW
      ;;
    highlight_space)
      spacebar -m config space_icon_strip SPACE
      ;;
    highlight_display)
      spacebar -m config space_icon_strip DISPLAY
      ;;
  esac
else
  case "$1" in
    highlight_default) # default
      yabai -m config window_border_width 1
      yabai -m config active_window_border_color 0x00444444
      yabai -m config normal_window_border_color 0x00444444
      ;;
    highlight_active) # white
      yabai -m config window_border_width 128
      yabai -m config active_window_border_color 0xb2000000
      yabai -m config normal_window_border_color 0xb2000000
      ;;
    highlight_focus) # green
      yabai -m config window_border_width 128
      yabai -m config normal_window_border_color 0xb266cc66
      yabai -m config active_window_border_color 0xb299ff99
      ;;
    highlight_grid) # orange/magenta
      yabai -m config window_border_width 128
      yabai -m config normal_window_border_color 0xb2cc9966
      yabai -m config active_window_border_color 0xb2ffcc99
      ;;
    highlight_swap) # red
      yabai -m config window_border_width 128
      yabai -m config normal_window_border_color 0xb2cc6666
      yabai -m config active_window_border_color 0xb2ff9999
      ;;
    highlight_move) # yellow
      yabai -m config window_border_width 128
      yabai -m config normal_window_border_color 0xb2cccc66
      yabai -m config active_window_border_color 0xb2ffff99
      ;;
    highlight_resize) # cyan
      yabai -m config window_border_width 128
      yabai -m config normal_window_border_color 0xb266cccc
      yabai -m config active_window_border_color 0xb299ffff
      ;;
    highlight_toggle) # purple
      yabai -m config window_border_width 128
      yabai -m config normal_window_border_color 0xb2cc66cc
      yabai -m config active_window_border_color 0xb2ff99ff
      ;;
    highlight_launch) # blue
      yabai -m config window_border_width 128
      yabai -m config normal_window_border_color 0xb26666cc
      yabai -m config active_window_border_color 0xb29999ff
      ;;
    highlight_window)
      yabai -m config window_border_width 192
      yabai -m config normal_window_border_color 0xb2444444
      ;;
    highlight_space)
      yabai -m config window_border_width 320
      ;;
    highlight_display)
      yabai -m config window_border_width 2048
      ;;
  esac
fi
