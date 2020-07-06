#!/usr/bin/env bash

if [ -f $HOME/.config/user-dirs.dirs ]; then
  source $HOME/.config/user-dirs.dirs
  dir="${XDG_SCREENSHOT_DIR}/"
else
  dir="${HOME}/Pictures/Screenshots/"
fi

app="maim"
params="-u"
name=$(date +%Y-%m-%d_%H-%M-%S)
extension=".png"
delay=10
icon="camera-on"
type="image/png"
cache="${dir}/OLD/"

[ ! -d $dir ] && mkdir -p $dir
[ ! -d $trash ] && mkdir -p $trash

command -v $app >/dev/null 2>&1 || {
  msg="Application $app not installed. Aborting."
  command -v notify-send >/dev/null 2>&1 && {
    notify-send "ERROR" "$msg"
  } || {
    echo $msg
  }
  exit 1
}

if [ "$1" == "open" ]; then
  xdg-open $dir &
elif [ "$1" == "cache" ]; then
  icon="tools-wizard"
  listing=(${dir}*.{jpg,jpeg,bmp,gif,png})
  if [ ${#listing[@]} -gt 0 ]; then
    mkdir -p $cache
    mv ${dir}*.{jpg,jpeg,bmp,gif,png} $cache
    msg="Moved existing screenshots to long-term cache."
    canberra-gtk-play -i trash-empty 2>&1
  else
    msg="Screenshots folder already cached!"
  fi

  exit 0

elif [ "$1" == "window" ]; then
  params="$params -i $(xdotool getactivewindow)"
  archive="${name}-window${extension}"
  $app $params ${archive}
  msg=$archive
elif [ "$1" == "sel" ]; then
  params="$params -s"
  archive="${name}-area${extension}"
  $app -d 2 $params ${archive}
  msg=$archive
elif [ "$1" == "delay" ]; then
  params="$params -d $delay"
  archive="${name}-delayed${extension}"
  $app $params ${archive}
  msg=$archive
elif [ "$1" == "edit" ]; then
  archive="${name}-edited${extension}"
  $app $params ${dir}${archive}
  msg=$archive
  viewnior ${dir}${archive}
else
  archive="${name}${extension}"
  $app $params ${archive}
  msg=$archive
fi

if [ ! -z $archive ] && [ -f $archive ]; then
  if [ $(pwd) != $dir ]; then
    mv $archive $dir
  fi
  xclip -selection c -t $type -i $dir$archive

  canberra-gtk-play -i camera-shutter 2>&1
  notify-send -i $icon "Screenshot" "$msg"
fi

exit 0
