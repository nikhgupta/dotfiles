#!/usr/bin/env bash

arg1="$1"
[ "$arg1" == "--describe" ] && 
	echo "A simple script that fetches the current external IP address of the system, written in Shell" && 
	exit 1
[ "$arg1" == "--usage" ] && 
	echo "1) ./get_ip.sh # displays current external IP address" && 
	exit 1

curl -s 'http://whatismyip.org' && echo;
