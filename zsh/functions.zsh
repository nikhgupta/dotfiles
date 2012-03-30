#!/usr/bin/env zsh

# add aliases via command line
function addalias() {
  ALIASED="alias $1='$2';";
  echo "${ALIASED}" | tee -a $DOTZSH/via_terminal.zsh;
  source ~/.zshrc;
}

# next three functions are used for padding words in custom shell functions.
function lpad {
    word="$1"
    while [ ${#word} -lt $2 ]; do word="$3$word"; done
    echo -ne "$word";
}
function rpad {
    word="$1"
    while [ ${#word} -lt $2 ]; do word="$word$3";done
    echo -ne "$word";
}
function cpad {
    word="$1"
    while [ ${#word} -lt $2 ]; do word="$word$3"; [ ${#word} -lt $2 ] && word="$3$word"; done
    echo -ne "$word";
}


# search a particular word inside a directory recursively
function dirsearch() {
  find . -type f -exec grep -iHn "$@" {} \; | grep "$@"
}

function filesbysize() {
	if [ -z $1 ]; then size="10240k"; else size="$1"; fi
	if [ -z $2 ]; then dir="$HOME"; else dir="$2"; fi
	find "$dir" -type f -size +$size  -exec ls -lh {} \; | awk '{ print $9 ": " $5 }'
}

function getdomainips() {
	for domain in "$@"; do
		rpad "${domain}" 50 " "; ping -c 1 $domain | grep "PING.*:.*data" | sed -e "s/.*(//g" -e "s/).*//g"
	done
}

function webdisk() {
	mountdir=/home/nikhgupta/workspace/webdisk
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
		mountdir=/home/nikhgupta/workspace/webdisk

		{ fusermount -u ${mountdir}/${domain} && rmdir ${mountdir}/${domain} && { if [ -z "$( ls -A ${mountdir} )" ]; then rmdir $mountdir; fi; } && echo "Unmounted webdisk on: ${mountdir}/${domain}"; } || echo "Could not unmount webdisk!"
	fi
}
