#!/usr/bin/env bash

if [ -f $HOME/.config/user-dirs.dirs ]; then
  source $HOME/.config/user-dirs.dirs
  dir="${XDG_PICTURES_DIR}/screenshots/"
else
  dir="${HOME}/Pictures/screenshots/"
fi

app="maim"
params="-u"
data=$(date +%Y-%m-%d_%H-%M-%S)
nome="ss-${data}"
extensao=".png"
atraso=10
icone="/usr/share/icons/Arc/devices/24@2x/video-display.png"
tipo="image/png"
lixeira="${HOME}/.local/share/Trash"

[ ! -d $dir ] && mkdir -p $dir
[ ! -d $lixeira ] && mkdir -p $lixeira

command -v $app >/dev/null 2>&1 || {
  msg="O aplicativo $app não está instalado. Abortando."

  command -v notify-send >/dev/null 2>&1 && {
    notify-send "ERRO" "$msg";
  } || {
    echo $msg;
  }

  exit 1;
}

if [ "$1" == "-c" ]; then
  icone="/usr/share/icons/Arc/places/24@2x/user-trash.png"
  listagem=(${dir}*)
  if [ ${#listagem[@]} -gt 0 ]; then
    mv ${dir}* ${lixeira}/files/
    msg="Pasta de screenshots limpa!"
    export DISPLAY=:0 ; canberra-gtk-play -i trash-empty 2>&1
  else
    msg="Pasta de screenshots já está vazia!"
  fi

  exit 0

elif [ "$1" == "-w" ]; then
  params="$params -w"
  arquivo="${nome}-window${extensao}"
  $app $params ${arquivo}
  msg="A screenshot <b>$arquivo</b> salva em <b>$dir</b>..."
elif [ "$1" == "-s" ]; then
  params="$params -s"
  arquivo="${nome}-sel${extensao}"
  $app -d 2 $params ${arquivo}
  msg="A screenshot <b>$arquivo</b> salva em <b>$dir</b>..."
elif [ "$1" == "-d" ]; then
  params="$params -d $atraso"
  arquivo="${nome}-delay${extensao}"
  $app $params ${arquivo}
  msg="A screenshot <b>$arquivo</b> salva em <b>$dir</b>..."
elif [ "$1" == "-e" ]; then
  arquivo="${nome}-edit${extensao}"
  $app $params ${dir}${arquivo}
  msg="A screenshot <b>$arquivo</b> salva em <b>$dir</b>..."
  viewnior ${dir}${arquivo}
else
  arquivo="${nome}${extensao}"
  $app $params ${arquivo}
  msg="A screenshot <b>$arquivo</b> salva em <b>$dir</b>..."
fi

if [ ! -z $arquivo ]; then
  if [ $(pwd) != $dir ]; then
    mv $arquivo $dir
  fi
  xclip -selection c -t $tipo -i $dir$arquivo
fi

export DISPLAY=:0 ; canberra-gtk-play -i camera-shutter 2>&1

notify-send -i $icone "ScreenShot" "$msg"

exit 0
