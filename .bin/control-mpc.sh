#!/usr/bin/env bash

case "$1" in
     next)
        mpc next && notify-send --hint=int:transient:1 -t 2000 "MPD" "`mpc current`"
            ;;
     prev)
        mpc prev && notify-send --hint=int:transient:1 -t 2000 "MPD" "`mpc current`"
            ;;
     toggle)
        mpc toggle && notify-send --hint=int:transient:1 -t 2000 "MPD" "`mpc | sed -n 2p`" && notify-send --hint=int:transient:1 -t 2000 "MPD" "`mpc current`"
            ;;
     stop)
        mpc stop && notify-send --hint=int:transient:1 -t 2000 "MPD" "detenido"
            ;;
     view)
        notify-send --hint=int:transient:1 -t 2000 "MPD" "`mpc current`"
esac

exit 0
