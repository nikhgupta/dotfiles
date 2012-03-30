#!/usr/bin/env bash

[ "$1" == "--describe" ] && 
	echo "Installs a CakePHP application in ~/Sites/cake, written in Shell" && 
	exit 1
[ "$1" == "--usage" ] && 
	echo "1) ./getCakePHP.sh <APPNAME> <TEMPLATE> <THEME> <VERSION> # installs CakePHP" && 
	exit 1
[ -z "$1" ] && 
	echo "You must provide a name for the application" && 
	exit 1
[ -d "$HOME/Sites/cake/$1" -o -f "$HOME/Sites/cake/$1" ] && 
	echo "A file already exists at this place. Please, provide a different name for your application" && 
	exit 1
# ensure version and skeletons exist
	
CURRENT="`pwd`"

appname="$1"
skel="${2:-master}"
vers="${4:-2.1.0}"

sourcedir="$HOME/Sites/cake/__github"
destindir="$HOME/Sites/cake/$1"
skeletdir="$HOME/Sites/cake/__skels"
CKCONSOLE="${destindir}/lib/Cake/Console/cake"

function get_correct_version() {
	echo -ne "CAKEPHP VERSION: " && cd "${sourcedir}" && git checkout "${vers}" 2>&1 | tail -n 1 &&
	cp -r . "${destindir}" && 
	git checkout master &>/dev/null && cd "${CURRENT}"
}

function remove_conflicting_source_files() {
	rm -rf "${destindir}/.git" && 
	rm -rf "${destindir}/app"
}

function bake_project_template() {
	echo -ne "APPLICATION TYPE: ${skel} | " && 
	cd "${skeletdir}/templates" && git checkout "${skel}" && 
	cd "${destindir}" && 
	"${CKCONSOLE}" bake project --empty --skel "${skeletdir}/templates" "${destindir}/app" && 
	cd "${CURRENT}"
}

function make_htaccess_changes() {
	sed -i -e 's/^\(.*\)RewriteEngine.*[o|O]n.*$/\1RewriteEngine On\
\1RewriteBase \//g' "${destindir}/.htaccess"
}

function add_database_to_application() {
	dbfile="${destindir}/app/Config/database.php"
	source $HOME/.dotfiles/bash/functions/others/mysql_db makedb "cake_$appname"
	source $HOME/.dotfiles/bash/functions/others/mysql_db makedb "test_cake_$appname"
	# cp "${dbfile}.default" "${dbfile}"
	sed -e "s/'localhost'/'127.0.0.1'/g" -e "s/'user'/'root'/g" -e "s/database_name'/cake_${appname}'/g" < "${dbfile}.default" > "${dbfile}"
}

function initialize_git_repository() {
	cd "${destindir}/app" &&
	cp "${skeletdir}/cakeignore" .gitignore &&
	git init && git add . && git commit -aqm "Intial Commit. Checked Out CakePHP Source." && 
	sudo chmod -R 777 tmp && 
	cd "${CURRENT}"
}

function install_git_submodules() {
	cd "${destindir}/app" && 
	git submodule init && 
  git submodule foreach git pull origin master &&
  git submodule update && 
	cd "${CURRENT}"
}

get_correct_version && 
remove_conflicting_source_files && 
bake_project_template && 
make_htaccess_changes && 
add_database_to_application && 
initialize_git_repository &&
install_git_submodules &&
echo "Done"
