#!/bin/sh

codec="mpeg4"
acodec="libmp3lame"
video="${2}"

versao() {
	echo
	echo "videoconvert.sh v0.1b"
	echo "Por Lucas Saliés Brum"
	echo
	exit 0
}

uso() {
	echo
	echo "Uso: $(basename $0) -cv arquivo.mp4"
	echo "     $(basename $0) -cv arquivo.mp4 600x400"
	echo "     $(basename $0) -cv arquivo.mp4 600x400 600k"
	echo
	echo "     $(basename $0) -ct arquivo.mp4 00:00:30 00:00:10"
	echo
	echo "     $(basename $0) -l"			
	echo
	exit 0
}

res() {
	echo 
	echo "Resoluções recomendadas:"
cat << EOF
		4:3
		------------
		640x480
		576x432
		512x384
		448x336
		384x288
		320x240
		256x192
		192x144
		128x96

		16:9
		------------
		1280x720
		1024x576
		768x432
		512x288
		256x144
EOF
echo

	exit 0

}

cortar() {
	[ ${4} -lt 4 ] && uso
	echo "Inicio: ${3}"
	echo "Duração: ${4}"
	ffmpeg -y -i "$video" -acodec copy -vcodec copy -ss "${3}" -t "${4}" "${video}.new.avi"
}

converter() {
	[ "$3" ] && res="${3}" || res="320x240"
	[ "$4" ] && bitrate="${4}" || bitrate="600k"
	ffmpeg -y -i "$video" -c:v $codec -b:v $bitrate -c:a $acodec -s $res "${video}.new.avi"
}

[ "$1" == "-v" ] && versao
[ "$1" == "-l" ] && res
[ ! "$2" ] || [ "$1" == "-h" ] && uso 
[ "$1" == "-cv" ] && converter
[ "$1" == "-ct" ] && cortar
