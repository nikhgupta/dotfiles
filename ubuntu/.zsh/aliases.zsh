#!/usr/bin/env zsh
# This file contains common ZSH aliases and functions, and is split
# into several sections. Do not add private data in this file. Use
# `~/.zshrc.local` to store private aliases and functions, instead.

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
alias ls='ls -F --color=always --group-directories-first'
alias lS='ls -1FSsh | sort -r'                      # sort by size
alias lx='ls -lAFhXB'                               # sort by extension - GNU only
alias lR='ls -AFtrd *(R)'                           # show readable files
alias lRnot='ls -AFtrd *(^R)'                       # show non-readable files
alias lk=k

alias grep="grep -i --color"

# handy utils
alias du1='du -hd 1'                                # disk usage with human sizes and minimal depth (prefer: dsize)
alias fn='find . -name'                             # find files by name, in current directory
alias p="ps -eo pid,command | grep -v grep | grep -i" # find a process in the activity monitor
alias history="fc -il 1"                            # show timestamps in history

# killers
alias k9="kill -9"
alias ka9="killall -9"

# handy globals
if ! which pbcopy > /dev/null; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi
alias -g COPY=" | pbcopy"
alias -g PASTE="pbpaste | "
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ERR='2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)'

# aliases that I use, often
is_installed hub && alias git=hub
alias gem_local='gem list --local';
# copy my SSH key to the clipboard for quick pasting
alias getsshkey="cat $HOME/.ssh/`whoami`.pub COPY"
# delete all the empty files from the current directory @ use with caution
alias deleteempty="find . -type f -empty -not -regex '.*\/.git\/.*' -exec {} \; -delete"

# editor specific
alias em='emacsclient -ta ""';
alias ec='emacsclient -nca ""';
#is_installed nvim && alias  vim="nvim"
#is_installed vimr && alias gvim="vimr"
#is_installed mvim && alias  vim="mvim -v" && alias gvim="mvim"

# ruby, rails, rspec and so on..
alias rspecff='rspec --fail-fast'
alias rspecffof='rspec --fail-fast --only-failures'
alias bundled="bundle install --local || bundle install || bundle update"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# dump path - each directory on separate line
alias dumppath='echo -e ${PATH//:/\\n}'

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias badge="tput bel"

# replacements
alias fd=fdfind
alias find=fd
alias ag=rg
alias pt=rg

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

alias import_utils="source $DOTCASTLE/bin/utils.sh"
if is_macosx; then
  # other miscelleneous commands
  alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
  alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
  alias activeinterface="ifactive | grep -E 'en.*:' | cut -d ' ' -f1 | tr -d ':'"

  # View HTTP traffic
  alias sniff="sudo ngrep -d '$(activeinterface)' -t '^(GET|POST) ' 'tcp and port 80'"
  alias httpdump="sudo tcpdump -i $(activeinterface) -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

  # macOS has no `md5sum`, so use `md5` as a fallback
  command -v md5sum > /dev/null || alias md5sum="md5"

  # macOS has no `sha1sum`, so use `shasum` as a fallback
  command -v sha1sum > /dev/null || alias sha1sum="shasum"

  # Recursively delete `.DS_Store` files
  alias deletedsstore="find . -type f -name '*.DS_Store' -ls -delete"

  # Airport CLI alias
  alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

  # Kill all the tabs in Chrome to free up memory
  # [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
  alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"
fi

# alias SilverSearch to PlatinumSearcher
which pt &>/dev/null && alias ag=pt

# todo.txt
alias t='todo.sh -d ~/Documents/todo/todo.cfg'

# add aliases via command line
function addalias() {
  ALIASED="alias $1='$2';"
  echo "${ALIASED}" | tee -a $DOTCASTLE/localrc
  source $DOTCASTLE/localrc
}

# READ THE FUCKING MANUAL!!
rtfm() {
  help $@ 2&>/dev/null ||
   man $@ 2&>/dev/null ||
   browse "http://www.google.com/search?q=$@"
}

# activate/deactive proxy
proxy() {
  if [[ "$1" == "deactivate" ]]; then
    unset http_proxy
    unset http_proxy
    echo "Deactivated Terminal Proxy."
  else
    export http_proxy="http://$PROXY"
    export https_proxy="http://$PROXY"
    echo "Activated Terminal Proxy: $PROXY"
  fi
}

if which brew &>/dev/null; then
  # source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$BREW_PREFIX/share/zsh-syntax-highlighting/highlighters

  # source $BREW_PREFIX/opt/autoenv/activate.sh
fi

init_cache fasd 'fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install'

function addscript() {
  local file="$DOTCASTLE/bin/$1"
  touch $file
  chmod +x $file
  vim $file
}

# Tmux related commands are sourced from the following file
# commands: ts, tl, workon, workoff, etc.
source ~/.zsh/tmux.sh
# source_if_exists ~/.zsh/funalias.zsh
# source_if_exists ~/.zsh/usefulscripts.zsh
source_if_exists ~/.zsh/commandlinefu.zsh

# # ZSH loading measurement
# zsh_load(){ avgtime "zsh -lic 'print -P \$PROMPT \$RPROMPT'"; }
if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
  source ~/.config/exercism/exercism_completion.zsh
fi

function whois() {
  dig +nocmd $1 any +multiline +noall +answer
}

function webscreen() {
  curl -s http://image.thum.io/get/fit/600x600/$1 > ~/Desktop/$(echo $1 | md5).png
  sleep 1
  curl -s http://image.thum.io/get/fit/600x600/$1 > ~/Desktop/$(echo $1 | md5).png
}

function serve_rails() {
  local port="2$(pwd | md5sum -t | cut -d ' ' -f 1 | tr -d 'a-z' | cut -c1-4)"
  bundle exec rails server -b 0.0.0.0 -p $port
}

function ngrok() {
  _ngrokport="${1:-80}"
  _ngroksubdomain="${2}"
  echo "Usage: NGROK_SEED=<seed> ngrok <port> [subdomain]"
  if [ -z "${_ngroksubdomain}" ]; then
    _ngroksubdomain=$(echo $_ngrokport `date +%Y-%m-%d` $NGROK_SEED | sha256sum | fold -w12 | head -1)
  fi

  ssh -R $_ngroksubdomain.serveo.net:80:localhost:$_ngrokport serveo.net
}

alias rand_alphanum="cat /dev/random | head -c 200 | sha256sum - | cut -d ' ' -f 1"

# miscelleneous
alias ue='systemctl list-unit-files | grep enabled'
alias uue='systemctl --user list-unit-files | grep enabled'
alias stowlinux='stow -t $HOME -v -d $HOME/.dotfiles ubuntu --ignore=.gitconfig'
alias showspace='sudo ncdu / --exclude=/media/* --exclude=/mnt/*'

function ydlmp3() {
  destin="${2:-mixed}"
  youtube-dl --extract-audio --audio-format mp3 \
    -o "${HOME}/Music/Downloaded/$destin/%(title)s.%(ext)s" \
    --download-archive ~/.cache/youtube-dl/mp3-archive.txt $1
}

function ydlsong() {
  destin="${2:-mixed}"
  youtube-dl -o "${HOME}/Videos/Downloaded/$destin/%(title)s.%(ext)s" \
    --download-archive ~/.cache/youtube-dl/songs-archive.txt $1
}
