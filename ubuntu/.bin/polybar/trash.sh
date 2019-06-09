#!/bin/bash

COR=$(awk -F# '/pink/{print $2;exit}' ${HOME}/.config/polybar/config)
TRASH_DIRECTORY="${HOME}/.local/share/Trash"
TRASH_TEMP="/tmp/trash"

if [[ "${TRASH_DIRECTORY}" = "" ]]; then
  TRASH_DIRECTORY=${XDG_DATA_HOME:-"${HOME}/.local/share/Trash"}
fi

if [[ "${1}" == "-x" ]]; then
  if [ ! -d $TRASH_TEMP ]; then
    mkdir $TRASH_TEMP
  fi

  cp -rf ${TRASH_DIRECTORY}/* ${TRASH_TEMP}/
  rm -rf ${TRASH_DIRECTORY}/*
  mkdir ${TRASH_DIRECTORY}

  export DISPLAY=:0 ; canberra-gtk-play -i trash-empty 2>&1
elif [[ "${1}" == "-o" ]]; then
  xdg-open $TRASH_DIRECTORY
fi

TRASH_COUNT=$(ls -U -1 "${TRASH_DIRECTORY}" | wc -l)

if [[ ${TRASH_COUNT} -gt 0 ]]; then
  s="%{F#${COR}} %{F-} ${TRASH_COUNT}"
else
  s=" "
fi

echo "${s}"
