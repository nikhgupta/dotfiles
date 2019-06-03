#!/bin/sh

volume="/media/dados"
device="/dev/disk/by-label/dados"

if mount | grep $volume 1> /dev/null; then
	#echo "montado"
	exit 0
else
	#echo "não montado"
	if [ -b $device ]; then
		udisksctl mount -b /dev/disk/by-label/dados
	else 
		#echo "$device não é um dispositivo"
		exit 0
	fi
			
fi
