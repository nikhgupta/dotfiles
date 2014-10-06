#!/usr/bin/env zsh
# These aliases were added using `addalias` function.

# $$$ other commands
# generate a random md5 string
alias randmd5='md5 -s $RANDOM | cut -d" " -f4'

# GIT: Create a quick ZIP file from the current commit.
alias git-packup='git archive --format=zip `git describe` >> ${PWD##*/}.`git describe`.zip && echo "Current commit has been packed into a ZIP file!"';

# lock/unlock a folder for modifications @ caution, since mac doesnt display which folders are locked.
alias folder_lock='chflags uchg';
alias folder_unlock='chflags nouchg';

# Sublime Text can hang itself with the Auto-Restore-Workspace feature. This will help it recover.
# alias subl-reset='rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Settings/*';
alias gitalias='git config -l --global | grep "alias."';
alias memhogs='ps aux | tail -n +2 | sort -nr -k 4 | head';
alias wget='wget -c -t 3'; # make wget resume by default

# taken from commandlinefu.com - curated # wont be using much... :/
alias start_server="python -m SimpleHTTPServer" # serve current directory tree at port http://hostname:8000
alias current_ip="curl ifconfig.me" # get the current external ip address

# common misspellings
alias gti='git';
alias clera=' clear';
alias hg='nocorrect hg';
alias rials='rails';

alias test_apache='sudo bash -x /usr/sbin/apachectl -k restart';
alias largefiles='find . -type f -print0 | xargs -0 du -s | sort -n | tail -10 | cut -f2 | xargs -I{} du -sh {}';
alias largedirs='find . -type d -print0 | xargs -0 du -s | sort -n | tail -10 | cut -f2 | xargs -I{} du -sh {}';
alias mi='movier find -vk';
alias irb='irb -E UTF-8:UTF-8';
# alias diary='mvim /JukeBox/Dustbin/Folders/Journal/Diary/';
# alias journal='mvim /JukeBox/Dustbin/Folders/Journal/';
alias be='bundle exec';
# alias em='emacsclient -ta ""';
# alias ec='emacsclient -ca ""';
# alias composer='/usr/local/bin/composer.phar';

# create quick notes/journal
# BUG: commands output 'nil' at command line
# alias task="emacsclient -cta '' -e '(org-capture nil \"t\")'"
# alias journal="emacsclient -cta '' -e '(org-capture nil \"j\")'"
alias artisan='php artisan';
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome';
