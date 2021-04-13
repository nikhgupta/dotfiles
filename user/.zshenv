#!/usr/bin/env zsh

source ~/.zsh/utils.sh

# dont wait for long timeouts when switching vi modes
export KEYTIMEOUT=1
setenv EDITOR vim
export GPG_TTY=$(tty)
setenv ZSH_CACHE_DIR $HOME/.zcache

# variables used through out dotfiles
setenv DOTCASTLE $HOME/.dotfiles
setenv ITSACHECKMATE $HOME/Code/ItsaCheckmate

# brew
export HOMEBREW_NO_AUTO_UPDATE=1
setenv BREW_PREFIX /usr/local
path_prepend "${BREW_PREFIX}/bin"
path_prepend "${BREW_PREFIX}/sbin"

# add custom scripts from dotcastle to $PATH
path_prepend ~/.bin

# source secret credentials
source ~/.config/user-dirs.dirs
source ~/.zsh/fzf.zsh # allow source here so that macvim can read these
source_secret $DOTCASTLE/user/.encrypted/zshenv.asc
