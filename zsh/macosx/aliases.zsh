#!/usr/bin/env zsh

# flush the dns cache
# alias flushdns='dscacheutil -flushcache'
alias flushdns='sudo killall -HUP mDNSResponder'

# recursively delete all the ugly `.DS_Store` files from current directory and its children
alias deletedsstore='find . -type f -regex ".*\/\.DS_Store" -exec echo {} \; -delete'
