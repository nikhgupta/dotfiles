#!/bin/bash

COR=$(awk -F# '/pink/{print $2;exit}' ${HOME}/.config/polybar/config)
TRASH_DIRECTORY="${HOME}/.local/share/Trash"
TRASH_TEMP="/tmp/trash"

if [[ "${TRASH_DIRECTORY}" = "" ]]; then
  TRASH_DIRECTORY=${XDG_DATA_HOME:-"${HOME}/.local/share/Trash"}
fi

if [[ "${1}" == "empty" ]]; then
  if [ ! -d $TRASH_TEMP ]; then
    mkdir -p $TRASH_TEMP/{files,info}
  fi

  cp -rf ${TRASH_DIRECTORY}/files/* ${TRASH_TEMP}/
  rm -rf ${TRASH_DIRECTORY}/files/*
  rm -rf ${TRASH_DIRECTORY}/info/*
  mkdir ${TRASH_DIRECTORY}/files
  mkdir ${TRASH_DIRECTORY}/info

  export DISPLAY=:0 ; canberra-gtk-play -i trash-empty 2>&1
elif [[ "${1}" == "open" ]]; then
  xdg-open $TRASH_DIRECTORY/files/
fi

TRASH_COUNT=$(ls -U -1 "${TRASH_DIRECTORY}/files" | wc -l)

if [[ ${TRASH_COUNT} -gt 0 ]]; then
  s="%{F#${COR}} %{F-} ${TRASH_COUNT}"
else
  s=" "
fi

echo "${s}"
