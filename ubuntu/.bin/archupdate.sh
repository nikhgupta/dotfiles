#!/bin/sh

if [ $(ping -q -c3 google.com > /dev/null 2> /dev/null) ]; then
	echo "Conexão: OK"
else
	echo "Conexão: FALHOU"
fi
