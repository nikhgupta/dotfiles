#!/usr/bin/env zsh
# Credits:       =================================================== {{{
#
#            _ _    _                       _        _
#           (_) |  | |                     | |      ( )
#      _ __  _| | _| |__   __ _ _   _ _ __ | |_ __ _|/ ___
#     | '_ \| | |/ / '_ \ / _` | | | | '_ \| __/ _` | / __|
#     | | | | |   <| | | | (_| | |_| | |_) | || (_| | \__ \
#     |_| |_|_|_|\_\_| |_|\__, |\__,_| .__/ \__\__,_| |___/
#                          __/ |     | |
#                         |___/      |_|
#                            _       _    __ _ _
#                           | |     | |  / _(_) |
#                         __| | ___ | |_| |_ _| | ___  ___
#                        / _` |/ _ \| __|  _| | |/ _ \/ __|
#                       | (_| | (_) | |_| | | | |  __/\__ \
#                        \__,_|\___/ \__|_| |_|_|\___||___/
#
#
#   Hello, I am Nikhil Gupta, and
#   You can find me at http://nikhgupta.com
#
#   You can find an online version of this file at:
#   https://github.com/nikhgupta/dotfiles/blob/master/zsh/aliases.zsh
#
#   This is the personal zsh configuration of Nikhil Gupta.
#   While much of it is beneficial for general use, I would recommend
#   picking out the parts you want and understand.
#
#   ---
#
#   This file contains common ZSH aliases and functions, and is split
#   into several sections. Do not add private data in this file. Use
#   `~/.zshrc.local` to store private aliases and functions, instead.
#
# ================================================================== }}}

# Aliases:
# => Common aliases that I use {{{
# quickly reload this file
alias reload=" source $HOME/.zshrc"

# create a handy edit command
alias edit="$EDITOR"
alias e=edit

# zsh related aliases
alias zshconfig="edit $HOME/.zshrc"                 # quickly edit zsh configuration
alias zshedit="edit $DOTCASTLE"

# common and most-often used aliases
alias cl=" clear"                                   # NOTE: use CTRL-K instead.

# common commands
alias rm="rm -i"                                    # failsafe :P (although, ZSH already does this)

# chmod
alias w+="sudo chmod +w"                            # quickly make a file writeable
alias w-="sudo chmod -w"                            # quickly make a file un-writeable
alias x+="sudo chmod +x"                            # quickly make a file executable
alias x-="sudo chmod -x"                            # quickly make a file un-executable

# ls
alias ls='\ls -F --color=always'                    # append indicators and colorize
alias la='ls -A'                                    # almost all
alias ll='la -lF'                                   # almost all, long listing, indicators
alias  l="ll -h"                                    # almost all, show size in K, M, G (except . & ..), long listing
alias lk='ll -Sr'                                   # sort by size
alias lr='ll -R'                                    # recursive ls
alias lx='ll -XB'                                   # sort by extension

# cd
alias up=" cd .."                                   # handy shortcut to quicly move up directory tree

# handy utils
alias du1='du -hd 1'                                # disk usage with human sizes and minimal depth (prefer: dsize)
alias fn='find . -name'                             # find files by name, in current directory
alias hi='history | tail'                           # display last commands entered in shell
alias p=" ps auwwx | grep"                          # find a process in the activity monitor
alias history="fc -il 1"                            # show timestamps in history

# aliases that I use, often
alias gem_grep='gem list --local | grep';
alias gffs='git flow feature start';
alias gfff='git flow feature finish';
alias be="bundle exec"
# copy my SSH key to the clipboard for quick pasting
alias getsshkey="cat $HOME/.ssh/`whoami`.pub | pbcopy"
# delete all the empty files from the current directory @ use with caution
alias deleteempty="find . -type d -empty -not -regex '.*\/.git\/.*' -exec {} \; -delete"
# }}}
# => Script dependent aliases {{{
# quickly, open files in the editor, or via open (require !fasd)
if which fasd &> /dev/null; then
  alias v="a -e '$EDITOR'"
  alias o="a -e '$BROWSER'"
 alias gv="a -e '$GUIEDITOR'"
else
  alias v="echo Please, install 'fasd' to use this command."
  alias o="echo Please, install 'fasd' to use this command."
 alias gv="echo Please, install 'fasd' to use this command."
fi
# }}}
# => MacOSX specific aliases {{{
if [[ "$OSTYPE" = darwin* ]]; then
  # flush the dns cache
  alias flushdns='sudo killall -HUP mDNSResponder'
  # recursively delete all the ugly `.DS_Store` files from current directory and its children
  alias deletedsstore='find . -type f -regex ".*\/\.DS_Store" -exec echo {} \; -delete'
  alias vlc='/Applications/VLC.app/Contents/MacOS/VLC';
  # show/hide the hidden files in the system
  alias showHidden='defaults write com.apple.finder AppleShowAllFiles TRUE ; killall Finder';
  alias hideHidden='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'; 
