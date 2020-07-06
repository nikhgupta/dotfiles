#!/usr/bin/env bash

oldpwd="$(pwd)"

if [ $1 ]; then
	cd "$1"
fi

DISPLAY=:0.0 ; viewnior $(find . -iname '*.jpg')

cd "$oldpwd"
