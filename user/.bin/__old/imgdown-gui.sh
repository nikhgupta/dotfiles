#!/usr/bin/env bash
#
# Arquivo: imgdown-gui.sh
# Descrição: Script usando o YAD, xclip e wget para baixar múltiplos arquivos de uma determinada
# extensão em um(ou vários) site(s).
#
# Feito por Lucas Saliés Brum, a.k.a. sistematico <lucas@archlinux.com.br>
#
# Criado em:        20/09/2018 05:48:46
# Última alteração: 20/09/2018 14:38:55
#
# Referências:
# https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a
# https://stackoverflow.com/a/19060079

titulo="IMGdown"
ext="jpg"  		# Separadas por virgula.
pasta="$(pwd)" 	# Diretório para salvar os arquivos.
min='300' 		# Resolução Vertical(em pixels)
lixeira="${HOME}/.local/share/Trash"
#subpasta=$(find "$pasta" -type d | egrep -v 'tmp-' | wc -l)
subpasta="$$"
icone="gnome-shutdown"
i=$(ps aux | grep $(basename $0) | egrep -v grep | wc -l)
((ins=i-1))

command -v yad 1> /dev/null 2> /dev/null
if [ $? = 1 ]; then
	echo "yad não instalado."
	exit
fi

command -v xclip 1> /dev/null 2> /dev/null
if [ $? = 0 ]; then
	turl="$(xclip -o)"
fi

eval $(yad --title "$titulo" --window-icon=$icone --width=400 --form --field="URLs" --field="Sub-pasta" --field="Resolução" --field="Instancias" "$turl" "$subpasta" "$min" "$ins" | awk -F'|' '{printf "urls=\"%s\"\nsubpasta=\"%s\"\nmin=%s\n", $1, $2, $3}')
[[ -z $urls || -z $min ]] && exit 1

mkdir $subpasta

for u in $urls; do
	#dominio=$(echo "$u" | awk -F/ '{print $3}')
	dominio=$(echo "$u" | sed -e "s/[^/]*\/\/\([^@]*@\)\?\([^:/]*\).*/\2/" | sed "s/^www\.//")
	#(wget --quiet -P "$subpasta" -nd -r -l 1 -H -D $dominio -A $ext "$u" 2>&1 | yad --title "$titulo" --progress --wrap --width=400 --auto-close --auto-kill --window-icon=$icone --button="gtk-close:0" --image=gnome-shutdown --text "Baixando todos os arquivos com a extensão $ext de $u")
	#(wget -P "$pasta" -nd -r -l 1 -H -D $dominio -A $ext "$u" 2>&1 | sed -u 's/.*\ \([0-9]\+%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/' | yad --title "IMGdown" --progress --wrap --width=350 --auto-close --window-icon=gnome-shutdown --button="gtk-close:0" --image=gnome-shutdown --text "Baixando todos os arquivos com a extensão $ext de $u")
	wget --quiet -P "$subpasta" -nd -r -l 1 -H -D $dominio -A $ext "$u"
done

for a in $subpasta/*.$ext; do
	if [[ $(convert $a -print "%h" /dev/null) -lt $min ]]; then
		mv $a $lixeira
	fi
done

rm -rf $subpasta/robots.txt*

