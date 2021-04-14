#!/usr/bin/env zsh

# => basic locales and ZSH options
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Reference: http://zsh.sourceforge.net/Doc/Release/Options.html
unsetopt rm_star_silent # Query the user on such a removal
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
typeset -U path # set $path variable to only have unique values
export MAILCHECK=0
export TERM=xterm-256color
export GREP_COLORS=31          # grep should use red for highlighting matches
export DISABLE_AUTO_TITLE=true # otherwise, causes issues with terminal inside editors

# editor
setenv VISUAL $EDITOR
setenv GUIEDITOR $EDITOR
echo $EDITOR | grep vim &>/dev/null || alias vim=$CURRENT_EDITOR
setenv BROWSER "open -a 'Google Chrome'"
browser() { eval "$BROWSER '$1'"; }
alias browse=browser

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
HELPDIR=$BREW_PREFIX/share/zsh/help

# NOTE: brew doctor complaints about putting coreutils/findutils in path
# # make sure we use gnu version of commands like ls, etc.
# # rehash -f     # gnu-utils OMZ plugin
# for package in coreutils gnu-sed gnu-tar findutils moreutils; do
#   if [[ -d $BREW_PREFIX/opt/$package/libexec/gnubin ]]; then
#     PATH="$BREW_PREFIX/opt/$package/libexec/gnubin:$PATH"
#     MANPATH="$BREW_PREFIX/opt/$package/libexec/gnuman:$MANPATH"
#   fi
# done

# dircolorsj
[[ -r $XDG_CONFIG_DIR/user-dirs.dirs ]] && source $XDG_CONFIG_DIR/user-dirs.dirs
# [[ -f ~/.dir_colors ]] && init_cache dircolors "gdircolors -b ~/.dir_colors"

# asdf, rbenv, pyenv, etc.
. $BREW_PREFIX/opt/asdf/asdf.sh
# is_installed rbenv && init_cache rbenv "rbenv init -"
# is_installed pyenv && init_cache pyenv "pyenv init -"

# ssh setup using GnuPG
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf &>/dev/null

# source other zsh scripts
source ~/.zshplugs
source ~/.zsh/aliases.zsh
source ~/.zsh/topics.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/completion.zsh
[[ -f ~/.localrc ]] && source ~/.localrc

# echo "\e[32mWelcome, Nick!\e[0m"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/postgresql@12/bin:$PATH"
