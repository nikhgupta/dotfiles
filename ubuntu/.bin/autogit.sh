#!/bin/bash

ARQUIVO="$(pwd)/.git/config"

if [ ! -f $ARQUIVO ]; then
	echo "O arquivo $ARQUIVO não existe, abortando..."
	exit
fi

ANTIGO='https://github.com/'
NOVO='git@github.com:'
EXP=$(fgrep -A1 '[remote "origin"]' $ARQUIVO | tail -n1)

if [[ $EXP = *$ANTIGO* ]]; then
    sed -ire "s|${ANTIGO}|${NOVO}|" $ARQUIVO
fi

git add .
git commit
git push origin master
