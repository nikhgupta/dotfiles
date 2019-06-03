
#!/usr/bin/env bash

titulo="Audio Redux"
[ $1 ] && dir="$1" || dir="$(pwd)"
novo="${dir}/$$"

which dialog 1> /dev/null 2> /dev/null
if [ $? != 0 ]; then
	echo "O aplicativo dialog não foi encontrado."
	exit 1
fi

ext=$(dialog --stdout --title "$titulo" --menu 'Extensão:' 0 0 0   'mp3' '' 'm4a' '')
if [ $(ls -1 *.$ext 2>/dev/null | wc -l) != 0 ]; then
	mkdir $dir
	# The range is 0-9 where a lower value is a higher quality. 0-3 will normally produce transparent results, 4 (default)
	# should be close to perceptual transparency, and 6 usually produces an "acceptable" quality.
	# The option -qscale:a is mapped to the -V option in the standalone lame command-line interface tool.
	qualidade=$(dialog --stdout --title "$titulo" --menu 'Qualidade(menor = mais qualidade):' 0 0 0   1 '' 2 '' 3 '' 4 '' 5 '' 6 '' 7 '' 8 '' 9 '')

	for f in *.$ext; do
		ffmpeg -i $f -codec:v copy -codec:a libmp3lame -q:a $qualidade $novo/${f%.m4a}.mp3
	done
else
	dialog --title "$titulo" --msgbox "Nenhum arquivo com a extensão: $ext foi encontrado!" 0 0
	exit 0
fi

dialog --title "$titulo" --msgbox "Arquivos reduzidos com sucesso!" 0 0
