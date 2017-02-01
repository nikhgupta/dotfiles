#!/usr/bin/env bash
# Utility script to be sourced into config files

ESCAPE=$'\e'

txtblk="${ESCAPE}[0;30m" # Black - Regular
txtred="${ESCAPE}[0;31m" # Red
txtgrn="${ESCAPE}[0;32m" # Green
txtylw="${ESCAPE}[0;33m" # Yellow
txtblu="${ESCAPE}[0;34m" # Blue
txtpur="${ESCAPE}[0;35m" # Purple
txtcyn="${ESCAPE}[0;36m" # Cyan
txtwht="${ESCAPE}[0;37m" # White
bldblk="${ESCAPE}[1;30m" # Black - Bold
bldred="${ESCAPE}[1;31m" # Red
bldgrn="${ESCAPE}[1;32m" # Green
bldylw="${ESCAPE}[1;33m" # Yellow
bldblu="${ESCAPE}[1;34m" # Blue
bldpur="${ESCAPE}[1;35m" # Purple
bldcyn="${ESCAPE}[1;36m" # Cyan
bldwht="${ESCAPE}[1;37m" # White
unkblk="${ESCAPE}[4;30m" # Black - Underline
undred="${ESCAPE}[4;31m" # Red
undgrn="${ESCAPE}[4;32m" # Green
undylw="${ESCAPE}[4;33m" # Yellow
undblu="${ESCAPE}[4;34m" # Blue
undpur="${ESCAPE}[4;35m" # Purple
undcyn="${ESCAPE}[4;36m" # Cyan
undwht="${ESCAPE}[4;37m" # White
bakblk="${ESCAPE}[40m"   # Black - Background
bakred="${ESCAPE}[41m"   # Red
bakgrn="${ESCAPE}[42m"   # Green
bakylw="${ESCAPE}[43m"   # Yellow
bakblu="${ESCAPE}[44m"   # Blue
bakpur="${ESCAPE}[45m"   # Purple
bakcyn="${ESCAPE}[46m"   # Cyan
bakwht="${ESCAPE}[47m"   # White
txtrst="${ESCAPE}[0m"    # Text Reset

is_macosx()    { [[ "$OSTYPE" = darwin* ]]; }
is_ubuntu()    { [[ "$(uname -a)" = *Ubuntu* ]]; }
is_debian()    { [[ -f "/etc/debian" ]]; }
is_svn()       { [[ -d '.svn' ]]; }
is_hg()        { [[ -d '.hg'  ]] || command hg root &>/dev/null; }
is_git()       { [[ -d '.git' ]] || \ command git rev-parse --git-dir &>/dev/null || \ command git symbolic-ref HEAD &>/dev/null; }
is_emacs()     { echo $TERMINFO | grep -o emacs >/dev/null; }
is_installed() { which "$1" &>/dev/null; }

path_append()      { [[ -d "$1" ]] && setenv PATH "$PATH:$1"; }
path_prepend()     { [[ -d "$1" ]] && setenv PATH "$1:$PATH"; }
source_if_exists() { [[ -s "$1" ]] && source "$1"; }

browse()   { eval "${BROWSER} ${@}"}

warn()     { echo "${undylw}Warning${txtrst}: $@"; }
error()    { echo "${undred}Error${txtrst}: $@"; exit 1; }
action()   { echo "${txtpur}ACTION${txtrst}: $@"; }
highlight(){ echo -ne "\n👉  ${txtblu}$@${txtrst}\n"; }

setenv(){
  export $1=$2 && [[ -z $ZSH_NAME ]] && is_macosx &&
    [[ -z "${TMUX}" ]] && launchctl setenv $1 "$2"
}

init_cache(){
  file_name=$HOME/.init-cache/$1
  if [[ -f $file_name ]]; then
    source $file_name
  else
    mkdir -p $HOME/.init-cache
    eval "$(echo $2)" > $file_name
    source $file_name
  fi
}
