#!/bin/sh
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>

pgrep -f red5 > /dev/null
if [ $? -eq 1 ]; then
	#/etc/init.d/red5 restart
	cd /usr/local/red5
	./red5.sh &
	disown
	exit 0
fi
