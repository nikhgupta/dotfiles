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

# editor and browser
setenv EDITOR nvim
setenv VISUAL nvim
setenv GUIEDITOR $EDITOR
setenv BROWSER "open -a 'Arc'"

# brew
_PREFIX="/opt/homebrew"
is_intel_macos && _PREFIX="/usr/local"
is_ubuntu && _PREFIX="/home/linuxbrew/.linuxbrew"
setenv HOMEBREW_PREFIX $_PREFIX
setenv HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
setenv HOMEBREW_REPOSITORY $HOMEBREW_PREFIX
setenv MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:"
setenv INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"
setenv HOMEBREW_NO_AUTO_UPDATE 1
alias brew="${HOMEBREW_PREFIX}/bin/brew"
path_prepend "${HOMEBREW_PREFIX}/bin"
path_prepend "${HOMEBREW_PREFIX}/sbin"

# asdf, rbenv, pyenv, yarn, etc.
path_append $(yarn global bin)
. $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# other apps
setenv OLLAMA_HOST "0.0.0.0"

# source secret credentials
source ~/.config/user-dirs.dirs
source ~/.zsh/fzf.zsh # allow source here so that macvim can read these
source_secret $HOME/.encrypted/zshenv.asc

# add custom scripts from dotcastle to $PATH
path_append ~/.bin/raycast ~/.bin/macos ~/.bin ~/.local/bin
