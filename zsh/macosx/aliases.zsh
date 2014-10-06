#!/usr/bin/env zsh

# use the macvim version of vim with huge feature list
alias vim="mvim -v"

# flush the dns cache
# alias flushdns='dscacheutil -flushcache'
alias flushdns='sudo killall -HUP mDNSResponder'

# recursively delete all the ugly `.DS_Store` files from current directory and its children
alias deletedsstore='find . -type f -regex ".*\/\.DS_Store" -exec echo {} \; -delete'
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC';

# show/hide the hidden files in the system
alias showHidden='defaults write com.apple.finder AppleShowAllFiles TRUE ; killall Finder';
alias hideHidden='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'; 

# copy my SSH key to the clipboard for quick pasting
alias getsshkey="cat $SSH_KEY | pbcopy"
