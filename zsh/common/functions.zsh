#!/usr/bin/env zsh

# add aliases via command line
function addalias() {
    ALIASED="alias $1='$2';";
    echo "${ALIASED}" | tee -a $ZSH_DIR/common/via_terminal.zsh;
    source $ZSH_DIR/common/via_terminal.zsh;
}

# add private aliases via command line (not stored in the dotfiles repository)
function addprivatealias() {
    ALIASED="alias $1='$2';";
    echo "${ALIASED}" | tee -a $HOME/.localrc.after;
    source ~/.zshrc;
}

# nullify the output of a command
# use like this: nullify command
# function nullify() { $@ >/dev/null 2>&1; }

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

# came across some programmers from the Windows world
# remove those pesky characters and relax our eyes :)
function dir2unix() {
    if which dos2unix; then
        find . -type f -exec dos2unix -k -o {} \;
    else
        echo "dos2unix is not installed on this machine."
    fi
}

# search for a file name in current directory structure
# just an alternative quick shortcut
function find_in_dir() {
    find . -iname "*$1*";
}

# love this one: fortune | cowsay -f $random
tunecow() {
    if which fortune && which cowsay; then
        IFS=' '
        figures=(`cowsay -l | tail -n +2 | tr '\n' ' '`)
        num_figures=${#figures[*]}
        figure=${figures[$((RANDOM%num_figures))]}
        fortune | cowsay -f $figure
        echo "using figure: $figure"
    else
        echo "You must install fortune and cowsay programs."
    fi
}

[[ ! -d ~/Code/docs ]] && mkdir -p ~/Code/docs
addidea()  { echo "- `date`: $@" >> ~/Code/docs/ideas.md; }
addtask()  { echo "- `date`: $@" >> ~/Code/docs/tasks.md; }
addnote()  { echo "- `date`: $@" >> ~/Code/docs/notes.md; }
addstuff() { echo "- `date`: $@" >> ~/Code/docs/stuff.md; }
