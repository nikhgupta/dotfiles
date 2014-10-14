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

init_cache(){
  file_name=$HOME/.init-cache/$1
  if [[ -f $file_name ]]; then
    source $file_name
  else
    mkdir -p $HOME/.init-cache
    eval "$(echo $2)" > $file_name
    source $file_name
  fi
}

# => setup editor, browser and brew location as per the OS.
if [[ "$OSTYPE" = darwin* ]]; then
  export EDITOR="mvim -v"       # use the executable provided by MacVim
  export GUIEDITOR="mvim"       # note that, symlinking mvim to vim does not work.
  export BROWSER="open"
  export BREW_PREFIX=/usr/local
  alias vim="mvim -v"
  alias gvim="mvim"
else
  export EDITOR="vim"
  export GUIEDITOR="gvim"
  export BROWSER="xdg-open"
  export BREW_PREFIX=$HOME/.linuxbrew
fi

export VISUAL=$EDITOR
# => this is required by OhMyZSH!
export ZSH="$HOME/.oh-my-zsh"

# => all the dotfiles code resides here, so this will be used often
export DOTCASTLE=$HOME/Code/__dotfiles

# => ensure that homebrew is in our path.
export PATH="$BREW_PREFIX/bin:$PATH"

# load rbenv, if available
export RBENV_ROOT=$BREW_PREFIX/var/rbenv
which rbenv &>/dev/null && init_cache rbenv "rbenv init --no-rehash - zsh"

# => load local configuration, if available
[[ -s ~/.zshenv.local ]] && source ~/.zshenv.local
