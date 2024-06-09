#!/usr/bin/env zsh

local _theme=Nord

IFS=':' read -rA INPUT <<< "$@"
file=$(echo ${INPUT[1]} | perl -pe 's/\e\[[0-9;]*m(?:\e\[K)?//g')
line=$(echo ${INPUT[2]} | perl -pe 's/\e\[[0-9;]*m(?:\e\[K)?//g')
# echo "============"
# echo "$@"
# echo $file
# echo $line
# echo "============"

if [[ -f "${file}" ]]; then
  if hash bat 2>/dev/null; then
      if ! [ -z "${line}" ]; then
          topline=$(($line - 10))
          botline=$(($line + 10))
          [ $topline -lt 1 ] && topline=1
          bat --style=numbers --color=always --theme=$_theme --line-range $topline:$botline --highlight-line $line "$file"
      else
          bat --style=numbers --color=always --theme=$_theme "$file"
      fi
  else
      cat "$file"
  fi
elif [[ -d "${file}" ]]; then
  tree -C "${file}" | less
else
  echo "${1}" 2>/dev/null | head -200
fi
