#!/usr/bin/env bash

file=$(realpath $1)
if [[ -n "$file" ]]; then
  osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"${file}\""
else
  echo "[ERROR]: Could not find file: $1 identified by realpath: ${file}"
fi
