#!/usr/bin/env bash

dir="${XDG_WALLPAPER_DIR}"
unsplash_dir="${dir}/unsplash"
default="${dir}/_default.jpg"
ultima="/home/nikhgupta/Pictures/__WALLPAPERS__/unsplash/unsplash-5028.jpg"
modo="--bg-fill"
indice=0
i=0
x=$(xdpyinfo | grep dimensions | awk '{print $2}' | awk -F'x' '{print $1}')
y=$(xdpyinfo | grep dimensions | awk '{print $2}' | awk -F'x' '{print $2}')

ajustar() {
  if [ -f "$1" ]; then
    sed -i "s|^ultima=.*|ultima=\"${1}\"|g" $0
    # PyWal
    #wal -n -g -i "${1}"
    feh --bg-fill ${1}
    echo "$1" > ~/.wall
  fi
}

if [ "$2" ]; then
  if [ -d $2 ]; then
    dir=$2
  fi
else
  if [ ! -d $dir ]; then
    mkdir -p $dir
  fi
fi

if [ ! -d $unsplash_dir ]; then
  mkdir -p $unsplash_dir
fi

[ ! -f $default ] && curl -s -L 'https://unsplash.com/photos/mEV-IXdk5Zc/download?force=true' > $dir/alex-block-354270-unsplash.jpg

while read linha; do
    imagens[$i]="$linha"
    ((i++))
done < <(find "$dir" -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg \))

cont=${#imagens[@]}
total=$(($cont-1))

if [ $total -gt 0 ]; then
  for i in "${!imagens[@]}"; do
      if [[ "${imagens[$i]}" = "${ultima}" ]]; then
          indice=${i}
      fi
  done
else
  echo "Nenhuma imagem."
  exit 1
fi

if [ "$1" == "d" ]; then
  img="$unsplash_dir/unsplash-$$.jpg"
  curl -L -s "https://unsplash.it/${x}/${y}?random" > $img
  notify-send "Sucesso" "Imagem <b>$img</b> baixada."
elif [ "$1" == "dd" ]; then
  apagar=$(echo -e "Sim\nNão" | rofi -p "Apagar $(basename $(cat ~/.wall))?" -dmenu -bw 0 -lines 2 -width 400 -separator-style none -location 0 -hide-scrollbar -padding 5)
  if [ "$apagar" == "Sim" ]; then
    rm $(cat ~/.wall)
    notify-send "Sucesso" "Imagem <b>$(basename $(cat ~/.wall))</b> apagada."
    hsetroot -solid "#2e3440"
    echo $default > $HOME/.wall
  fi
elif [ "$1" == "rr" ]; then
  if [ ! -f $HOME/.wall ] || [ ! -f $(cat $HOME/.wall) ]; then
    echo $default > $HOME/.wall
  fi
  #img="$(cat $HOME/.wall)"
  img=$default
elif [ "$1" == "x" ]; then
  hsetroot -solid "#2e3440"
elif [ "$1" == "a" ]; then
  if [ $indice -gt 0 ]; then
    ((indice--))
  else
    indice=$total
  fi
  img=${imagens[$indice]}
elif [ "$1" == "p" ]; then
  if [ $indice -lt $total ]; then
    ((indice++))
  else
    indice=0
  fi
  img=${imagens[$indice]}
elif [ "$1" == "r" ]; then
  if [ ! -f $HOME/.wall ] || [ ! -f $(cat $HOME/.wall) ]; then
    echo $default > $HOME/.wall
  fi
  img=$(cat $HOME/.wall)
elif [ "$1" != "d" ]; then
  img=${imagens[$RANDOM % ${#imagens[@]}]}
fi

ajustar "$img"
