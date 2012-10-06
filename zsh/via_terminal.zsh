#!/usr/bin/env zsh
#
# These aliases were added using `addalias` function.

# $$$ mac specific
# flush the dns cache
alias flushdns='dscacheutil -flushcache'
# show/hide the hidden files in the system
alias showHidden='defaults write com.apple.finder AppleShowAllFiles TRUE ; killall Finder';
alias hideHidden='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'; 
# copy my SSH key to the clipboard for quick pasting
alias getsshkey="cat $SSHKEY | pbcopy"
# recursively delete all the ugly `.DS_Store` files from current directory and its children
alias deletedsstore='find . -type f -regex ".*\/\.DS_Store" -exec echo {} \; -delete'
# start and stop the ftp server on Mac
alias startftp='sudo /usr/libexec/ftpd -D';
alias stopftp='sudo killall ftpd';

# $$$ other commands
# find a process in the activity monitor
alias p="ps auwwx | grep"
# delete all the empty files from the current directory @ use with caution
alias deleteempty="find . -type d -empty -not -regex '.*\/.git\/.*' -exec {} \; -delete"
# generate a random md5 string
alias randmd5='md5 -s $RANDOM | cut -d" " -f4'

# GIT: Create a quick ZIP file from the current commit.
alias git-packup='git archive --format=zip `git describe` >> ${PWD##*/}.`git describe`.zip && echo "Current commit has been packed into a ZIP file!"';

# lock/unlock a folder for modifications @ caution, since mac doesnt display which folders are locked.
alias folder_lock='chflags uchg';
alias folder_unlock='chflags nouchg';

# Sublime Text can hang itself with the Auto-Restore-Workspace feature. This will help it recover.
alias subl-reset='rm -rf ~/Library/Application\ Support/Sublime\ Text\ 2/Settings/*';
alias find_gem='gem list --local | grep';
alias gitalias='git config -l --global | grep "alias."';
alias v='vim';
alias _v='sudo vim';
alias memhogs='ps aux | tail -n +2 | sort -nr -k 4 | head';
