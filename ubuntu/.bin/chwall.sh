#!/bin/bash
#
# help: change wallpaper
# updated: 10-06-19 01:20:31

FEH=$(which feh)
DEFAULT="$XDG_WALLPAPER_DIR/_default.jpg"

if [ "$1" ]; then
  if [ "$1" == "-h" ] || [ "$1" == "-H" ] || [ "$1" == "--h" ] || [ "$1" == "--H" ] || [ "$1" == "--help" ]; then
    echo
    echo "Use: chwall.sh /dir/for/wallpapers/"
    echo "     chwall.sh -drVp"
    echo
    exit 0
  elif [ "$1" == "-v" ] || [ "$1" == "--v" ] || [ "$1" == "--V" ] || [ "$1" == "--version" ]; then
    echo
    echo "chwall.sh 0.1b"
    echo
    echo "Nikhil Gupta"
    echo
    exit 0
  elif [ "$1" == "-d" ]; then
    rm -f $(cat ${HOME}/.wallpaper)
  elif [ "$1" == "-r" ]; then
    feh --bg-fill $(cat ${HOME}/.wallpaper)
  elif [ "$1" == "-V" ]; then
    feh $(cat ${HOME}/.wallpaper)
  elif [ "$1" == "-p" ]; then
    feh --bg-fill $DEFAULT
  else
    WALLPAPER="$(find ${1}|shuf -n1)"
    feh --bg-fill ${WALLPAPER}
    echo ${WALLPAPER} > ${HOME}/.wallpaper
  fi
else
  if [ "$XDG_WALLPAPER_DIR" ]; then
    WALLPAPER="$(find ${XDG_WALLPAPER_DIR}/ |shuf -n1)"
    feh --bg-fill ${WALLPAPER}
    echo ${WALLPAPER} > ${HOME}/.wallpaper
  fi
fi

exit 0
