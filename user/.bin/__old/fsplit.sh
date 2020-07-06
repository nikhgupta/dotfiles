#!/bin/bash
 
# Written by Alexis Bezverkhyy <alexis@grapsus.net> in 2011
# This is free and unencumbered software released into the public domain.
# For more information, please refer to <http://unlicense.org/>
#
# Changes made by Lucas Saliés Brum, aka sistematico, <lucas@archlinux.com.br>
 
function uso {
    echo "Uso : ffsplit.sh arquivo.mp4 [offset] [duração]"
    echo -e "\t - arquivo pode ser qualquer tipo de arquivo reconhecido pelo ffmpeg"
    echo -e "\t - a duração deve ser em segundos"
    echo -e "\t - o parâmetro offset é opcional"
}
 
ENTRADA="$1"
#typeset -i TAMANHO
TAMANHO="$2"
 
HORAMS=$(ffprobe "$ENTRADA" -sexagesimal -show_format 2>&1 | sed -n 's/duration=//p')
HORA=$(echo "$HORAMS" | cut -d ':' -f 1 | sed 's/^0*//')
MINUTO=$(echo "$HORAMS" | cut -d ':' -f 2 | sed 's/^0*//')
SEGUNDO=$(echo "$HORAMS" | cut -d ':' -f 3 | cut -d '.' -f 1 | sed 's/^0*//')


let "DURACAO=( HORA * 60 + MINUTO ) * 60 + SEGUNDO"

if [ "$DURACAO" = '0' ] ; then
        echo "Vídeo inválido."
        echo
        uso
        exit 1
fi
 
if [ "$TAMANHO" = "0" ] ; then
        echo "Intervalo inválido."
        echo
        uso
        exit 2
fi
 
FILE_EXT=$(echo "$ENTRADA" | sed 's/^.*\.\([a-zA-Z0-9]\+\)$/\1/')
FILE_NAME=$(echo "$ENTRADA" | sed 's/^\(.*\)\.[a-zA-Z0-9]\+$/\1/')
NOVO_FORMAT="${FILE_NAME}-%03d.${FILE_EXT}"
echo "Usando o formato: $NOVO_FORMAT"
 
N='1'
OFFSET='0'

let 'N_FILES = DURACAO / TAMANHO + 1'
 
while [ "$OFFSET" -lt "$DURACAO" ] ; do
        NOVO=$(printf "$NOVO_FORMAT" "$N")
        echo "escrevendo $NOVO ($N/$N_FILES)..."
        ffmpeg -v quiet -i "$ENTRADA" -vcodec copy -acodec copy -ss "$OFFSET" -t "$TAMANHO" "$NOVO"
        let "N = N + 1"
        let "OFFSET = OFFSET + TAMANHO"
done
