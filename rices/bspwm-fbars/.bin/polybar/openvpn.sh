#!/usr/bin/env bash

indice=0
dir=$HOME/Dropbox/openvpn
last_used=$dir/Japan.ovpn

while read file; do
    ovpns[$i]="$file"
    ((i++))
done < <(find "$dir" -type f \( -iname \*.ovpn \))

cont=${#ovpns[@]}
total=$(($cont-1))

if [ $total -gt 0 ]; then
  for i in "${!ovpns[@]}"; do
      if [[ "${ovpns[$i]}" = "${last_used}" ]]; then
          indice=${i}
      fi
  done
fi

if [ "$1" == 's' ]; then
  sudo pkill openvpn
  notify-send "Success" "Stopped OpenVPN connection."
  exit 0
fi

if [ "$1" == 'r' ]; then
  if [ $indice -lt $total ]; then
    ((indice++))
  else
    indice=0
  fi
  conn=${ovpns[$indice]}
  sed -i "s|^last_used=.*|last_used=\"${conn}\"|g" $0
  sudo openvpn $conn &
  notify-send "Success" "Connecting via ${conn}.."
  exit 0
fi
