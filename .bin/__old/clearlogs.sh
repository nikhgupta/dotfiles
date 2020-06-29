#!/bin/sh

if is_installed journalctl; then
  if [ $UID = 0 ]; then
    journalctl --flush --rotate
    journalctl --vacuum-size=10M
    journalctl --verify
  else
    if sudo true; then
      sudo journalctl --flush --rotate
      sudo journalctl --vacuum-size=10M
      sudo journalctl --verify
    else
      echo "You need to run this script using sudo"
    fi
  fi
fi
