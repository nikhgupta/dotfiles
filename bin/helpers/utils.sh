#!/usr/bin/env bash

function is_macosx() { [[ "$OSTYPE" = darwin* ]]; }
function is_ubuntu() { [[ "$(uname -a)" = *Ubuntu* ]]; }

function is_svn(){ [[ -d '.svn' ]]; }
function is_hg() { [[ -d '.hg'  ]] || command hg root &>/dev/null; }
function is_git(){ [[ -d '.git' ]] || \ command git rev-parse --git-dir &>/dev/null || \ command git symbolic-ref HEAD &>/dev/null; }
function is_emacs(){ echo $TERMINFO | grep -o emacs >/dev/null; }
function is_atom(){ echo $TERMINFO | grep -o atom >/dev/null; }

function is_installed() { which "$1" &>/dev/null; }

function setenv(){ export $1=$2 && [[ -z $ZSH_NAME ]] && is_macosx && [[ -z "${TMUX}" ]] && launchctl setenv $1 "$2"; }
function path_append()  { [[ -d "$1" ]] && setenv PATH "$PATH:$1"; }
function path_prepend() { [[ -d "$1" ]] && setenv PATH "$1:$PATH"; }
function source_if_exists() { [[ -s "$1" ]] && source "$1"; }

function warn()     { echo "\e[4;33mWarning\e[0m: $@"; }
function error()    { echo "\e[4;31mError\e[0m: $@"; exit 1; }
function action()   { echo "\e[0;35mACTION\e[0m: $@"; }
function highlight(){ echo -ne "\n👉  \e[1;34m$@\e[0m\n"; }
