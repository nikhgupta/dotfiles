#!/bin/bash

saida=$(echo "$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]")

if [ $saida -lt 10 ]; then
	echo "0${saida}"
else
	echo "${saida}"
fi