#!/bin/sh

killall xwinwrap
#xwinwrap -o 0.5 -ni -fs -st -sp -b -nf -- mplayer -wid WID "$1"
#xwinwrap -fs -st -sp -b -nf -- mplayer -loop 0 -wid WID "$1"
xwinwrap -fs -st -sp -b -nf -- mpv --wid WID "$1"
