#!/usr/bin/env zsh

# find the ip address of a given domain name (uses `rpad` function above.)
get_domain_ip() {
    for domain in "$@"; do
        rpad "${domain}" 50 " "; ping -c 1 $domain | grep "PING.*:.*data" | sed -e "s/.*(//g" -e "s/).*//g"
    done
}

# open a new tab for current directory in iTerm, and tell it to run a command
newtab() {
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

gen_ssl() {
    if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
        echo "Usage: gen_wildcard_ssl <domain.com> <common_name> <single/wildcard>"
    elif [ -d /private/etc/apache2/ssl/$1/$3.cert ]; then
        echo "Path: /private/etc/apache2/ssl/$1/$3.cert already exists."
    else
        mkdir /tmp/sslcert
        pushd /tmp/sslcert
        (umask 077 && touch $3.key $3.cert $3.info $3.pem)
        openssl genrsa 2048 > $3.key
        openssl req -new -x509 -nodes -sha1 -days 3650 -key $3.key \
          -subj "/C=IN/ST=Rajasthan/L=Jaipur/O=Wicked Developers/OU=IT/CN=$2" > $3.cert
        openssl x509 -noout -fingerprint -text < $3.cert > $3.info
        cat $3.cert $3.key > $3.pem
        chmod 400 $3.key $3.pem

        sudo mkdir /private/etc/apache2/ssl/$1 2>/dev/null
        sudo mv $3.key $3.pem $3.cert $3.info /private/etc/apache2/ssl/$1
        popd
        rm -rf /tmp/sslcert

        echo "\n====="
        echo "Certificate generation completed."
        echo "Created at: /private/etc/apache2/ssl/$1/$3.cert"

        sudo security add-trusted-cert -d -r trustRoot -k \
          "/Library/Keychains/System.keychain" /private/etc/apache2/ssl/$1/$3.cert

        echo "Certificate marked as trusted in OSX Keychain."
    fi
}
gen_single_ssl() { gen_ssl $1 $1 "single"; }
gen_wildcard_ssl() { gen_ssl $1 *.$1 "wildcard"; }

# Get the current idle time for this machine.
# O'course, running it from command line will always produce a number around 0.
# To test this script, add a sleep duration before this command.
idletime() {
    echo `ioreg -c IOHIDSystem | 
    awk '/HIDIdleTime/ {print $NF/1000000000; exit}'`
}
