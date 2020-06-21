#!/bin/bash

declare -A diretorios

diretorios[Desktop]=desk
diretorios[Documentos]=docs
diretorios[Downloads]=down
diretorios[Imagens]=img
diretorios[Modelos]=modelos
diretorios[Música]=musica
diretorios[Público]=publico
diretorios[Vídeos]=video

for c in "${!diretorios[@]}"; do
    #printf "%s is in %s\n" "$c" "${diretorios[$c]}"

	#echo "Renomeando $c para ${diretorios[$c]}"

	if [ -d "$c" ]; then
		echo "Renomeando $c para ${diretorios[$c]}"
		mv ~/${c} ~/${diretorios[$c]}
	else
		echo "Criando o diretório ~/${diretorios[$c]}"
		mkdir ~/${diretorios[$c]}
	fi
done
