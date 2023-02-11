#!/usr/bin/env zsh

# source all topic aliases
source ~/.zsh/topics/_unsorted.zsh
source ~/.zsh/topics/cryptography.zsh
source ~/.zsh/topics/dotfiles.zsh
source ~/.zsh/topics/downloaders.zsh
source ~/.zsh/topics/git.zsh
source ~/.zsh/topics/fzf.zsh
source ~/.zsh/topics/languages.zsh
source ~/.zsh/topics/macos.zsh
source ~/.zsh/topics/my_info.zsh
source ~/.zsh/topics/rails.zsh
source ~/.zsh/topics/sane.zsh
source ~/.zsh/topics/sync.zsh
source ~/.zsh/topics/system_info.zsh
source ~/.zsh/topics/tmux.zsh

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

# browse files easily
function browse() { eval "${BROWSER} '$1'" }

# backup/restore history
function backup_history() {
    mkdir -p ~/.history
    mv ~/.*_history ~/.wget-hsts ~/.lesshst  ~/.history
}

function restore_history() {
    mv ~/.history/.* ~/
}

function flushdns() {
  sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;
}

function bwgen() {
  if [[ "$1" == "-P" ]]; then
    shift
    bw generate -lun --length 25 $@ | pbcopy
  else
    bw generate -p --separator '/' --words 4 -c $@ | pbcopy
  fi
}

function download_images() {
  mkdir -p "$HOME/Pictures/Downloaded/$1"
  bbid.py -o "$HOME/Pictures/Downloaded/$1" --filters +filterui:imagesize-wallpaper "$2"
}

alias pngrok="ngrok --config ~/.config/ngrok/personal.yml"
function current_ngrok_tunnel() {
  curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url
}
