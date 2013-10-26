#!/usr/bin/env zsh
# These aliases were added using `addalias` function.

# $$$ mac specific
# flush the dns cache
# alias flushdns='dscacheutil -flushcache'
alias flushdns='sudo killall -HUP mDNSResponder'
# show/hide the hidden files in the system
alias showHidden='defaults write com.apple.finder AppleShowAllFiles TRUE ; killall Finder';
alias hideHidden='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'; 
# copy my SSH key to the clipboard for quick pasting
alias getsshkey="cat $SSHKEY | pbcopy"
# start and stop the ftp server on Mac
alias startftp='sudo /usr/libexec/ftpd -D';
alias stopftp='sudo killall ftpd';

# $$$ other commands
# find a process in the activity monitor
alias p=" ps auwwx | grep"
# delete all the empty files from the current directory @ use with caution
alias deleteempty="find . -type d -empty -not -regex '.*\/.git\/.*' -exec {} \; -delete"
# recursively delete all the ugly `.DS_Store` files from current directory and its children
alias deletedsstore='find . -type f -regex ".*\/\.DS_Store" -exec echo {} \; -delete'
# generate a random md5 string
alias randmd5='md5 -s $RANDOM | cut -d" " -f4'

# GIT: Create a quick ZIP file from the current commit.
alias git-packup='git archive --format=zip `git describe` >> ${PWD##*/}.`git describe`.zip && echo "Current commit has been packed into a ZIP file!"';

# lock/unlock a folder for modifications @ caution, since mac doesnt display which folders are locked.
alias folder_lock='chflags uchg';
alias folder_unlock='chflags nouchg';

# Sublime Text can hang itself with the Auto-Restore-Workspace feature. This will help it recover.
# alias subl-reset='rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Settings/*';
alias find_gem='gem list --local | grep';
alias gitalias='git config -l --global | grep "alias."';
alias memhogs='ps aux | tail -n +2 | sort -nr -k 4 | head';
alias wget='wget -c -t 3'; # make wget resume by default

# taken from commandlinefu.com - curated # wont be using much... :/
alias start_server="python -m SimpleHTTPServer" # serve current directory tree at port http://hostname:8000
alias current_ip="curl ifconfig.me" # get the current external ip address

# common misspellings
alias gti='git';
alias clera=' clear';
alias test_apache='sudo bash -x /usr/sbin/apachectl -k restart';
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC';
alias largefiles='find . -type f -print0 | xargs -0 du -s | sort -n | tail -10 | cut -f2 | xargs -I{} du -sh {}';
alias largedirs='find . -type d -print0 | xargs -0 du -s | sort -n | tail -10 | cut -f2 | xargs -I{} du -sh {}';
alias mi='movier find -vk';
alias irb='irb -E UTF-8:UTF-8';
alias sculptor='thor';
alias tlmgr='/usr/local/texlive/2012basic/bin/universal-darwin/tlmgr';
alias pbgist='jist -Ppo';
# alias diary='mvim /JukeBox/Dustbin/Folders/Journal/Diary/';
# alias journal='mvim /JukeBox/Dustbin/Folders/Journal/';
alias mate='mate -w'
alias be='bundle exec';
alias em='emacsclient -ta ""';
alias ec='emacsclient -ca ""';
alias composer='/usr/local/bin/composer.phar';
