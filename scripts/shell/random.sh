#!/usr/bin/env bash

modelist=( numbers lowers uppers symbols md5 string alphanum all )

[ "$1" == "--describe" ] && 
	echo "Generates random string, written in Shell" && 
	exit 1
[ "$1" == "--usage" ] && 
	echo "1) ./random.sh # generates a random md5 type string" && 
	echo "2) ./random.sh LENGTH # generates a random md5 type string of length: LENGTH" && 
	echo "3) ./random.sh LENGTH MODE # generates a random string of length: LENGTH in mode: MODE" && 
	exit 1
[ "$1" == "list" ] && 
	echo ${modelist[*]} | tr ' ' '\n' && 
	exit 1

if [ "$1" -eq "$1" ] > /dev/null 2>&1; then arg1="${1:-32}"; arg2="${2:-md5}"; else arg2="${1:-md5}"; arg1="32"; fi
if ! echo ${modelist[*]} | grep -w $arg2 > /dev/null; then arg2="md5"; fi
	
numbers="0-9"
lowers="a-z" 
uppers="A-Z" 
symbols='~`!@#&%^*()_+\=,.<>/?:$[]{}|-'
md5='a-f0-9'
string="${lowers}${uppers}"
alphanum="${string}${numbers}"
all="${alphanum}${symbols}"

mode=`eval echo '${'"$arg2"'}'`

cat /dev/urandom | env LC_ALL=C tr -cd "${mode}" | head -c${arg1} && echo