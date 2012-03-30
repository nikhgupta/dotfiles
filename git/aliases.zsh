#!/usr/bin/env zsh

# remove deleted files from git
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"

# push master branch
alias gpom="git push origin master"
alias gphm="git push heroku master"
alias gpgm="git push gitbox master"

# push HEAD
alias gpoh="git push origin HEAD"
alias gphh="git push heroku HEAD"
alias gpgh="git push gitbox HEAD"

# push all branches
alias gpoa="git push origin --all"
alias gpha="git push heroku --all"
alias gpga="git push gitbox --all"
