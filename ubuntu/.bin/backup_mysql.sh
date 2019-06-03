#!/bin/sh

USUARIO="root"
SENHA=""
BANCO=""
DIR=""

if [ ! -d "$DIR" ]
then
	mkdir -p $DIR
fi

mysqldump -u $USUARIO -p${SENHA} $BANCO > ${DIR}/${BANCO}-$(date +"%y%m%d").sql

