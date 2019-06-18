#!/usr/bin/env sh

processos=$(ps -A | egrep -i "steam|launcher" | awk '{print $1}')

if [ ! $processos ]; then
	echo "Nenhum processo."
else
	for p in $processos; do
		kill -9 $p
	done
fi