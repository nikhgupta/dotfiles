#!/bin/sh

DESTINO="${HOME}/backup"
LOG="${HOME}/log"

[ ! -d $DESTINO ] && mkdir -p $DESTINO || :
[ ! -d $LOG ] && mkdir -p $LOG || :

/usr/bin/rsync -avz root@hera:/var/backup/ ${DESTINO}/

echo >> ${LOG}/backup.log
echo "Backup efetuado em: $(date)" >> ${LOG}/backup.log
echo "------------------------------------------" >> ${LOG}/backup.log
