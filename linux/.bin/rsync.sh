#!/bin/sh

ORIGEM="/var/www/clients/client0/"
DEST="/var/backup/www"
MAQUINA="$(hostname)"
ANO="$(date +"%Y")"
MES="$(date +"%m")"
DIA="$(date +"%d")"

DESTINO="$DEST/$MAQUINA/$ANO/$MES/$DIA/"

rsync -av $ORIGEM $DESTINO