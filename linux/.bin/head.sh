#!/usr/bin/env bash
#
# Arquivo: head.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 31-03-2018 17:42:36
# Última alteração: 31-03-2018 18:15:56

volume=${1:-40} # 0-128
arquivo="/tmp/.headsetvol"
comando="headsetcontrol -s"

if [ ! -f $arquivo ]; then
	echo $volume > $arquivo
fi

antigo=$(cat $arquivo)

if [ $volume = 40 ]; then
	if [ $antigo = 40 ]; then
		volume=0
	fi
fi

if [[ "$EUID" = 0 ]]; then
    $comando $volume > /dev/null 2>&1
else
    if sudo true; then
       sudo $comando $volume > /dev/null 2>&1
    else
        echo "Senha inválida"
    fi
fi

echo $volume > $arquivo

exit 0
