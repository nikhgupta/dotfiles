#!/usr/bin/env bash
#
# id3.sh: Um script para ajustar a tag id3 de várias músicas ao mesmo tempo
# com base no nome do arquivo.
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em:           16/09/2017 12:37:00 AMT
# Última alteração em: 16/05/2018 17:06:40 
#
# Uso: id3.sh /caminho/para/as/mp3s

which id3 1> /dev/null 2> /dev/null
if [ $? != 0 ]; then
	echo "O aplicativo id3 não foi encontrado. Abortando..."
    exit 1
fi

extensao="mp3"
if [ -d "$1" ]; then
	dir="$1"
else
	dir="$(pwd)"
fi

ls $dir/*.${extensao} 1> /dev/null 2> /dev/null
if [ $? != 0 ]; then
    echo -en "[*] Nenhum arquivo com a extensão: $extensao foi encontrado em ${dir}.\nAbortando..."
    exit 1
fi

echo "Tem certeja que deseja alterar todas as tags id3 dos arquivos em ${dir}? [s/N]"
read resposta

if [[ "$resposta" != [Ss]* ]]; then
	echo -e "[\033[31m!\e[0m] Programa abortado pelo usuário..."
	exit 1
fi

for arquivo in ${dir}/*.${extensao}; do
	nome=$(basename -s .${extensao} "$arquivo")
	artista=$(echo "$nome" | awk -F'-' '{print $1}' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
	faixa=$(echo "$nome" | awk -F'-' '{$1=""; print}' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
	echo 
	echo "------------------------------------------------------"
	echo -e "Gravando a id3 de \033[31m${arquivo}\e[0m..."
	echo -e "Artista: $artista"
	echo -e "Faixa: $faixa"
	echo "------------------------------------------------------"

	if [ "$faixa" ]; then
		id3 -t "$faixa" "$arquivo"
	else
		echo "[[\033[31m!\e[0m]] Impossível determinar título de: \033[31m${arquivo}\e[0m."
	fi

	if [ "$artista" ]; then
		id3 -a "$artista" "$arquivo"
	else
		echo "[\033[31m!\e[0m] Impossível determinar artista de: \033[31m${arquivo}\e[0m."
	fi	
done
