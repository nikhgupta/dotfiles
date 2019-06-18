#!/usr/bin/env sh


#    4:3: 640×480, 800×600, 960×720, 1024×768, 1280×960, 1400×1050, 1440×1080 , 1600×1200, 1856×1392, 1920×1440, and 2048×1536.
#    16:10: 1280×800, 1440×900, 1680×1050, 1920×1200 and 2560×1600.
#    16:9: 1024×576, 1152×648, 1280×720, 1366×768, 1600×900, 1920×1080, 2560×1440 and 3840×2160.

sep="         "

nome() {
    fl=$(basename -- "$1")
    ext="${fl##*.}"
    echo "${fl%.*}.${res}.${ext}"
}

manual() {
	ffmpeg -i $1 -s 720x480 -c:a copy output.mkv
}

ffmpeg -i $1 -filter:v scale=720:-1 -c:a copy output.mkv

echo
echo "$sep a) Manual"
echo "$sep b) Auto"
echo

while :
do
	read mode
	case $mode in
	a)
		break
		;;
	b)
		break
		;;
	*)
		echo "Opção incorreta."
		;;
  esac
done

