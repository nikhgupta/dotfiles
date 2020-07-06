#!/usr/bin/env zsh

# => basic locales and ZSH options
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LC_CTYPE=en_US.UTF-8
LANGUAGE=en_US.UTF-8

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

# set vim bindings for zsh
bindkey -v
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char # Control-h also deletes the previous char
bindkey "^U" backward-kill-line
autoload -U history-search-end
zle -N history-beginning-search-forward-end history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# autosuggest
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
bindkey '^ ' autosuggest-execute

# asdf (only needed till upstream changes in ohmyzsh are fixedo)
. $HOME/.asdf/asdf.sh
fpath=(${HOME}/.asdf/completions $fpath)

# dircolors
[[ -r ~/.config/user-dirs.dirs ]] && source ~/.config/user-dirs.dirs
[[ -f ~/.dircolors ]] && init_cache dircolors "dircolors -b ~/.dircolors"

# brew
[[ -f /home/linuxbrew/.linuxbrew/bin/brew ]] && init_cache brew "/home/linuxbrew/.linuxbrew/bin/brew shellenv"

# ssh setup using GnuPG
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf &>/dev/null

# source other zsh scripts
source ~/.zshplugs
source ~/.zsh/platform.zsh
source ~/.zsh/topics.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/fuzzy.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/completion.zsh
[[ -f ~/.localrc ]] && source ~/.localrc

# echo "\e[32mWelcome, Nick!\e[0m"