fi
# }}}
# => Ubuntu specific aliases {{{
if [[ $(uname -a) = *Ubuntu* ]]; then
  # behave like macosx
  alias open='xdg-open'
  alias pbcopy="xclip -selection clipboard"
  alias pbpaste="xclip -selection clipboard -o"
fi
# }}}

# Functions:
# => Common functions that I use {{{
# add aliases via command line
function addalias() {
    ALIASED="alias $1='$2';"
    echo "${ALIASED}" | tee -a $DOTCASTLE/localrc
    source $DOTCASTLE/localrc
}

# => create a new sub (ref: https://github.com/basecamp/sub)
function createsub() {
  echo "Creating a new sub: $1"
  git clone git://github.com/37signals/sub.git $DOTCASTLE/scripts/$1
  cd $DOTCASTLE/scripts/$1
  ./prepare.sh $1
  echo "Sub created."
}

# => handy utilities
# find all files in a given directory (or current) bigger than a specified size (default: 10MB)
function filesbysize() {
    if [ -z $1 ]; then size="10240k"; else size="$1"; fi
    if [ -z $2 ]; then dir="."; else dir="$2"; fi
    find "$dir" -type f -size +$size  -exec ls -lh {} \; | awk '{ print $9 ": " $5 }'
}
# }}}
# => Script dependent functions {{{
# a cow telling you about your fortune.
tunecow() {
    if which fortune &>/dev/null && which cowsay &>/dev/null; then
      if [ "$1" == "--random" -o "$1" == "-r" ]; then
        IFS=' '
        figures=(`cowsay -l | tail -n +2 | tr '\n' ' '`)
        num_figures=${#figures[*]}
        figure=${figures[$((RANDOM%num_figures))]}
        fortune -s | cowsay -f $figure
      else
        fortune -s | cowsay
      fi
    elif which fortune &>/dev/null; then
      fortune -s
    else
      echo "You must install fortune and (optionally) cowsay program."
    fi
}
# }}}
# => MacOSX specific functions {{{
if [[ "$OSTYPE" = darwin* ]]; then
  # find the ip address of a given domain name
  get_domain_ip() {
      for domain in "$@"; do
        echo -ne "${domain}"
        ping -c 1 $domain | grep "PING.*:.*data" | sed -e "s/.*(//g" -e "s/).*//g"
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

  # generate a local SSL certificate and feed it to the keychain.
  # can generate wildcard certificates, as well.
  # FIXME: hardcoded values
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
fi
# }}}
# => Ubuntu specific functions {{{
if [[ $(uname -a) = *Ubuntu* ]]; then
  function update_system() {
      sudo apt-get update
      sudo apt-get upgrade -y
      sudo apt-get dist-upgrade -y
      sudo apt-get autoremove
  }
fi
# }}}
# => OhMyZSH pull request changes {{{
# NOTE: config will be removed from here, as pull requests get merged into core.
function emoji-clock() {
  (( minutes = $(date '+%M') + 15 ))
  hour=$(date '+%I')
  [ $minutes -ge 60 ] && (( hour = $hour + 1 ))

  case $hour in
    1|13) clock="🕐"; [ $minutes -ge 30 ] && clock="🕜";;
    2)    clock="🕑"; [ $minutes -ge 30 ] && clock="🕝";;
    3)    clock="🕒"; [ $minutes -ge 30 ] && clock="🕞";;
    4)    clock="🕓"; [ $minutes -ge 30 ] && clock="🕟";;
    5)    clock="🕔"; [ $minutes -ge 30 ] && clock="🕠";;
    6)    clock="🕕"; [ $minutes -ge 30 ] && clock="🕡";;
    7)    clock="🕖"; [ $minutes -ge 30 ] && clock="🕢";;
    8)    clock="🕗"; [ $minutes -ge 30 ] && clock="🕣";;
    9)    clock="🕘"; [ $minutes -ge 30 ] && clock="🕤";;
    10)   clock="🕙"; [ $minutes -ge 30 ] && clock="🕥";;
    11)   clock="🕚"; [ $minutes -ge 30 ] && clock="🕦";;
    12)   clock="🕛"; [ $minutes -ge 30 ] && clock="🕧";;
     *)   clock="⌛";;
  esac
  echo $clock
}

if [[ "$OSTYPE" = darwin* ]]; then
  function fully_charged() {
    [[ $(ioreg -rc "AppleSmartBattery"| grep '^.*"FullyCharged"\ =\ ' | sed -e 's/^.*"FullyCharged"\ =\ //') == "Yes" ]]
  }
fi
# }}}
