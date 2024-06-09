#!/usr/bin/env zsh

# speed up parent directories
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# redirect stdout/stderr easily
alias -g NOERR='2> /dev/null'
alias -g NOOUT='1> /dev/null'
alias -g QUIET='&> /dev/null'
alias -g ERR='2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)'

# shortcuts to some frequently used commands
alias -g G='| rg'
alias -g RG=G
alias -g GREP=G

# copy and paste
alias -g COPY="| pbcopy"
alias -g PASTE="| pbpaste"

# Decolorize command output - useful in scripts
alias -g NOCOLOR="| perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' | col -b"

# Open the output of command in VIM [colorless]
alias -g VIM="NOCOLOR | vim -R -"

# Share command output over HTTP
alias -g SHARE="| tee >(cat) NOCOLOR| curl -sF 'sprunge=<-' http://sprunge.us | pbcopy"

# process each line of output
function process_each_line() { while read line; do $@ $line; done; }
alias -g PROCESS_EACH_LINE="| process_each_line"

# editor related
alias e=edit
alias vim=edit
alias edit="${EDITOR}"
alias ge=gedit
alias gvim=gedit
alias gedit="${VISUAL}"

# chmod
alias w+="sudo chmod +w" # quickly make a file writeable
alias w-="sudo chmod -w" # quickly make a file un-writeable
alias x+="sudo chmod +x" # quickly make a file executable
alias x-="sudo chmod -x" # quickly make a file un-executable

# ls
alias ls='gls -F --color=always --group-directories-first'
alias la="ls -alh"             # list all files and folders
alias lS='ls -1FSsh | sort -r' # sort by size
alias lx='ls -lAFhXB'          # sort by extension - GNU only
alias lR='ls -AFtrd *(R)'      # show readable files
alias lRnot='ls -AFtrd *(^R)'  # show non-readable files

# better defaults
alias md="mkdir -p"
alias du1='du -hd 1'         # disk usage with human sizes and minimal depth (prefer: dsize)
alias history="fc -il 1"     # show timestamps in history
alias reload=" exec zsh -li" # reload zsh

take() { mkdir -p $@ && cd $@; }                          # create and cd into a directory
cp_p() { rsync -WavP --human-readable --progress $1 $2; } # Copy w/ progress
is_installed git && function diff() { git diff --no-index --color-words "$@"; }

# READ THE FUCKING MANUAL!!
rtfm() { help $@ 2>/dev/null || man $@ 2>/dev/null || browse "http://www.google.com/search?q=$@"; }

# useful commands
alias copy_gpg_key="gpg -a --export $GPGKEY COPY"
alias copy_ssh_key="gpg --export-ssh-key $SSHKEY COPY"
alias download="aria2c --file-allocation=none -s 8 -x 8"

# browse files easily
function browse() { eval "${BROWSER} '$1'"; }

# find a process in the activity monitor
alias p="ps -eo pid,command|grep -v grep|grep -i"

# check disk space using ncdu
alias check_disk_space='sudo ncdu / --exclude=/media/* --exclude=/mnt/* --exclude=/Volumes/*'

function flushdns() {
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
}

kill_processes_on_port() {
  for port in "$@"; do
    sudo lsof -i tcp:$port | awk 'NR!=1 {print $2}' | xargs kill -9
  done
  sudo lsof -i tcp:$port
}

# fkill - kill processes - list only the ones you can kill.
kp() {
  if [ "$UID" != "0" ]; then
    _pid=$(ps -f -u $UID | sed 1d | fzf --query "$1" -m | awk '{print $2}')
  else
    _pid=$(ps -ef | sed 1d | fzf --query "$1" -m | awk '{print $2}')
  fi

  if [ -n "$_pid" ]; then
    echo $_pid | xargs kill -${1:-9}
  fi
}

# source the environment from the current directory or a git repo
function envsource() {
  local _current="$(pwd)"
  if [[ -f "./.source_me.zsh" ]]; then
    cd
    cd $_current
    echo "sourced env from current dir."
  else
    local _from="${1:-$(dirname $(git rev-parse --show-toplevel))}"
    if [[ -f "${_from}/.source_me.zsh" ]]; then
      cd $_from
      echo "sourced env from $_from"
      cd $_current
    else
      echo "Could not find the env at: ${_from}/.source_me.zsh"
    fi
  fi
}
