#!/bin/bash
# volume notifications

# Arbitrary but unique message id
msgId="991049"

if [[ "$1" == "toggle-mic" ]]; then
  pactl set-source-mute @DEFAULT_SOURCE@ toggle
elif [[ "$1" == "toggle" ]]; then
  pactl set-sink-mute @DEFAULT_SINK@ toggle
elif [[ "$1" == "raise" ]]; then
  pactl set-sink-mute @DEFAULT_SINK@ false
  pactl set-sink-volume @DEFAULT_SINK@ +5%
elif [[ "$1" == "lower" ]]; then
  pactl set-sink-mute @DEFAULT_SINK@ false
  pactl set-sink-volume @DEFAULT_SINK@ -5%
fi

if [[ "$1" == "toggle-mic" ]]; then
  mic_muted="$(pactl list sources | grep -qi 'mute: yes' && echo 'on' || echo 'off')"
  if [[ "$mic_muted" == "off" ]]; then
      dunstify -a "changeVolume" -u low -i audio-recorder-off -r "$msgId" "Mic muted" 
  elif [[ "$mic_muted" == "on" ]]; then
      dunstify -a "changeVolume" -u low -i audio-recorder-on -r "$msgId" "Mic unmuted" 
  fi
else
  volume="$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')"
  mute="$(amixer sget Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g')"
  if [[ $volume == 0 || "$mute" == "off" ]]; then
      dunstify -a "changeVolume" -u low -i audio-volume-muted -r "$msgId" "Volume muted" 
  else
      dunstify -a "changeVolume" -u low -i audio-volume-high -r "$msgId" \
      "Volume: ${volume}%" "$(getProgressString 10 "<b> </b>" " " $volume)"
  fi
fi

canberra-gtk-play -i audio-volume-change -d "changeVolume"
