#!/usr/bin/env zsh

# source our utilities
source ~/.zsh/utils.sh

# => basic locales and ZSH options
setenv LANG en_US.UTF-8
setenv LC_ALL en_US.UTF-8
setenv LC_CTYPE en_US.UTF-8
setenv LANGUAGE en_US.UTF-8

# dont wait for long timeouts when switching vi modes
export KEYTIMEOUT=1
export GPG_TTY=$(tty)

# variables used through out dotfiles
setenv DOTCASTLE $HOME/.dotfiles
setenv ZSH_CACHE_DIR $HOME/.zcache

# editor and browser
setenv EDITOR nvim
setenv VISUAL vimr
setenv GUIEDITOR $EDITOR
setenv BROWSER "open -a 'Google Chrome'"

# brew
export HOMEBREW_NO_AUTO_UPDATE=1
setenv BREW_PREFIX /usr/local
path_prepend "${BREW_PREFIX}/bin"
path_prepend "${BREW_PREFIX}/sbin"

# add custom scripts from dotcastle to $PATH
path_append ~/.bin

# source secret credentials
source ~/.config/user-dirs.dirs
source ~/.zsh/fzf.zsh # allow source here so that macvim can read these
source_secret $HOME/.encrypted/zshenv.asc
