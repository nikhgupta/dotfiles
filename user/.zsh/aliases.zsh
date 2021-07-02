#!/usr/bin/env zsh

alias -g COPY=" | pbcopy"
alias -g PASTE="pbpaste | "
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ERR='2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)'
alias -g NOERR='2> /dev/null'
alias -g NOOUT='1> /dev/null'
alias -g QUIET='&> /dev/null'
alias -g G='| grep'
# alias -g CWDF=$(~/.bin/macos/current-finder.applescript)
# alias -g BURL=$(~/.bin/macos/browser-url.applescript)

# Decolorize command output - useful in scripts
alias -g NOCOLOR="| perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' | col -b"

# Open the output of command in VIM [colorless]
alias -g VIM="NOCOLOR | vim -R -"

# show STDERR in red color :)
alias -g ERR='2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)'

# Share command output over HTTP
alias -g SHARE="| tee >(cat) NOCOLOR| curl -sF 'sprunge=<-' http://sprunge.us | pbcopy"
alias -g QRCODE=" | curl -sF-=\<- qrenco.de"

# Frequently used commands
alias edit="$EDITOR"
alias reload=" exec zsh -li"
alias edit_housekeeping=" vim ~/.bin/housekeep.sh"
edit_secrets() {
  mkdir -p $HOME/.decrypted
  src=$DOTCASTLE/.encrypted/zshenv.asc
  destin=$HOME/.decrypted/zshenv.decrypted-cache

  vim $src
  rm -f $destin
  gpg --decrypt $src 2>/dev/null >$destin
  chmod +x $destin
  source $destin
}

# chmod
alias w+="sudo chmod +w" # quickly make a file writeable
alias w-="sudo chmod -w" # quickly make a file un-writeable
alias x+="sudo chmod +x" # quickly make a file executable
alias x-="sudo chmod -x" # quickly make a file un-executable

# ls
alias ls='gls -F --color=always --group-directories-first'
alias la="ls -alh"
alias lS='ls -1FSsh | sort -r' # sort by size
alias lx='ls -lAFhXB'          # sort by extension - GNU only
alias lR='ls -AFtrd *(R)'      # show readable files
alias lRnot='ls -AFtrd *(^R)'  # show non-readable files

# handy utils
alias du1='du -hd 1'                              # disk usage with human sizes and minimal depth (prefer: dsize)
alias fn='find . -iname'                          # find files by name, in current directory
alias p="ps -eo pid,command|grep -v grep|grep -i" # find a process in the activity monitor
alias history="fc -il 1"                          # show timestamps in history
alias grep="grep -i --color"

# killers
alias ki9="kill -9"
alias ka9="killall -9"

# directories
alias md="mkdir -p"
take() { mkdir -p $@ && cd $@; }

# dump path - each directory on separate line
alias dumppath='echo -e ${PATH//:/\\n}'

# miscelleneous
alias getgpgkey="gpg -a --export $GPGKEY COPY"
alias getsshkey="gpg --export-ssh-key $SSHKEY COPY"
alias download="aria2c --file-allocation=none -s 16 -x 16"
alias showspace='sudo ncdu / --exclude=/media/* --exclude=/mnt/* --exclude=/Volumes/*'
alias benchmark="$HOME/.bin/benchmark_zsh.zsh"

# yabai
alias yabaictl=~/.bin/macos/yabaictl/yabaictl

# READ THE FUCKING MANUAL!!
rtfm() {
  help $@ 2 &>/dev/null ||
    man $@ 2 &>/dev/null ||
    browse "http://www.google.com/search?q=$@"
}

# quickly create a script that is available globally
function addscript() {
  local file="$HOME/.bin/$1"
  touch $file
  chmod +x $file
  vim $file
}

function md5() { echo $@ | md5sum | cut -d ' ' -f1; }
function whois() { dig +nocmd $1 any +multiline +noall +answer; }
function update-antibody-config() { antibody bundle < ~/.zsh/plugs.txt > ~/.zshplugs; }

check_xdg_dirs() {
  for _var in $(typeset -p | grep -E "export XDG_.*_(DIR|HOME)=" | cut -d ' ' -f2 | cut -d '=' -f1); do
    _dir="$(realpath ${(P)_var} 2>/dev/null)"
    [[ -z "${_dir}" ]] && _dir="${(P)_var}"
    [[ -d "${_dir}" ]] && echo "\e[32m$_var ===== $_dir" || echo "\e[31m$_var ==!== $_dir"
  done
}

