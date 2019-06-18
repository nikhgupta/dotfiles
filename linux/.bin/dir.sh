#!/usr/bin/env bash

dia=$(date +'%d')
mes=$(date +'%m')
ano=$(date +'%Y')
dir="${ano}/${mes}/${dia}/"

if [ "$1" == "-d" ]; then
	[ $2 ] && [ "$2" != "" ] && dir="${2}/${dir}"
	[ ! -d $dir ] && mkdir -p $dir
	[ $3 ] && mv \'$3\' $dir
fi

echo $2 > ~/desk/erro.txt
echo $3 >> ~/desk/erro.txt
