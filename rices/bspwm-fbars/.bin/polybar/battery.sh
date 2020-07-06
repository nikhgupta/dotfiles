#!/bin/bash
LOW=20
TOO_LOW=10
TOO_HIGH=99
ICON="battery-empty"
export DISPLAY=:0.0

battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')

on_ac_power() { [ $(acpi -a | grep Adapter | cut -d: -f2) != 'off-line' ]; }

if ! on_ac_power; then
  if [ $battery_level -le $TOO_LOW ]; then
    notify-send "Battery is really low." "Need charging! Please plug your AC adapter.<br/>You will be locked out in 20 seconds, otherwise.<br/>Charging: ${battery_level}%" -i $ICON -u critical
    sleep 20
    ! on_ac_power && ~/.bin/screenlock.sh &
  elif [ $battery_level -le $LOW ]; then
    notify-send "Battery on low charge." "Need charging! Please plug-in your AC adapter.<br/>Charging: ${battery_level}%" -i $ICON
  fi
  # else
  # if [ $battery_level -ge $TOO_HIGH ]; then
  #   notify-send "Battery fully charged." "Please unplug your AC adapter!<br/>Charging: ${battery_level}% " -i $ICON
  # fi
fi
