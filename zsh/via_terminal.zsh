#!/usr/bin/env zsh

# mac specific
alias flushdns='dscacheutil -flushcache'
alias showHidden='defaults write com.apple.finder AppleShowAllFiles TRUE ; osascript -e "tell application \"Finder\" to quit"; osascript -e "tell application \"Finder\" to activate"';
alias hideHidden='defaults write com.apple.finder AppleShowAllFiles FALSE; osascript -e "tell application \"Finder\" to quit"; osascript -e "tell application \"Finder\" to activate"';
alias getsshkey="cat $SSHKEY | pbcopy"
alias deletedsstore='find . -type f -regex ".*\/\.DS_Store" -exec echo {} \; -delete'

# Aliases added from terminal
alias p="ps auwwx | grep"
alias deleteempty="find . -type d -empty -not -regex '.*\/.git\/.*' -exec {} \; -delete"
alias randmd5='md5 -s $RANDOM | cut -d" " -f4'
alias dirsearch_f='fgrep -inrH';
alias dirsearch_e='egrep -inrH';
alias 5minutes="cd $SITES/lab/5minutes"
