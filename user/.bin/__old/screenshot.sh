#!/bin/sh

if [ -f ~/.config/user-dirs.dirs ]; then
	source ~/.config/user-dirs.dirs
	dir="${XDG_PICTURES_DIR}/shots/"
else
	dir="${HOME}/img/shots/"
fi

app="maim -u"
data=$(date +%Y-%m-%d_%H-%M-%S)
nome="ss-${data}"
extensao=".png"
atraso=10
icone="/usr/share/icons/Arc/devices/24@2x/video-display.png"
tipo="image/png"
#msg="A screenshot <b>$arquivo</b> foi salva em <b>$dir</b>..."
msg="Imagem salva em <b>$dir</b>..."

[ ! -d $dir ] && mkdir -p $dir

if [ "$1" == "-a" ]; then
	arquivo="${nome}-full${extensao}"
	$app ${arquivo}
elif [ "$1" == "-w" ]; then
	arquivo="${nome}-window${extensao}"
	$app -i $(xdotool getactivewindow) ${arquivo}
elif [ "$1" == "-s" ]; then
	arquivo="${nome}-rec${extensao}"
    $app -s ${arquivo}
elif [ "$1" == "-d" ]; then
    arquivo="${nome}-delay${extensao}"
    $app -d $atraso ${arquivo}
elif [ "$1" == "-g" ]; then
    arquivo="${nome}.gif"
    tipo="image/gif"

    duracao=$(echo "5;10;15;30;45;60;90;120" | \
    rofi -sep ";" -dmenu -p "Duração(segundos):" -bw 0 -lines 8 -separator-style none -location 0 -width 10 -hide-scrollbar -padding 5)

    atraso=$(echo "0;1;2;3;5;10;15;30;45;60" | \
    rofi -sep ";" -dmenu -p "Atraso(segundos):" -bw 0 -lines 10 -separator-style none -location 0 -width 10 -hide-scrollbar -padding 5)

    if [ -z $atraso ]; then
    	atraso=2
    fi

    if [ ! -z $duracao ]; then
    	byzanz-record --delay=$atraso -d $duracao ${arquivo}
	else
		msg="Screenshot cancelada..."
    fi
else
	arquivo="${nome}${extensao}"
	$app ${arquivo}
fi

if [ ! -z $arquivo ]; then
	if [ $(pwd) != $dir ]; then
		mv $arquivo $dir
	fi
	xclip -selection c -t $tipo -i $dir$arquivo
fi

notify-send -i $icone "ScreenShot" "$msg"
