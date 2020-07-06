#!/bin/sh
checkupdates > /tmp/off.updates
wget -O /tmp/aur.rss https://aur.archlinux.org/rss/
grep "$(pacman -Qm)" /tmp/aur.rss > /tmp/rss.check
grep "<title>$(pacman -Qm)</title>" /tmp/rss.check > /tmp/aur.updates
