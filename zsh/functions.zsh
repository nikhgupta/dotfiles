#!/usr/bin/env zsh

# add aliases via command line
function addalias() {
ALIASED="alias $1='$2';";
echo "${ALIASED}" | tee -a $DOTZSH/via_terminal.zsh;
source ~/.zshrc;
}

# add private aliases via command line (not stored in the dotfiles repository)
function addprivatealias() {
ALIASED="alias $1='$2';";
echo "${ALIASED}" | tee -a $HOME/.localrc.after;
source ~/.zshrc;
}

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

# TODO: needs improvement
function webdisk() {
mountdir=/home/nikhgupta/code/webdisk
if [ -z "$( which sshfs )" ]; then
  echo -e "Required package missing. Installing...\n"
  sudo apt-get install sshfs
  echo -e "\n\n"
fi
if [ "$1" == "help" ]; then
  echo "Purpose: Mount a Remote Directory using SSH"
  echo "Usage: $FUNCNAME username@hostname port remotepath mountpoint"
  echo "Example: $FUNCNAME nikhgup@nikhgupta.com 2222 public_html /home/nikhgupta/workspace/webdisk/nikhgupta.com"
  echo "Note: all arguments are optional, in which case function will run as above example"
else

  host="$1"; port="$2"; dir="$3";
  if [ -z $host ]; then host='nikhgup@nikhgupta.com'; fi
  if [ -z $port ]; then port=2222; fi

  domain=`echo $host | sed -e "s/.*@//" -e "s/ .*//"`

  { mkdir -p ${mountdir}/${domain} && sshfs -p $port $host:$dir ${mountdir}/${domain} && echo "Mounted on: ${mountdir}/${domain}"; } || { rmdir ${mountdir}/${domain} && echo "Could not mount remote directory!!"; }
fi
}

# TODO: needs improvement
function unwebdisk() {
if [ "$1" == "help" ]; then
  echo "Purpose: Unmount a remote directory that wass mounted using 'webdisk' function"
  echo "Usage: $FUNCNAME username@hostname OR $FUNCNAME domainname"
  echo "Example: $FUNCNAME nikhgupta.com"
  echo "Note: All arguments are optional, in which case function will run as the example above"
else
  host="$1";
  if [ -z $host ]; then host='nikhgupta.com'; fi
  domain=`echo $host | sed -e "s/.*@//" -e "s/ .*//"`
  mountdir=/home/nikhgupta/code/webdisk

  { fusermount -u ${mountdir}/${domain} && rmdir ${mountdir}/${domain} && { if [ -z "$( ls -A ${mountdir} )" ]; then rmdir $mountdir; fi; } && echo "Unmounted webdisk on: ${mountdir}/${domain}"; } || echo "Could not unmount webdisk!"
  fi
}

# TODO: needs improvement
function sublpro() {
project="${1}"
if [ -z "${project}" ]; then
  echo "You must provide the name for the project!";
elif [ ! -r "${HOME}/Code/projects/${project}.sublime-project" ]; then
  echo "I could not find the specified project in: ~/Code/projects";
else
  subl --project "${HOME}/Code/projects/${project}.sublime-project"
fi
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

# support for laravel's artisan
function artisan() {
if [ -s artisan ]; then
  php artisan $@
else
  echo "I'm sorry, but is this a laravel app?? O_o"
fi
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

# Video Downloads
function ydl() {
  download_dir="${HOME}/Downloads/Videos/Scripted"
  list_file="${HOME}/Code/scripts/downloads/videos.list"
  opts="-ikwco '${download_dir}/%(extractor)s/%(title)s/%(title)s-%(id)s.%(ext)s' --sub-lang en --no-post-overwrites"
  opts="${opts} --restrict-filenames --write-info-json --all-subs"
  if [ -z $1 ]; then opts="${opts} -a ${list_file}"; else opts="${opts} $1"; fi
  echo "youtube-dl $opts"
  echo "================"
  eval youtube-dl $opts
}
