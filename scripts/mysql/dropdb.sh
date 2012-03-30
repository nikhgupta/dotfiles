#!/bin/bash

E_BADARGS=65
MYSQL=`which mysql`

dbname="$1"
dbuser="${2:-root}"
dbpass="${3:-password}"

Q1="DROP DATABASE $1;"
SQL="${Q1}"
SUCCESS="Dropped database: '$1'"

if [ $# -lt 1 ]; then
  echo "Usage: $0 dbname dbuser dbpass"
  exit $E_BADARGS
fi

if $MYSQL -u$dbuser -p$dbpass -e "$SQL"; then echo "${SUCCESS}"; else echo "SQL Query Failed!"; fi
