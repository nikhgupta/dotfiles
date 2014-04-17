#!/usr/bin/env zsh
#  vim: set ts=2 sw=2 tw=80 et:

# add aliases via command line
function addalias() {
    ALIASED="alias $1='$2';";
    echo "${ALIASED}" | tee -a $DOTZSH/via_terminal.zsh;
    source $DOTZSH/via_terminal.zsh;
}

# add private aliases via command line (not stored in the dotfiles repository)
function addprivatealias() {
    ALIASED="alias $1='$2';";
    echo "${ALIASED}" | tee -a $HOME/.localrc.after;
    source ~/.zshrc;
}

# nullify the output of a command
# use like this: nullify command
function nullify() { $@ >/dev/null 2>&1; }

# next three functions are used for padding words in custom shell functions.
function lpad { word="$1"; while [ ${#word} -lt $2 ]; do word="$3$word"; done; echo -ne "$word"; }
function rpad { word="$1"; while [ ${#word} -lt $2 ]; do word="$word$3"; done; echo -ne "$word"; }
function cpad { word="$1"; while [ ${#word} -lt $2 ]; do word="$word$3"; [ ${#word} -lt $2 ] && word="$3$word"; done; echo -ne "$word"; }

# search a particular word inside a directory recursively
function dirsearch() { grep -inrHF "$@" .;  }
function dirsearch_re() { grep -inrHE "$@" .;  }

# find all files in a given directory (or current) bigger than a specified size (default: 10MB)
function filesbysize() {
    if [ -z $1 ]; then size="10240k"; else size="$1"; fi
    if [ -z $2 ]; then dir="."; else dir="$2"; fi
    find "$dir" -type f -size +$size  -exec ls -lh {} \; | awk '{ print $9 ": " $5 }'
}

# find the ip address of a given domain name (uses `rpad` function above.)
function get_domain_ip() {
    for domain in "$@"; do
        rpad "${domain}" 50 " "; ping -c 1 $domain | grep "PING.*:.*data" | sed -e "s/.*(//g" -e "s/).*//g"
    done
}

# display list of directories with maximum size in current directory (passing -5 will limit to 5 results)
function dsize() {
    du -kd1 | sort -nr | awk '
        function human(x) {
        s="kMGTEPYZ";
        while (x>=1000 && length(s)>1)
            {x/=1024; s=substr(s,2)}
            return int(x+0.5) substr(s,1,1)
        }
        {gsub(/^[0-9]+/, human($1)); print}' | head $1
}

# functions for todo.txt-cli
function tn() { eval "$T append $1 @next"; } # add the given task into @next list

# came across some programmers from the Windows world
# remove those pesky characters and relax our eyes :)
function dir2unix() {
    find . -type f -exec dos2unix -k -o {} \;
}

# search for a file name in current directory structure
# just an alternative quick shortcut
function find_in_dir() {
    find . -iname "*$1*";
}

# open a new tab for current directory in iTerm, and tell it to run a command
function newtab() {
    text=" cd `pwd`; clear; $@"
    script="tell application \"iTerm\"
            make new terminal
            tell the current terminal
            activate current session
            launch session \"Default Session\"
            tell the last session
            write text \"${text}\"
            end tell
            end tell
            end tell"

    osascript -e $script
}
alias nt=newtab

# Universal Extractor
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)        tar xjf $1        ;;
            *.tar.gz)         tar xzf $1        ;;
            *.bz2)            bunzip2 $1        ;;
            *.rar)            unrar x $1        ;;
            *.gz)             gunzip $1         ;;
            *.tar)            tar xf $1         ;;
            *.tbz2)           tar xjf $1        ;;
            *.tgz)            tar xzf $1        ;;
            *.zip)            unzip $1          ;;
            *.Z)              uncompress $1     ;;
            *)                echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# NOTE: using scripter gem
# blogging helpers
# blogpost() {
#     title="$@"
#     if [ -z "$title" ]; then
#         echo "You must supply a file title!"
#     else
#         # switch to website directory
#         cd ~/Code/sites/nikhgupta.com
#         # create and edit the post
#         file=$(be rake "new_post[$title]" 2>/dev/null | tail -1 | cut -d ' ' -f 4)
#         echo "Created file: $file"
#         edit $file
#         # restore directory
#         cd -
#     fi
# }

# love this one: fortune | cowsay -f $random
tunecow() {
    IFS=' '
    figures=(`cowsay -l | tail -n +2 | tr '\n' ' '`)
    num_figures=${#figures[*]}
    figure=${figures[$((RANDOM%num_figures))]}
    fortune | cowsay -f $figure
    echo "using figure: $figure"
}

addidea() { echo "- `date`: $@" >> ~/Code/docs/ideas.md; }
addtask() { echo "- `date`: $@" >> ~/Code/docs/tasks.md; }
addnote() { echo "- `date`: $@" >> ~/Code/docs/notes.md; }
addstuff() { echo "- `date`: $@" >> ~/Code/docs/stuff.md;}

# NOTE: using scripter gem for this.
expose() {
    website=$1
    subdomain=$2
    username=$3
    password=$4
    [ -n $website ] || (echo "I need a local website to tunnel to." && exit)
    [ -n $subdomain ] && subdomain="--subdomain=${subdomain}"
    if [[ -n $username  ]] && [[ -n $password ]]; then
        httpauth="-httpauth=${username}:${password}"
    else
        echo "Not using secure tunnel since auth params were not provided."
    fi
    /Users/nikhgupta/Code/scripter/vendor/ngrok $subdomain $httpauth $website
}
expose-pow() { expose $1.pow:88 $1 $2 $3; }
expose-apache() { expose $1:80 $1 $2 $3; }
expose-dev() { expose $1.dev:88 $1 $2 $3; }
expose-lab() { expose $1.lab:80 $1.lab $2 $3; }

# Get the current idle time for this machine.
# O'course, running it from command line will always produce a number around 0.
# To test this script, add a sleep duration before this command.
idletime() {
    echo `ioreg -c IOHIDSystem | 
    awk '/HIDIdleTime/ {print $NF/1000000000; exit}'`
}
