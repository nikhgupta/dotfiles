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
# quickly reload this f
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
alias ls='\gls -F --color=always'                    # append indicators and colorize
alias lS='ls -1FSsh | sort -r'                      # sort by size
alias lx='ls -lAFhXB'                               # sort by extension - GNU only
alias lR='ls -AFtrd *(R)'                           # show readable files
alias lRnot='ls -AFtrd *(^R)'                       # show non-readable files

# handy utils
alias du1='du -hd 1'                                # disk usage with human sizes and minimal depth (prefer: dsize)
alias fn='find . -name'                             # find files by name, in current directory
alias p="ps -eo pid,command | grep -v grep | grep -i" # find a process in the activity monitor
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

# emacs specific
alias em='emacsclient -ta ""';
alias ec='emacsclient -nca ""';

# tmux run command
th(){ tmux split -h "$@"; }
tv(){ tmux split -v "$@"; }
tw(){ tmux new-window "$@"; }
alias tl="tmux list-sessions"

function workon(){
  local session_name="${1:-$(basename $(realpath .))}"
  local other_session_name="${1:-$(basename $(dirname $(realpath .)))}"
  if tmuxinator list | grep "${session_name}" &>/dev/null; then
    tmuxinator start "${session_name}"
  elif tmuxinator list | grep "${other_session_name}" &>/dev/null; then
    tmuxinator start "${other_session_name}"
  else
    ts "${session_name}"
  fi

}

function workoff() {
  if [[ -n "${1}" ]] && tmuxinator list | grep $1 &>/dev/null; then
    tmuxinator stop $1
  else
    local session_name="$(tmux display-message -p '#S')"
    tmuxinator stop $session_name || tmux kill-session -t $session_name
  fi
}

alias cleantestdb='RAILS_ENV=test bin/rake db:drop db:create db:migrate'
alias rspecff='rspec --fail-fast'
alias rspecffof='rspec --fail-fast --only-failures'
# }}}
# => Script dependent aliases {{{
# quickly, open files in the editor, or via open (require !fasd)
if which fasd &>/dev/null; then
  alias e="a -e '$EDITOR'"
  alias o="a -e '$BROWSER'"
  alias ge="a -e '$GUIEDITOR'"
fi

# alias SilverSearch to PlatinumSearcher
which pt &>/dev/null && ! which ag &>/dev/null && alias ag=pt
# }}}

# Functions:
# => Common functions that I use {{{
# add aliases via command line
function addalias() {
  ALIASED="alias $1='$2';"
  echo "${ALIASED}" | tee -a $DOTCASTLE/localrc
  source $DOTCASTLE/localrc
}

