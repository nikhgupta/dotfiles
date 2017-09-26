#!/usr/bin/env zsh

# export CDPATH=:..:~:~/Code

# Decolorize command output - useful in scripts
alias -g NOCOLOR="| perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' | col -b"

# Share command output over HTTP
alias -g SHARE="| tee >(cat) NOCOLOR| curl -sF 'sprunge=<-' http://sprunge.us | pbcopy"
alias -g QRCODE=" | curl -sF-=\<- qrenco.de"

# Unique lines without sorting text.
# Use: uniquify somefile
#      cat somefile | uniquify
alias uniquify="awk '!x[\$0]++'"

# Get current IP
alias ip='timeout 3s echo $(curl -s ipecho.net/plain)'
# alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# Bell when IP comes online
# Use: whenup google.com
alias whenup="ping -i 60 -a "

# Use like this: cat whatever | typewrite
# alias typewrite="pv -qL 10"

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
