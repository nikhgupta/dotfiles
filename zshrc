#!/usr/bin/env zsh

# source utils
source ~/.zsh/utils.sh

# Reference: http://zsh.sourceforge.net/Doc/Release/Options.html
unsetopt rm_star_silent       # Query the user on removing all files in a path
unsetopt nomatch
unsetopt correct_all
unsetopt flowcontrol
setopt no_beep                # do not beep
setopt auto_pushd             # cd pushes the old directory onto directory stack
setopt pushd_silent           # be quiet when using pushd
setopt pushd_ignore_dups      # only push unique values in directorys stack
setopt menu_complete          # complete first option when ambiguous
setopt hist_expire_dups_first # expire older dup commands first in history
setopt hist_find_no_dups      # do not find dupes when searching history
setopt hist_ignore_space      # do not add commands with a leading space in history
setopt hist_no_store          # do not add 'history' command in history
setopt rm_star_wait           # wait for 10 seconds before accepting the answer
setopt auto_menu              # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end
setopt pushdminus
setopt interactivecomments

# other terminal related basic configuration
typeset -U path                # set $path variable to only have unique values
export MAILCHECK=0             # no mailcheck messages
export TERM=xterm-256color     # 256 color support
export GREP_COLORS=31          # grep should use red for highlighting matches
export DISABLE_AUTO_TITLE=true # otherwise, causes issues with terminal inside editors

# set vim bindings for zsh
bindkey -v
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char # Control-h also deletes the previous char
bindkey "^U" backward-kill-line

# history
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# autosuggest
bindkey '^ ' autosuggest-execute
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

# miscelleneous
unalias run-help &>/dev/null
autoload run-help
HELPDIR=$HOMEBREW_PREFIX/share/zsh/help

# NOTE: brew doctor complaints about putting coreutils/findutils in path
# # make sure we use gnu version of commands like ls, etc.
# # rehash -f     # gnu-utils OMZ plugin
# for package in coreutils gnu-sed gnu-tar findutils moreutils; do
#   if [[ -d $HOMEBREW_PREFIX/opt/$package/libexec/gnubin ]]; then
#     PATH="$HOMEBREW_PREFIX/opt/$package/libexec/gnubin:$PATH"
#     MANPATH="$HOMEBREW_PREFIX/opt/$package/libexec/gnuman:$MANPATH"
#   fi
# done

# dircolors
[[ -r $XDG_CONFIG_DIR/user-dirs.dirs ]] && source $XDG_CONFIG_DIR/user-dirs.dirs
# [[ -f ~/.dir_colors ]] && init_cache dircolors "gdircolors -b ~/.dir_colors"

# ssh setup using GnuPG
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf --pinentry-program $HOMEBREW_PREFIX/bin/pinentry-mac &>/dev/null

# source other zsh scripts
source ~/.zshenv
source ~/.zshplugs
source ~/.zsh/aliases.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/completion.zsh
source_if_exists ~/.zshrc.local

# echo "\e[32mWelcome, Nick!\e[0m"
# path_prepend "/usr/local/opt/openjdk/bin"
# path_prepend "/usr/local/opt/postgresql@12/bin"

# FIX: use ncurses pinentry when inside SSH connection
[[ -n "$SSH_CONNECTION" || -n "$TMUX" ]] && export PINENTRY_USER_DATA="USE_CURSES=1" || true

if [ -f '/Users/nikhgupta/.bin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nikhgupta/.bin/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/nikhgupta/.bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nikhgupta/.bin/google-cloud-sdk/completion.zsh.inc'; fi

path_append ~/Code/library/flutter/bin
path_prepend ~/Code/plaintxt/bin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
