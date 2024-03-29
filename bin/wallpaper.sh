#!/usr/bin/env bash

dir="${XDG_WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"
default="${dir}/default.png"
unsplash_dir="${dir}/unsplash"
default_url="https://wallpapercave.com/wp/NOFQh9F.png"
lastused=$(cat ~/.wall)
indice=0
i=0
dim=$(osascript -e 'tell application "Finder" to get bounds of window of desktop')
x=$(echo $dim |  tr -d ',' | awk '{print $3}')
y=$(echo $dim |  tr -d ',' | awk '{print $4}')

adjust() {
  if [ -f "$1" ]; then
    # PyWal
    #wal -n -g -i "${1}"
    #feh --bg-fill ${1}
    ~/.bin/macos/set-wall.sh "$1"
    echo "$1" >~/.wall
  fi
}

[ -n "$2" ] && [[ -d "$2" ]] && dir=$2
[ ! -d $dir ] && mkdir -p $dir
[ ! -d $unsplash_dir ] && mkdir -p $unsplash_dir
[ ! -f $default ] && curl -s -L $default_url > $default

fetch_images() {
  while read line; do
    images[$i]="$line"
    ((i++))
  done < <(find "$dir" -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg \))
}

fetch_images
count=${#images[@]}
total=$(($count - 1))

if [ $total -gt 0 ]; then
  for i in "${!images[@]}"; do
    if [[ "${images[$i]}" = "${lastused}" ]]; then
      indice=${i}
    fi
  done
elif [[ -z "$1" ]]; then
  adjust "$default"
  exit 0
fi

if [ "$1" == "open" ]; then
  open $dir
elif [ "$1" == "d" ]; then
  mkdir -p $unsplash_dir
  img="$unsplash_dir/unsplash-$$.jpg"
  curl -L -s "https://source.unsplash.com/${x}x${y}?nature,birds,family" >$img
  terminal-notifier -title "Success" -message "Image $(basename $img) downloaded."
elif [ "$1" == "dd" ]; then
  rm $(cat ~/.wall)
  terminal-notifier -title "Success" -message "Image $(basename $(cat ~/.wall)) deleted."
  fetch_images
  $0 d && exit 0
  img=${images[$RANDOM % ${#images[@]}]}
elif [ "$1" == "rr" ]; then
  if [ ! -f $HOME/.wall ] || [ ! -f $(cat $HOME/.wall) ]; then
    echo $default >$HOME/.wall
  fi
  #img="$(cat $HOME/.wall)"
  img=$default
elif [ "$1" == "x" ]; then
  img=$default
elif [ "$1" == "a" ]; then
  if [ $indice -gt 0 ]; then
    ((indice--))
  else
    indice=$total
  fi
  img=${images[$indice]}
elif [ "$1" == "p" ]; then
  if [ $indice -lt $total ]; then
    ((indice++))
  else
    indice=0
  fi
  img=${images[$indice]}
elif [ "$1" == "r" ]; then
  if [ ! -f $HOME/.wall ] || [ ! -f $(cat $HOME/.wall) ]; then
    echo $default >$HOME/.wall
  fi
  img=$(cat $HOME/.wall)
elif [ "$1" != "d" ]; then
  img=${images[$RANDOM % ${#images[@]}]}
fi

adjust "$img"
exit 0