# Unique lines without sorting text.
# Use: uniquify somefile
#      cat somefile | uniquify
alias uniquify="awk '!x[\$0]++'"

# Get current IP
alias ip='timeout 3s echo $(curl -s ipecho.net/plain)'
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
# alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# Bell when IP comes online
# Use: whenup google.com
alias whenup="ping -i 60 -a "

# Use like this: cat whatever | typewrite
alias typewrite="pv -qL 10"

# shows apps using network currently
alias usingnet='lsof -PbwnR +c15 -sTCP:LISTEN -iTCP'

# List all TCP processes listening to ports on localhost
alias localserverports="lsof -bwaRPiTCP@127.0.0.1 -sTCP:LISTEN"

# Download all images from a website
alias imagedown="wget -r -l1 --no-parent -nH -nd -P/tmp -A\".jpg,.png,.jpeg\""

# Send notifications from command line
alias notifyDone='terminal-notifier -title "Terminal" -message "Done with task!"'
alias notifier='terminal-notifier -sound default'

# Find MB eating directories
alias dush="du -sm {*,.*} 2>/dev/null | sort -n|tail"

# random string
function passrand() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w "${1:-96}" | head -n 1
}
function md5rand() { passrand 1028 | md5sum | cut -d' ' -f1; }
function sha2rand() { passrand 1028 | sha256sum | cut -d' ' -f1; }

# Search commands on CLF and open in Vim
function cmdfu() {
  local url="http://www.commandlinefu.com/commands/matching/"
  local url="${url}$(echo "$@" | sed 's/ /-/g')/"
  local url="${url}$(echo -n $@ | base64)/plaintext"
  curl "${url}" --silent | vim -R -
}

# Monitor processes usin top with command matching given str only:
function ptop() {
  pgrep "$1" && top $(pgrep "$1" | sed 's|^|-pid |g') || {
    echo "Found no process with name matching: $1"
    exit 1
  }
}

# Get a quick proxy for use
function getproxy() {
  local url="https://gimmeproxy.com/api/getProxy?"
  local url="${url}protocol=http&minSpeed=100&maxCheckPeriod=3600&anonymityLevel=1"
  curl -s "${url}" | json_pp
}

# Copy w/ progress
cp_p () { rsync -WavP --human-readable --progress $1 $2; }

# Get missing vim features (works with v8.0)
function vim_missing_features() {
  for feature in $(vim --version | tail -43|head -31); do echo $feature; done | grep --color=never '-'
}

# Use Git’s colored diff when available
is_installed git && function diff() { git diff --no-index --color-words "$@"; }

# Start an HTTP server from a directory, optionally specifying the port
function serve_directory() {
	local port="${1:-8000}";
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# mac os related
# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Airport CLI alias
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1 -I {}"

# cd into whatever is the forefront Finder window.
cdf() {  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"; }

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Change working directory to the top-most Finder window location
function cdf() { cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"; }

# `o` with no arguments opens the current directory, otherwise opens the given location
function o() { [ $# -eq 0 ] && open . || open "$@"; }

# battery percentage
function battery_percent() { pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';' | tr -d '%'; }

# retake brew permissions
function reset_brew_perms() {
  [[ $(gstat -c "%U" "$(brew --prefix)/Cellar") == $(whoami) ]] && return

  sudo chown -R "$(whoami)":staff "$(brew --prefix)/*"
}

# who is using secure keyboard entry?
function who_is_using_secure_keyboard_entry() {
  ioreg -l -w 0 \
    | perl -nle 'print $1 if /"kCGSSessionSecureInputPID"=(\d+)/' \
    | uniq \
    | xargs -I{} ps -p {} -o comm=
}

function displays() {
  if [[ -z "$1" ]]; then
    system_profiler SPDisplaysDataType | ruby -e "
      require 'yaml';
      data=YAML.load(STDIN);
      puts data['Graphics/Displays'].map{ _2['Displays'] }.compact.map(&:keys)
    "
  else
    system_profiler SPDisplaysDataType | ruby -e "
      require 'yaml';
      data=YAML.load(STDIN);
      puts data['Graphics/Displays'].map{ _2['Displays'] }.compact.map{ |a| a.map{_2['$1']}}"
  fi
}
