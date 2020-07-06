#!/bin/bash
IP=$(curl ipinfo.io/ip 2>/dev/null)
if pgrep -x openvpn > /dev/null; then
  echo "%{F#5FAD56} %{F-}$IP"
elif [ -n "$IP" ]; then
  echo "%{F#e60053} %{F-}$IP"
else
  echo "%{F#e60053}%{F-}"
fi
