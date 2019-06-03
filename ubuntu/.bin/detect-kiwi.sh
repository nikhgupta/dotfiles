#!/bin/bash
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>

APP="kiwi"
DIR="/usr/local/kiwiirc"
COMM="./kiwi start"

if [ $(pgrep -c $APP) -gt 1 ];
then
	exit 0
else
	cd $DIR
    $COMM
fi
