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

# zsh related aliases
alias zshedit="edit $DOTCASTLE"

# common and most-often used aliases
alias cl=" clear"                                   # NOTE: use CTRL-K instead.

# chmod
alias w+="sudo chmod +w"                            # quickly make a file writeable
alias w-="sudo chmod -w"                            # quickly make a file un-writeable
alias x+="sudo chmod +x"                            # quickly make a file executable
alias x-="sudo chmod -x"                            # quickly make a file un-executable

# ls
alias ls='\ls -F --color=always'                    # append indicators and colorize
alias lS='ls -1FSsh | sort -r'                      # sort by size
alias lx='ls -lAFhXB'                               # sort by extension - GNU only
alias lR='ls -AFtrd *(R)'                           # show readable files
alias lRnot='ls -AFtrd *(^R)'                       # show non-readable files

# handy utils
alias du1='du -hd 1'                                # disk usage with human sizes and minimal depth (prefer: dsize)
alias fn='find . -name'                             # find files by name, in current directory
alias p=" ps auwwx | grep"                          # find a process in the activity monitor
alias history="fc -il 1"                            # show timestamps in history

# killers
alias k9="kill -9"
alias ka9="killall -9"

# handy globals
alias -g COPY=" | pbcopy"
alias -g PASTE="pbpaste | "
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# aliases that I use, often
is_installed hub && alias git=hub
alias gem_local='gem list --local';
# copy my SSH key to the clipboard for quick pasting
alias getsshkey="cat $HOME/.ssh/`whoami`.pub COPY"
# delete all the empty files from the current directory @ use with caution
alias deleteempty="find . -type f -empty -not -regex '.*\/.git\/.*' -exec {} \; -delete"

# rails workflow
alias bundled="bundle install --local || bundle install || bundle update"

# tmux run command
th(){ tmux split -h "$@"; }
tv(){ tmux split -v "$@"; }
tw(){ tmux new-window "$@"; }
# iterm2
ondesktop(){ export DISABLE_AUTO_TITLE="true";echo -ne "\e]1;${1:-on desktop}\a"; }
# }}}
# => Script dependent aliases {{{
# quickly, open files in the editor, or via open (require !fasd)
if is_installed fasd; then
  alias e="a -e '$EDITOR'"
  alias o="a -e '$BROWSER'"
  alias ge="a -e '$GUIEDITOR'"
else
  alias e="echo Please, install 'fasd' to use this command."
  alias o="echo Please, install 'fasd' to use this command."
  alias ge="echo Please, install 'fasd' to use this command."
fi
# }}}
# => MacOSX specific aliases {{{
if is_macosx; then
  # flush the dns cache
  alias flushdns='sudo killall -HUP mDNSResponder'

  # recursively delete all the ugly `.DS_Store` files from current directory and its children
  alias deletedsstore='find . -type f -regex ".*\/\.DS_Store" -exec echo {} \; -delete'

  # show/hide the hidden files in the system
  alias showHidden='defaults write com.apple.finder AppleShowAllFiles TRUE ; killall Finder';
  alias hideHidden='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder';

  if [[ -e /Applications/VLC.app/Contents/MacOS/VLC ]]; then
    alias vlc='/Applications/VLC.app/Contents/MacOS/VLC';
  fi
fi
# }}}
# => Ubuntu specific aliases {{{
if is_ubuntu; then
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