function gem() {
  local gem_command=$RBENV_ROOT/shims/gem
  if [[ -z "${@}" ]] || $gem_command help commands | grep "${1}" &>/dev/null; then
    $gem_command "${@}"
  elif [[ "$1" == "readme" ]] && gem which $2 1>/dev/null; then
    local gem_dir=$(dirname $(dirname $(gem which $2)))
    open -a "Google Chrome" $gem_dir/README* 2>/dev/null ||
    open -a "Google Chrome" $gem_dir/readme* 2>/dev/null || {
      echo "Could not find a readme file for gem: ${2}"
      echo "Listing files for directory: ${gem_dir}"
      ls -al --color "${gem_dir}"
    }
  fi
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
ts() {
  name="${1:-$(basename $(realpath .))}"
  if tmux list-sessions | grep "${name}" >/dev/null; then
    tmux attach -t "${name}"
  else
    tmux new-session -s "${name}"
  fi
}
launchctl() {
  local message="You can not run launchctl from inside a TMux Shell!"
  if [[ -z "${TMUX}" ]]; then /bin/launchctl $@; else echo $message; fi
}

# alias pandoc="$(brew --prefix pandoc) --css ~/Code/dotcastle/miscelleneous/github-pandoc.css"

readme() {
  if which pandoc &>/dev/null; then
    local dir="${1:-`pwd`}"
    local dst="/tmp/readme.$$.html"
    local src="${1:-`pwd`}"
    if [[ ! -f "${src}" ]]; then
      if [[ -d "${src}" ]]; then
        src=$(find "${dir}" -type f -maxdepth 1 -iregex '.*\/readme..*' -exec wc -l {} + | sort -rn | tac | tail -2 | head -1 | tr -s ' ' ' ' | rev | cut -d ' ' -f 1 | rev)
        if [[ -f "${src}" ]]; then
          local title="<title>$(basename $(dirname $src))/$(basename $src)</title>"
          title="${title}<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=PT+Sans' type='text/css'>"
          pandoc --css "${HOME}/Code/dotcastle/miscelleneous/github-pandoc.css" \
            "${src}" | sed -e "s#<title></title>#${title}#" > "${dst}"
          open -a "Safari" "${dst}"
        else
          echo "No readme file found!"
          echo "All files that were found:"
          find "${dir}" -type f -maxdepth 1
          echo "Below is readme search results:"
          find "${dir}" -type f -maxdepth 1 -iregex '.*\/readme..*'
        fi
      else
        echo "Invalid input!"
      fi
    fi
  else
    echo "Please, install pandoc: brew install pandoc"
  fi
}
# }}}

# Disabled Stuff: {{{
# => Ubuntu specific aliases {{{
# if is_ubuntu; then
#   # behave like macosx
#   alias open='xdg-open'
#   alias pbcopy="xclip -selection clipboard"
#   alias pbpaste="xclip -selection clipboard -o"
# fi
# }}}
# => MacOSX specific aliases {{{
# if is_macosx; then
#   # flush the dns cache
#   alias flushdns='sudo killall -HUP mDNSResponder'

#   # recursively delete all the ugly `.DS_Store` files from current directory and its children
#   alias deletedsstore='find . -type f -regex ".*\/\.DS_Store" -exec echo {} \; -delete'

#   # show/hide the hidden files in the system
#   alias showHidden='defaults write com.apple.finder AppleShowAllFiles TRUE ; killall Finder';
#   alias hideHidden='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder';

#   if [[ -e /Applications/VLC.app/Contents/MacOS/VLC ]]; then
#     alias vlc='/Applications/VLC.app/Contents/MacOS/VLC';
#   fi
# fi
# }}}
# => Ubuntu specific functions {{{
# if is_ubuntu; then
#   function update_system() {
#   sudo apt-get update
#   sudo apt-get upgrade -y
#   sudo apt-get dist-upgrade -y
#   sudo apt-get autoremove
# }
# fi
# }}}
# => MacOSX specific functions {{{
# if is_macosx; then
#   # find the ip address of a given domain name
#   get_domain_ip() {
#     for domain in "$@"; do
#       echo -ne "${domain}"
#       ping -c 1 $domain | grep "PING.*:.*data" | sed -e "s/.*(//g" -e "s/).*//g"
#     done
#   }

#   # generate a local SSL certificate and feed it to the keychain.
#   # can generate wildcard certificates, as well.
#   # FIXME: hardcoded values
#   gen_ssl() {
#     if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
#       echo "Usage: gen_wildcard_ssl <domain.com> <common_name> <single/wildcard>"
#     elif [ -d /private/etc/apache2/ssl/$1/$3.cert ]; then
#       echo "Path: /private/etc/apache2/ssl/$1/$3.cert already exists."
#     else
#       mkdir /tmp/sslcert
#       pushd /tmp/sslcert
#       (umask 077 && touch $3.key $3.cert $3.info $3.pem)
#       openssl genrsa 2048 > $3.key
#       openssl req -new -x509 -nodes -sha1 -days 3650 -key $3.key \
#         -subj "/C=IN/ST=Rajasthan/L=Jaipur/O=Wicked Developers/OU=IT/CN=$2" > $3.cert
#       openssl x509 -noout -fingerprint -text < $3.cert > $3.info
#       cat $3.cert $3.key > $3.pem
#       chmod 400 $3.key $3.pem

#       sudo mkdir /private/etc/apache2/ssl/$1 2>/dev/null
#       sudo mv $3.key $3.pem $3.cert $3.info /private/etc/apache2/ssl/$1
#       popd
#       rm -rf /tmp/sslcert

#       echo "\n====="
#       echo "Certificate generation completed."
#       echo "Created at: /private/etc/apache2/ssl/$1/$3.cert"

#       sudo security add-trusted-cert -d -r trustRoot -k \
#         "/Library/Keychains/System.keychain" /private/etc/apache2/ssl/$1/$3.cert

#       echo "Certificate marked as trusted in OSX Keychain."
#     fi
#   }
#   gen_single_ssl() { gen_ssl $1 $1 "single"; }
#   gen_wildcard_ssl() { gen_ssl $1 *.$1 "wildcard"; }

#   # Copy a directory recursively while resizing all the image files within.
#   copy_resize_images() {
#     if [[ $# -lt 4 ]]; then
#       echo "Error: Invalid number of arguments."
#       echo
#       echo "Copies a directory recursively while resizing all image files of a specific type."
#       echo "Usage: copy_resize_images <source_dir> <destin_dir> <extension> <max_size>"
#       echo
#       echo "Example:"
#       echo "  copy_resize_images ./pictures ./resized jpg 3600"
#       echo "will copy all 'jpg' files (case-insensitive) from './pictures'"
#       echo "to './resized' directory, while reducing the max dimension "
#       echo "(width or height) to 3600 pixels."
#       return 1
#     else
#       cd $1; files=$(find . -type f -iname "*.${3}"); cd -;

#       IFS=$'\n'
#       for file in $(echo $files); do
#         echo "Processing file: $(realpath $1/$file)"
#         mkdir -p "$2/${file:h}"
#         sips -Z $4 "$1/$file" --out "$2/$file" 1&>/dev/null
#       done
#     fi
#   }
# fi
# }}}
# => Script dependent functions {{{
# a cow telling you about your fortune.
# tunecow() {
#   if is_installed fortune && is_installed cowsay; then
#     if [ "$1" == "--random" -o "$1" == "-r" ]; then
#       IFS=' '
#       figures=(`cowsay -l | tail -n +2 | tr '\n' ' '`)
#       num_figures=${#figures[*]}
#       figure=${figures[$((RANDOM%num_figures))]}
#       fortune -s | cowsay -f $figure
#     else
#       fortune -s | cowsay
#     fi
#   elif is_installed fortune; then
#     fortune -s
#   else
#     echo "You must install fortune and (optionally) cowsay program."
#   fi
# }
# cut a video of a specific duration from a specified time
# video_cut() {
#   src="${1}"
#   dst="${1:t:r}.cut.${2//[^[:alnum:]]/_}-${3//[^[:alnum:]]/_}.${1:e}"
#   if ! is_installed ffmpeg; then
#     echo "You must install ffmpeg to cut videos."
#     return 1
#   elif [[ $# -lt 3 ]]; then
#     echo "Error: Invalid number of arguments."
#     echo
#     echo "Cuts a video of specific duration from a specified time by copying the video stream."
#     echo "Usage: video_cut <filename> <from> <duration>"
#     echo "Generated file is named as: <basename>.cut.<duration-info>.<extension>"
#     echo
#     echo "Example:"
#     echo "  video_cut video.mov 00:15:00 00:05:00 4"
#     echo "will cut the above video file from 15 mins mark for a duration of 5 minutes,"
#     echo "and save the new file as: video.cut.00_15_00-00_05_00.mov"
#     return 1
#   elif [[ ! -f "${src}" ]]; then
#     echo "Provided input video file: ${src} doesn't exist."
#     return 1
#   elif [[ -e "${dst}" ]]; then
#     echo "File exists at: ${dst}. Please, rename it before continuing."
#     echo "For further info, run video_cut without any arguments."
#     return 1
#   elif [[ -t 1 ]]; then
#     ffmpeg -n -stats -ss "$2" -i "${src}" -c copy -avoid_negative_ts 1 -to "${3}" "${dst}"
#     echo "File created at: ${dst}"
#   else
#     ffmpeg -n -v 0 -ss "$2" -i "${src}" -c copy -avoid_negative_ts 1 -to "${3}" "${dst}"
#     echo "${dst}"
#   fi
# }
# video_reduce() {
#   src="${1}"
#   dst="${1:t:r}.reduced.${1:e}"
#   if ! is_installed ffmpeg; then
#     echo "You must install ffmpeg to reduce video size."
#     return 1
#   elif [[ $# -lt 1 ]]; then
#     echo "Error: Invalid number of arguments."
#     echo
#     echo "Reduces file size of a video with minimal loss of quality."
#     echo "Usage: video_reduce <filename>"
#     echo "Generated file is named as: <basename>.reduced.<extension>"
#     echo
#     echo "Example:"
#     echo "  video_reduce video.mov"
#     echo "will reduce the file size for video.mov, and"
#     echo "save the new file as: video.reduced.mov"
#     return 1
#   elif [[ ! -f "${src}" ]]; then
#     echo "Provided input video file: ${src} doesn't exist."
#     return 1
#   elif [[ -e "${dst}" ]]; then
#     echo "File exists at: ${dst}. Please, rename it before continuing."
#     echo "For further info, run video_reduce without any arguments."
#     return 1
#   elif [[ -t 1 ]]; then
#     ffmpeg -n -stats -i "${src}" -crf 20 "${dst}"
#     echo "File created at: ${dst}"
#   else
#     ffmpeg -n -v 0 -i "${src}" -crf 20 "${dst}"
#     echo "${dst}"
#   fi
# }
# video_cut_and_reduce() {
#   src="${1}"
#   dst1="${src:t:r}.cut.${2//[^[:alnum:]]/_}-${3//[^[:alnum:]]/_}.${src:e}"
#   dst2="${dst1:t:r}.reduced.${dst1:e}"

#   if video_cut $@ && [[ -e "${dst1}" ]]; then
#     echo; echo
#     if video_reduce "${dst1}" && [[ -e "${dst2}" ]]; then
#       echo; echo
#       echo "Created the uncompressed cut video at: ${dst1}"
#       echo "Created the compressed version of above at: ${dst2}"
#     else
#       echo; echo
#       echo "Reducing the file size failed."
#       echo "However, I was successful in cutting the video."
#       echo "Created the uncompressed cut video at: ${dst1}"
#       return 1
#     fi
#   else
#     echo; echo
#     echo "Cutting the video failed."
#     return 1
#   fi
# }
# }}}
#
# # iterm2
# ondesktop(){ export DISABLE_AUTO_TITLE="true";echo -ne "\e]1;${1:-on desktop}\a"; }
#
# # markdown
# markview(){ find $@ -type f -iname '*.md' -exec open -a 'Google Chrome' {} \;; }
#
# # lynx browser
# if is_installed lynx; then
#   vimlynx(){ lynx -vikeys -xhtml-parsing -use_mouse -underline_links \
#                -term=$TERM -justify -prettysrc $@; }
#   webdump(){ vimlynx -dump -underscore -stderr -force_html \
#                      -width=$COLUMNS -image_links -notitle $@; }
#   mdpv(){ filepath="$1"; shift
#     [[ -f "${filepath}" ]] && rdiscount "${filepath}" |
#       sed -e 's/<h1/<h1 align="left"/' | webdump -stdin ||
#       echo "Not a file. Markdown Preview unavailable."; }
# fi
#
# => create a new sub (ref: https://github.com/basecamp/sub)
# function createsub() {
# echo "Creating a new sub: $1"
# git clone git://github.com/37signals/sub.git $DOTCASTLE/scripts/$1
# cd $DOTCASTLE/scripts/$1
# ./prepare.sh $1
# echo "Sub created."
# }
#
# => handy utilities
# find all files in a given directory (or current) bigger than a specified size (default: 10MB)
# function filesbysize() {
# if [ -z $1 ]; then size="10240k"; else size="$1"; fi
# if [ -z $2 ]; then dir="."; else dir="$2"; fi
# find "$dir" -type f -size +$size  -exec ls -lh {} \; | awk '{ print $9 ": " $5 }'
# }
# function emacs_restart() {
#   old_pid="$(p emacs.*daemon | awk '{print $1}')"
#   if [[ -n "${old_pid}" ]]; then
#     echo "Old PID is ${old_pid}.."
#   else
#     echo "No Emacs' daemon running"
#   fi
#   echo "Restarting Emacs.."
#   echo "Please, standby for 20 seconds.."
#   lunchy stop emacs &>/dev/null
#   [[ -n "${old_pid}" ]] && { kill "${old_pid}"; sleep 3; }
#   lunchy start emacs &>/dev/null
#   sleep 17; new_pid="$(p emacs.*daemon | awk '{print $1}')"
#   if echo "${old_pid}" | grep "${new_pid}"; then
#     echo "Emacs' daemon could not be restarted."
#     echo "Here are the last few lines of the log for you to debug:"
#     echo
#     tail -25 /usr/local/var/log/emacs/errors.log
#   else
#     echo "Emacs' daemon restarted. New PID is ${new_pid}."
#   fi
# }
# transfer() {
#   if [[ "$@" == "-h" || "$@" == "--help" ]]; then
#     echo "No arguments specified."
#     echo "Usage:"
#     echo "transfer /tmp/test.md               # => uploaded as test.md"
#     echo "cat /tmp/test.md | transfer test.rb # => uploaded as test.rb"
#     echo "cat /tmp/test.md | transfer         # => uploaded as <rand>.txt"
#     return 1
#   fi
#   tmpfile=$( mktemp -t transferXXX )
#   if tty -s; then
#     basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
#     curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile
#   elif [[ $# -eq 0 ]]; then
#     name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 | md5)
#     curl --progress-bar --upload-file "-" "https://transfer.sh/$name.txt" >> $tmpfile
#   else
#     curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile
#   fi
#   cat $tmpfile; cat $tmpfile | pbcopy
#   rm -f $tmpfile
# }
# alias transfer=transfer
#
# ping-test-servers(){
#   for server in $@; do
#     echo "$(ping -i 0.1 -c 25 $server | tail -1 | cut -d '/' -f 5) $server"
#   done | sort -n
# }
#
# function pko(){
#   IFS=$'\n'; REPLY=""
#   output="$(p "$1")"
#   [[ -z "$output" ]] && echo "No such process found." && return
#   echo $output | grep -i "$1" --color=always
#   read -q REPLY\?"Really kill all these processes? [y/N] "; echo
#   [[ "$REPLY" == "y" || "$REPLY" == "Y" ]] &&
#     {
#       echo $output | awk '{print $1}' | xargs -I {} kill {}
#       sleep 1
#       if p "$1" &>/dev/null; then echo "Some processes are still alive:"; p "$1";
#       else echo "Killed above processes."; fi
#     } ||
#     echo "Phew! that was close. No process terminated."
# }
# }}}

function idea() { echo "- $@" >> ~/Code/ideas.md }

function moistroom {
  cd ~/Code/Shopify/shopify_helper &>/dev/null
  bundle exec exe/shopify $1 -p moistroom ${@:2}
  cd - &>/dev/null
}
