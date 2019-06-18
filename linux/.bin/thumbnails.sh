#!/bin/bash
# Fonte: https://www.cyberciti.biz/tips/howto-linux-creating-a-image-thumbnails-from-shell-prompt.html

arquivos="$@"

for arquivo in $arquivos; do
	echo "Processando imagem $arquivo ..."
	/usr/bin/convert -thumbnail 200 $arquivo thumb_$arquivo
done
