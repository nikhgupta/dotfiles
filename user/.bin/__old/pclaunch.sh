#!/bin/sh

XSS="xscreensaver"
PC="/usr/lib/popcorntime/Popcorn-Time"

pgrep $XSS > /dev/null

if [ $? -eq 0 ]; then
	killall $XSS
	($PC && $XSS -no-splash)
else
	$PC
fi
