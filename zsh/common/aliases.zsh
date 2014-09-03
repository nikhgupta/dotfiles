#!/usr/bin/env zsh

# quickly reload this file
alias reload=" source $HOME/.zshrc"

# create a handy edit command
alias edit="$EDITOR"
alias e=edit

# zsh related aliases
alias zshconfig="edit $ZSH_DIR/zshrc"                 # quickly edit zsh configuration
alias zshedit="edit $ZSH_DIR"

# common and most-often used aliases
# NOTE: use CTRL-K instead.
alias clear=" clear"
alias cl=" clear"
alias c=" clear"                                    # i love my terminal to be clutterfree most of the times ;)

# common commands
alias rm="rm -i"                                    # failsafe :P

# chmod
alias w+="sudo chmod +w"                            # quickly make a file writeable
alias w-="sudo chmod -w"                            # quickly make a file un-writeable
alias x+="sudo chmod +x"                            # quickly make a file executable
alias x-="sudo chmod -x"                            # quickly make a file un-executable

# ls
alias ls='\ls -F --color=always'                    # append indicators and colorize
alias la='ls -A'                                    # almost all
alias ll='la -lF'                                   # almost all, long listing, indicators
alias  l="ll -h"                                    # almost all, show size in K, M, G (except . & ..), long listing
alias lk='ll -Sr'                                   # sort by size
alias lr='ll -R'                                    # recursive ls
alias lx='ll -XB'                                   # sort by extension

# cd
alias up=" cd .."                                   # handy shortcut to quicly move up directory tree

alias du1='du -hd 1'                                # disk usage with human sizes and minimal depth (prefer: dsize)
alias fn='find . -name'                             # find files by name, in current directory
alias hi='history | tail'                           # display last commands entered in shell

# show progress for file copy (even on local)
# probably, wont really use unless transferring data in the range of above a GB
alias copy_progress="rsync --progress -ravz"

# python
# allow PIP to run on system Python, when explicitely told to do so.
# alias syspip="PIP_REQUIRE_VIRTUALENV='' pip"

# ### essential aliases ###
# find a process in the activity monitor
alias p=" ps auwwx | grep"
# delete all the empty files from the current directory @ use with caution
alias deleteempty="find . -type d -empty -not -regex '.*\/.git\/.*' -exec {} \; -delete"
alias find_gem='gem list --local | grep';
alias gffs='git flow feature start';
alias gfff='git flow feature finish';
alias merge='rsync -rupW --progress';
alias be="bundle exec"
