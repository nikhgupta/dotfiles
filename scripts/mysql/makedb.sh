#!/bin/bash

E_BADARGS=65
MYSQL=`which mysql`

dbname="$1"
dbuser="${2:-root}"
dbpass="${3:-password}"

Q1="CREATE DATABASE IF NOT EXISTS $dbname;"
Q2="GRANT ALL ON $dbname.* TO '$dbuser'@'localhost' IDENTIFIED BY '$dbpass';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"
SUCCESS="Created database: '$dbname', with user: '$dbuser' and password: '$dbpass'"

if [ $# -lt 1 ]; then
  echo "Usage: $0 dbname dbuser dbpass"
  exit $E_BADARGS
fi

if $MYSQL -u$dbuser -p$dbpass -e "$SQL"; then echo "${SUCCESS}"; else echo "SQL Query Failed!"; fi
