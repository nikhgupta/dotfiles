# chmod
alias w+="sudo chmod +w" # quickly make a file writeable
alias w-="sudo chmod -w" # quickly make a file un-writeable
alias x+="sudo chmod +x" # quickly make a file executable
alias x-="sudo chmod -x" # quickly make a file un-executable

# ls
alias ls='gls -F --color=always --group-directories-first'
alias la="ls -alh"             # list all files and folders
alias lS='ls -1FSsh | sort -r' # sort by size
alias lx='ls -lAFhXB'          # sort by extension - GNU only
alias lR='ls -AFtrd *(R)'      # show readable files
alias lRnot='ls -AFtrd *(^R)'  # show non-readable files

# better defaults
alias md="mkdir -p"
alias du1='du -hd 1'          # disk usage with human sizes and minimal depth (prefer: dsize)
alias history="fc -il 1"      # show timestamps in history
alias reload=" exec zsh -li"  # reload zsh

alias download="aria2c --file-allocation=none -s 8 -x 8"
take() { mkdir -p $@ && cd $@; } # create and cd into a directory
cp_p () { rsync -WavP --human-readable --progress $1 $2; } # Copy w/ progress
is_installed git && function diff() { git diff --no-index --color-words "$@"; }

# READ THE FUCKING MANUAL!!
rtfm() { help $@ NOERR || man $@ NOERR || browse "http://www.google.com/search?q=$@"; }

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() { tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX; }