# => measure average time for a command by running it a number of times
function avgtime() {
o_times=(-n 5); o_help=(); o_quiet=();o_verbose=()
zparseopts -D -E -K -- n:=o_times h=o_help -help=o_help q=o_quiet v=o_verbose

if [[ $# == 0 || $? != 0 || -n "$o_help" ]]; then
  echo "USAGE: $(basename "$0") [-n TIMES ] [-q|v] COMMAND"
  echp " note: This command is please, quote your COMMAND."
  return 1
fi

if [[ -z "$o_quiet" ]]; then
  echo "Running command (${o_times[2]} times): $@"
  echo "Note that, there will be a slight overhead."
  echo "If this is a concern, please run again with \`-q\` flag."
  echo
  echo "Rehearsal:"
  eval "$1"
  echo "----------"
fi

sequence=$(seq -w 1 $o_times[2])
[[ -n "$o_verbose" ]] && _command="$1" || _command="$1 &>/dev/null"
start_time=$(date '+%s%N')
for i in `echo $sequence`; do
  if [[ -z "$o_quiet" ]]; then
    echo -ne "Run $i: "
    eval "time ($_command)"
  else
    eval "${_command}"
  fi
done
stop_time=$(date '+%s%N')
(( time_taken = ($stop_time - $start_time) / ($o_times[2] * 1000000.0) ))

echo -ne "average time (${o_times[2]} runs): $1:"
printf " %.6gms\n" $time_taken
}
unalias ts
ts() {
  name="${1:-$(basename $(realpath .))}"
  if tmux list-sessions | grep "${name}" >/dev/null; then
    tmux attach -t "${name}"
  else
    tmux new-session -s "${name}"
  fi
}
# }}}
# => Script dependent functions {{{
# a cow telling you about your fortune.
tunecow() {
  if is_installed fortune && is_installed cowsay; then
    if [ "$1" == "--random" -o "$1" == "-r" ]; then
      IFS=' '
      figures=(`cowsay -l | tail -n +2 | tr '\n' ' '`)
      num_figures=${#figures[*]}
      figure=${figures[$((RANDOM%num_figures))]}
      fortune -s | cowsay -f $figure
    else
      fortune -s | cowsay
    fi
  elif is_installed fortune; then
    fortune -s
  else
    echo "You must install fortune and (optionally) cowsay program."
  fi
}
# cut a video of a specific duration from a specified time
video_cut() {
  src="${1}"
  dst="${1:t:r}.cut.${2//[^[:alnum:]]/_}-${3//[^[:alnum:]]/_}.${1:e}"
  if ! is_installed ffmpeg; then
    echo "You must install ffmpeg to cut videos."
    return 1
  elif [[ $# -lt 3 ]]; then
    echo "Error: Invalid number of arguments."
    echo
    echo "Cuts a video of specific duration from a specified time by copying the video stream."
    echo "Usage: video_cut <filename> <from> <duration>"
    echo "Generated file is named as: <basename>.cut.<duration-info>.<extension>"
    echo
    echo "Example:"
    echo "  video_cut video.mov 00:15:00 00:05:00 4"
    echo "will cut the above video file from 15 mins mark for a duration of 5 minutes,"
    echo "and save the new file as: video.cut.00_15_00-00_05_00.mov"
    return 1
  elif [[ ! -f "${src}" ]]; then
    echo "Provided input video file: ${src} doesn't exist."
    return 1
  elif [[ -e "${dst}" ]]; then
    echo "File exists at: ${dst}. Please, rename it before continuing."
    echo "For further info, run video_cut without any arguments."
    return 1
  elif [[ -t 1 ]]; then
    ffmpeg -n -stats -ss "$2" -i "${src}" -c copy -avoid_negative_ts 1 -to "${3}" "${dst}"
    echo "File created at: ${dst}"
  else
    ffmpeg -n -v 0 -ss "$2" -i "${src}" -c copy -avoid_negative_ts 1 -to "${3}" "${dst}"
    echo "${dst}"
  fi
}
video_reduce() {
  src="${1}"
  dst="${1:t:r}.reduced.${1:e}"
  if ! is_installed ffmpeg; then
    echo "You must install ffmpeg to reduce video size."
    return 1
  elif [[ $# -lt 1 ]]; then
    echo "Error: Invalid number of arguments."
    echo
    echo "Reduces file size of a video with minimal loss of quality."
    echo "Usage: video_reduce <filename>"
    echo "Generated file is named as: <basename>.reduced.<extension>"
    echo
    echo "Example:"
    echo "  video_reduce video.mov"
    echo "will reduce the file size for video.mov, and"
    echo "save the new file as: video.reduced.mov"
    return 1
  elif [[ ! -f "${src}" ]]; then
    echo "Provided input video file: ${src} doesn't exist."
    return 1
  elif [[ -e "${dst}" ]]; then
    echo "File exists at: ${dst}. Please, rename it before continuing."
    echo "For further info, run video_reduce without any arguments."
    return 1
  elif [[ -t 1 ]]; then
    ffmpeg -n -stats -i "${src}" -crf 20 "${dst}"
    echo "File created at: ${dst}"
  else
    ffmpeg -n -v 0 -i "${src}" -crf 20 "${dst}"
    echo "${dst}"
  fi
}
video_cut_and_reduce() {
  src="${1}"
  dst1="${src:t:r}.cut.${2//[^[:alnum:]]/_}-${3//[^[:alnum:]]/_}.${src:e}"
  dst2="${dst1:t:r}.reduced.${dst1:e}"

  if video_cut $@ && [[ -e "${dst1}" ]]; then
    echo; echo
    if video_reduce "${dst1}" && [[ -e "${dst2}" ]]; then
      echo; echo
      echo "Created the uncompressed cut video at: ${dst1}"
      echo "Created the compressed version of above at: ${dst2}"
    else
      echo; echo
      echo "Reducing the file size failed."
      echo "However, I was successful in cutting the video."
      echo "Created the uncompressed cut video at: ${dst1}"
      return 1
    fi
  else
    echo; echo
    echo "Cutting the video failed."
    return 1
  fi
}
# }}}
# => MacOSX specific functions {{{
if is_macosx; then
  # find the ip address of a given domain name
  get_domain_ip() {
    for domain in "$@"; do
      echo -ne "${domain}"
      ping -c 1 $domain | grep "PING.*:.*data" | sed -e "s/.*(//g" -e "s/).*//g"
    done
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

  # Copy a directory recursively while resizing all the image files within.
  copy_resize_images() {
    if [[ $# -lt 4 ]]; then
      echo "Error: Invalid number of arguments."
      echo
      echo "Copies a directory recursively while resizing all image files of a specific type."
      echo "Usage: copy_resize_images <source_dir> <destin_dir> <extension> <max_size>"
      echo
      echo "Example:"
      echo "  copy_resize_images ./pictures ./resized jpg 3600"
      echo "will copy all 'jpg' files (case-insensitive) from './pictures'"
      echo "to './resized' directory, while reducing the max dimension "
      echo "(width or height) to 3600 pixels."
      return 1
    else
      cd $1; files=$(find . -type f -iname "*.${3}"); cd -;

      IFS=$'\n'
      for file in $(echo $files); do
        echo "Processing file: $(realpath $1/$file)"
        mkdir -p "$2/${file:h}"
        sips -Z $4 "$1/$file" --out "$2/$file" 1&>/dev/null
      done
    fi
  }
fi
# }}}
# => Ubuntu specific functions {{{
if is_ubuntu; then
  function update_system() {
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get dist-upgrade -y
  sudo apt-get autoremove
}
fi
# }}}
