#!/usr/bin/env zsh
# Credits:       =================================================== {{{
#
#            _ _    _                       _        _
#           (_) |  | |                     | |      ( )
#      _ __  _| | _| |__   __ _ _   _ _ __ | |_ __ _|/ ___
#     | '_ \| | |/ / '_ \ / _` | | | | '_ \| __/ _` | / __|
#     | | | | |   <| | | | (_| | |_| | |_) | || (_| | \__ \
#     |_| |_|_|_|\_\_| |_|\__, |\__,_| .__/ \__\__,_| |___/
#                          __/ |     | |
#                         |___/      |_|
#                            _       _    __ _ _
#                           | |     | |  / _(_) |
#                         __| | ___ | |_| |_ _| | ___  ___
#                        / _` |/ _ \| __|  _| | |/ _ \/ __|
#                       | (_| | (_) | |_| | | | |  __/\__ \
#                        \__,_|\___/ \__|_| |_|_|\___||___/
#
#
#   Hello, I am Nikhil Gupta, and
#   You can find me at http://nikhgupta.com
#
#   You can find an online version of this file at:
#   https://github.com/nikhgupta/dotfiles/blob/master/zshenv
#
#   This is the personal zsh configuration file of Nikhil Gupta.
#   While much of it is beneficial for general use, I would
#   recommend picking out the parts you want and understand.
#
#   ---
#
#   Configuration inside `~/.zshenv` is source by both interactive and
#   not interactive shells (typically, GUI programs), and hence, MacVim
#   is able to pick configuration defined in this file. This is
#   essential, since some plugins in MacVim requires some secret
#   environment variables to be setup, as well as, rbenv support is
#   required for working with rails in VIM.
#
#   `~/.zshenv` should not contain configuration that is meant for
#   interactive shells, e.g. prompts, aliases, etc., unless o'course,
#   you want that to be so.
#
# ================================================================== }}}

# => all the dotfiles code resides here, so this will be used often
export DOTCASTLE=$HOME/Code/__dotfiles
source $DOTCASTLE/scripts/dotcastle/utils.sh

# => setup editor for ourself
export EDITOR="vim"               # aliased to `mvim -v` on OSX
export GUIEDITOR="gvim"           # aliased to `mvim` on OSX
export VISUAL="${EDITOR}"

# => other OSX dependent environment variables and mods
if is_macosx; then
  export BROWSER="open -a 'Google Chrome'"
  export BREW_PREFIX=/usr/local
  is_installed mvim && alias vim="mvim -v" && alias gvim="mvim"

  # cask should install GUI apps in /Applications on OSX
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
else
  export BROWSER="xdg-open"
  export BREW_PREFIX=$HOME/.linuxbrew
fi

export ZSH="$HOME/.oh-my-zsh" # required by OhMyZSH!
export BASE16_SHELL=$DOTCASTLE/iterm2/base16-shell

# => ensure that homebrew is in our path.
path_prepend "${BREW_PREFIX}/bin"
path_prepend "${BREW_PREFIX}/sbin"

# load rbenv and pyenv, if available
export RBENV_ROOT=$BREW_PREFIX/var/rbenv
is_installed rbenv && init_cache rbenv "rbenv init --no-rehash - zsh"

# Python environment
# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true
# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
# allow access to install python packages globally via gpip
gpip(){ PIP_REQUIRE_VIRTUALENV="" pip "$@"; }

# GO Language
export GOPATH=$HOME/Code/go
path_append $GOPATH/bin
path_append $BREW_PREFIX/opt/go/libexec/bin

# => load local configuration, if available
[[ -s ~/.zshenv.local ]] && source ~/.zshenv.local
