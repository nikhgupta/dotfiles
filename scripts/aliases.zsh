#!/usr/bin/env zsh
#
# Aliases for some of these scripts
#

# mysql
alias makesqldb="bash $DOTSCRIPTS/mysql/makedb.sh" # makemysqldb <dbname> <dbuser|root> <dbpass|password>
alias dropsqldb="bash $DOTSCRIPTS/mysql/dropdb.sh" # dropmysqldb <dbname> <dbuser|root> <dbpass|password>

# shell
alias randomize="bash $DOTSCRIPTS/shell/random.sh"
alias get_my_ip="bash $DOTSCRIPTS/shell/get_ip.sh"

# php
alias getCake="bash $DOTSCRIPTS/php/getCakePHP.sh"
alias ctagphp="bash $DOTSCRIPTS/php/ctags.sh"      # ctagphp <tagfilename> 
