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

alias edit="$EDITOR"
alias reload=" source $HOME/.zshrc"
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
alias ls='ls -F --color=always --group-directories-first'
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
alias k9="kill -9"
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
alias showspace='sudo ncdu / --exclude=/media/* --exclude=/mnt/*'
alias benchmark="$HOME/.bin/benchmark_zsh.zsh"

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
function update-antibody-config() { antibody bundle <~/.zsh/plugs.txt >~/.zshplugs; }

check_xdg_dirs() {
  for _var in $(typeset -p | grep -E "export XDG_.*_(DIR|HOME)=" | cut -d ' ' -f2 | cut -d '=' -f1); do
    _dir="$(realpath ${(P)_var} 2>/dev/null)"
    [[ -z "${_dir}" ]] && _dir="${(P)_var}"
    [[ -d "${_dir}" ]] && echo "\e[32m$_var ===== $_dir" || echo "\e[31m$_var ==!== $_dir"
  done
}

# sync pictures and videos with onedrive storage
onedrivesync() { 
  orig=$1; shift
  dest=$1; shift
  rclone sync $orig $dest -P --delete-excluded --fast-list --log-level=INFO --no-check-certificate --no-update-modtime $@
}
alias onedrivesync_photos="onedrivesync /media/nikhgupta/Gallery onedrive:Photography"

## run programs with pre-determined settings
alias mpv="prime-run mpv"
alias ranger="named_terminal ranger -e ranger"