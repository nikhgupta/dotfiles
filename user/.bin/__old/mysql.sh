#!/bin/bash
# Shell script to backup MySql database
# To backup Nysql databases file to /backup dir and later pick up by your
# script. You can skip few databases from backup too.
# For more info please see (Installation info):
# http://www.cyberciti.biz/nixcraft/vivek/blogger/2005/01/mysql-backup-script.html
# Last updated: Aug - 2005
# --------------------------------------------------------------------
# This is a free shell script under GNU GPL version 2.0 or above
# Copyright (C) 2004, 2005 nixCraft project
# Feedback/comment/suggestions : http://cyberciti.biz/fb/
# -------------------------------------------------------------------------
# This script is part of nixCraft shell script collection (NSSC)
# Visit http://bash.cyberciti.biz/ for more information.
# -------------------------------------------------------------------------

USUARIO="root" # USERNAME
SENHA="SENHA" # PASSWORD
MAQUINA="$(hostname)"

# Linux bin paths, change this if it can not be autodetected via which command
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
CHOWN="$(which chown)"
CHMOD="$(which chmod)"
GZIP="$(which gzip)"

# Backup Dest directory, change this if you have someother location
DEST="/var/backup/mysql"

# Get data in dd-mm-yyyy format
#DATA="$(date +"%d%m%y")"
ANO="$(date +"%Y")"
MES="$(date +"%m")"
DIA="$(date +"%d")"

# Main directory where backup will be stored
MBD="$DEST/$MAQUINA/$ANO/$MES/$DIA"

# File to store current backup file
FILE=""
# Store list of databases
DBS=""

# DO NOT BACKUP these databases
IGGY="test mysql information_schema"

[ ! -d $MBD ] && mkdir -p $MBD || :

# Only root can access it!
#$CHOWN 0.0 -R $DEST
#$CHMOD 0600 $DEST

# Get all database list first
DBS="$($MYSQL -u$USUARIO -h$MAQUINA -p$SENHA -Bse 'show databases')"

for db in $DBS
do
	skipdb=-1
	if [ "$IGGY" != "" ];
	then
		for i in $IGGY
		do
			[ "$db" == "$i" ] && skipdb=1 || :
		done
	fi

	if [ "$skipdb" == "-1" ] ; then
		FILE="$MBD/$db.gz"
		# do all inone job in pipe,
		# connect to mysql using mysqldump for select mysql database
		# and pipe it out to gz file in backup dir :)
		$MYSQLDUMP -u $USUARIO -h $MAQUINA -p$SENHA $db | $GZIP -9 > $FILE
	fi
done
