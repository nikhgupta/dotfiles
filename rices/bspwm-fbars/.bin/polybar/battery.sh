#!/bin/bash
LOW=20
TOO_LOW=10
TOO_HIGH=99
ICON="battery-empty"
CHARGING_COLOR="#F3F99D"
DISCHARGING_COLOR="#5AF78E"
LOW_COLOR="#FF5C57"
DEFAULT_WALL="${XDG_WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}/default.png"
ONLY_FOR_DEFAULT_WALLPAPER=1

mkdir -p /tmp/scripts
[[ -z "$ONLY_FOR_DEFAULT_WALLPAPER" ]] && _change_wall=1
[[ "$(cat ~/.wall)" == $DEFAULT_WALL ]] && _change_wall=1

battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
echo $battery_level >> /tmp/scripts/battery.status

on_ac_power() {
  acpi -a | grep -qi "Adapter 0: on-line"
}

overlay_wallpaper() {
  _current=$(cat ~/.wall)
  _generated=/tmp/scripts/battery.$1.$(cat $_current | md5sum | cut -d ' ' -f 1).png

  if [[ "$_change_wall" == "1" ]] && [[ ! -f $_generated ]]; then
    rm -f /tmp/scripts/battery.*.png
    if [[ "$3" == "solid" ]]; then
      convert $_current \( -clone 0 -fill "$2" -colorize 100 \) -compose atop -composite $_generated
    elif [[ -n "$2" ]]; then
      convert $_current \
      \( -clone 0 -fill "$2" -colorize 100 -alpha set -channel a -evaluate set 100% +channel \) \
      \( -clone 0 -alpha extract \) \
      -compose overlay -composite $_generated
    else
      _generated=$_current
    fi
    feh --bg-fill --no-fehbg $_generated
  fi
}

if on_ac_power; then
  if [ $battery_level -ge $TOO_HIGH ]; then
    overlay_wallpaper charged
    # notify-send "Battery fully charged." "Please unplug your AC adapter!<br/>Charging: ${battery_level}% " -i $ICON
  else
    overlay_wallpaper charging $CHARGING_COLOR
  fi
else
  if [ $battery_level -le $TOO_LOW ]; then
    overlay_wallpaper toolow $LOW_COLOR solid
    [[ "$1" != "quiet" ]] && notify-send "Battery is really low." "Need charging! Please plug your AC adapter.<br/>You will be locked out in 20 seconds, otherwise.<br/>Charging: ${battery_level}%" -i $ICON -u critical
    sleep 20
    ! on_ac_power && ~/.bin/screenlock.sh &
  elif [ $battery_level -le $LOW ]; then
    overlay_wallpaper low $LOW_COLOR
    [[ "$1" != "quiet" ]] && notify-send "Battery on low charge." "Need charging! Please plug-in your AC adapter.<br/>Charging: ${battery_level}%" -i $ICON
  else
    overlay_wallpaper discharging $DISCHARGING_COLOR
  fi
fi
