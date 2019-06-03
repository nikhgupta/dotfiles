#!/usr/bin/env bash
#
# syncmon.sh - Um programa para sincronizar automáticamente arquivos alterados em alguma pasta
# usando o rsync e inotifywait.
# 
# Criador por Lucas Saliés Brum a.k.a. sistematico, <lucas at archlinux dot com dot br>
#
# Criado em: 15/03/2018 18:15:04
# Última alteração: 23-03-2018 15:13:58

RSYNC=$(which rsync)
command -v inotifywait >/dev/null 2>&1 || { echo >&2 "O aplicativo inotifywait não está instalado. Abortando."; exit 1; }

if [ $2 ]; then
 	[ -d $1 ] || { echo >&2 "$1 não é uma pasta. Abortando."; exit 1; }
	origem=$1
	destino=$2
	tam=${#origem}
	ult=${origem:tam-1:1}
	[[ $ult != "/" ]] && origem="$origem/"; :

	while true; do
		inotifywait -q -e modify,create,delete -r $origem && $RSYNC -avz $origem $destino && echo "Arquivo alterado..."
	done
else
	echo "Uso: $(basename $0) /pasta/local/ usuario@host:/pasta/remota/"
fi
