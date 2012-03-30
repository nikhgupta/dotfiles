#!/usr/bin/env zsh
#
# Aliases for some of these scripts
#

function scriptalias() {
  use="${3:-bash}"
  [[ -s "$DOTSCRIPTS/$2" ]] && eval "alias $1='$use $DOTSCRIPTS/$2'"
}

# mysql
scriptalias makemysqldb "mysql/makedb.sh" # makemysqldb <dbname> <dbuser|root> <dbpass|password>
scriptalias dropmysqldb "mysql/dropdb.sh" # dropmysqldb <dbname> <dbuser|root> <dbpass|password>

# shell
scriptalias randomize "shell/random.sh"
scriptalias getCake   "shell/getCakePHP.sh"


