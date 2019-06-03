#!/bin/sh
PATH=/usr/local/bin:$PATH

pgrep $1 > /dev/null
if [ $? -eq 1 ]; then
	$1 &> /dev/null &
fi
