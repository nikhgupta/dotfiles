#!/usr/bin/env zsh
#
# Aliases that are universal to my use
#

# zsh related aliases
alias reload='source ~/.zshrc'                      # quickly reload the new shell configuration

alias zshconfig="edit ~/.zshrc"                     # quickly edit zsh configuration
alias zshprompt="edit $DOTZSH/prompt.zsh"           # quickly edit shell prompt
alias zshaliases="edit $DOTZSH/aliases.zsh"         # quickly edit shell aliases
alias zshtermalias="edit $DOTZSH/via_terminal.zsh"  # quickly edit custom aliases add from within terminal
alias zshfunctions="edit $DOTZSH/functions.zsh"     # quickly edit shell functions

# common and most-often used aliases
alias c=clear; alias cl=c; alias clr=c;             # i love my terminal to be clutterfree most of the times ;)

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

alias du1='du -hd 1'                                # disk usage with human sizes and minimal depth
alias fn='find . -name'                             # find files by name, in current directory
alias hi='history | tail -20'                       # display last 20 commands entered in shell
