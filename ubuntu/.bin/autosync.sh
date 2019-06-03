#!/bin/sh

SESSAO="radiomix"
LOCAL="/home/lucas/audio/"
REMOTO="radiomix@radiomix:/home/radiomix/musicas/"

if [ "$1" == "-a" ]; then
	tmux attach -t $SESSAO
elif [ "$1" == "-n" ]; then 
	tmux new-session -d -s $SESSAO "rsync --exclude-from=${HOME}/.rsync -avz ${LOCAL} ${REMOTO}"
else
	rsync --exclude-from=${HOME}/.rsync -avz ${LOCAL} ${REMOTO}
fi
