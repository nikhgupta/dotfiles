#!/usr/bin/env zsh
#
# Aliases that are universal to my use
#

# quickly reload this file
alias reload="source $HOME/.zshrc"

# create a handy edit command
alias edit="vim"

# zsh related aliases
alias zshconfig="edit $HOME/.zshrc"                 # quickly edit zsh configuration
alias zshprompt="edit $DOTZSH/prompt.zsh"           # quickly edit shell prompt
alias zshaliases="edit $DOTZSH/aliases.zsh"         # quickly edit shell aliases
alias zshtermalias="edit $DOTZSH/via_terminal.zsh"  # quickly edit custom aliases add from within terminal
alias zshfunctions="edit $DOTZSH/functions.zsh"     # quickly edit shell functions

# common and most-often used aliases
alias cl=clear; alias c=clear;                      # i love my terminal to be clutterfree most of the times ;)

# common commands
alias rm="rm -i"                                    # failsafe :P

# chmod
alias w+="sudo chmod +w"                            # quickly make a file writeable
alias w-="sudo chmod -w"                            # quickly make a file un-writeable
alias x+="sudo chmod +x"                            # quickly make a file executable
alias x-="sudo chmod -x"                            # quickly make a file un-executable

# ls
alias ls="ls -F"                                    # append indicators and colorize
alias la='ls -A'                                    # almost all
alias ll='la -lF'                                   # almost all, long listing, indicators
alias  l="ll -h"                                    # almost all, show size in K, M, G (except . & ..), long listing
alias lk='ll -Sr'                                   # sort by size
alias lr='ll -R'                                    # recursive ls
alias lx='ll -XB'                                   # sort by extension

# cd
alias up="cd .."                                    # handy shortcut to quicly move up directory tree

alias du1='du -hd 1'                                # disk usage with human sizes and minimal depth (prefer: dsize)
alias fn='find . -name'                             # find files by name, in current directory
alias hi='history | tail'                           # display last commands entered in shell

# todo.txt-cli
alias nexttask="t list +next | head -1"             # list the +next task
alias tasktop="t list | head -1"                    # later, we will create an action for this in todo.txt-cli   
alias tasklist='echo "-- Tasks @priority --" && t list | head -5 && 
                echo "-- Tasks @terminal --" && t list @terminal | head -n +3 && 
                echo "---------------------"'       # display top 5 tasks and also 3 tasks related to terminal

# aliases that alter the prompt
alias promptmini="export PROMPT_TYPE='mini'; source $DOTZSH/prompt.zsh"
alias promptnice="export PROMPT_TYPE='nice'; source $DOTZSH/prompt.zsh"
alias promptorig="export PROMPT_TYPE='orig'; source $DOTZSH/prompt.zsh"

# show progress for file copy (even on local)
# probably, wont really use unless transferring data in the range of above a GB
alias copy_progress="rsync --progress -ravz"
