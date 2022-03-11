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

# macos architecture
setenv _ARCH "$(arch)"

# variables used through out dotfiles
setenv DOTCASTLE $HOME/.dotfiles
setenv ZSH_CACHE_DIR $HOME/.zcache

# editor and browser
setenv EDITOR nvim
setenv VISUAL neovide
setenv GUIEDITOR $EDITOR
setenv BROWSER "open -a 'Google Chrome'"

# brew
is_intel_macos && _PREFIX="/usr/local" || _PREFIX="/opt/homebrew"
setenv HOMEBREW_PREFIX $_PREFIX
setenv HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
setenv HOMEBREW_REPOSITORY $HOMEBREW_PREFIX
setenv MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:";
setenv INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";
setenv HOMEBREW_NO_AUTO_UPDATE 1
path_prepend "${HOMEBREW_PREFIX}/bin"
path_prepend "${HOMEBREW_PREFIX}/sbin"
alias brew="${HOMEBREW_PREFIX}/bin/brew"

# asdf, rbenv, pyenv, etc.
. $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
path_prepend $(yarn global bin)
# is_installed rbenv && init_cache rbenv "rbenv init -"
# is_installed pyenv && init_cache pyenv "pyenv init -"
# [[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# add custom scripts from dotcastle to $PATH
path_append ~/.bin
path_prepend ~/.local/bin

# source secret credentials
source ~/.config/user-dirs.dirs
source ~/.zsh/fzf.zsh # allow source here so that macvim can read these
source_secret $HOME/.encrypted/zshenv.asc
# . "$HOME/.cargo/env"
