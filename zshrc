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
#   https://github.com/nikhgupta/dotfiles/blob/master/zshrc
#
#   This is the personal zsh configuration file of Nikhil Gupta.
#   While much of it is beneficial for general use, I would
#   recommend picking out the parts you want and understand.
#
#   ---
#
#   Configuration inside `~/.zshrc` is only sourced by interactive
#   shells, and hence, GUI programs like MacVim can not load any
#   configuration from this file. Please, keep that in mind.
#
# ================================================================== }}}
# Dependencies:  =================================================== {{{
#
# This configuration makes use of several programs and/or scripts, and
# is best utilized with all of the following dependencies being present
# in the system. If you prefer, you can install all these dependencies
# (if you are on a Mac or Ubuntu), by running the installer script at:
#     `./scripts/dep-installer`
#
# - homebrew (or linuxbrew on Ubuntu)
# - zsh, oh-my-zsh, and zsh-syntax-highlighting
# - cowsay, fortune, fasd and autoenv
#
# Although, you do not necessarily need to install these dependencies
# and the configuration should work without any problem.
#
# ================================================================== }}}
# Completions:   =================================================== {{{
#
# On MacOSX, completions are picked up from the Homebrew managed path at
# `/usr/local/share/zsh/site-functions`. Certain binaries like `git` do
# not add completions to this directory. However, we can always add
# a symlink for completions of these binaries in this directory.
#
# I have not tested this on Ubuntu, but we can always add a new
# directory to the `$fpath` variable, where all such completions can be
# present.
#
# Additionally, for convenience, `~/.zsh/completions` is already added
# to `$fpath`, and hence, on both MacOSX and Ubuntu, you can add your
# completions to this directory.
#
# ================================================================== }}}

# => custom functions:
source_if_exists() { [[ -s "$1" ]] && source "$1"; }
path_append()  { [[ -d "$1" ]] && PATH="$PATH:$1"; }

# => add ~/.zsh to functions' path in ZSH
#    can be used for adding completions
[[ -d ~/.zsh/completions ]] && fpath=( ~/.zsh/completions $fpath )

# => basic locales and ZSH options {{{
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
skip_global_compinit=1

# Reference: http://zsh.sourceforge.net/Doc/Release/Options.html
setopt auto_pushd               # cd pushes the old directory onto directory stack
setopt pushd_silent             # be quiet when using pushd
setopt pushd_ignore_dups        # only push unique values in directorys stack
setopt menu_complete            # complete first option when ambiguous
setopt hist_expire_dups_first   # expire older dup commands first in history
setopt hist_find_no_dups        # do not find dupes when searching history
setopt hist_ignore_space        # do not add commands with a leading space in history
setopt hist_no_store            # do not add 'history' command in history
setopt rm_star_wait             # wait for 10 seconds before accepting the answer
unsetopt rm_star_silent         # Query the user on such a removal
unsetopt nomatch
unsetopt correct_all

# other terminal related basic configuration
typeset -U path # set $path variable to only have unique values
export TERM=xterm-256color

# set the theme for our prompt
export ZSH_THEME="blinks"
# Please, don't ask to update, O! OhMyZSH. Just do it.
export DISABLE_UPDATE_PROMPT=true
# }}}
# => load OhMyZSH and some relevant plugins {{{
# plugins to be added later: emoji-clock
plugins=( brew brew-cask bundler coffee colored-man common-aliases
composer emoji-clock extract gem git git-flow git-extras github
gitignore heroku golang history-substring-search jsontools nanoc pow
powder rails rake-fast quote redis-cli vim-interaction vundle wp-cli
zsh-reload)
[[ "$OSTYPE" = darwin* ]] && plugins+=( osx )

source_if_exists $ZSH/oh-my-zsh.sh || echo '[WARN] OhMyZSH was not loaded.'
# }}}
# => brew specific configuration {{{

unalias run-help &>/dev/null
autoload run-help
HELPDIR=$BREW_PREFIX/share/zsh/help

# make sure we use gnu version of commands like ls, etc.
# rehash -f     # gnu-utils OMZ plugin
for package in coreutils gnu-sed gnu-tar; do
  if [[ -d $BREW_PREFIX/opt/$package/libexec/gnubin ]]; then
    PATH="$BREW_PREFIX/opt/$package/libexec/gnubin:$PATH"
    MANPATH="$BREW_PREFIX/opt/$package/libexec/gnuman:$MANPATH"
  fi
done

# Pear:
path_append $BREW_PREFIX/pear/bin

# Go language:
path_append $BREW_PREFIX/opt/go/libexec/bin
# }}}
# => load other relevant configurations {{{
source_if_exists $DOTCASTLE/zsh/scripts.zsh
source_if_exists $DOTCASTLE/zsh/aliases.zsh
source_if_exists $DOTCASTLE/zsh/prompt.zsh
# }}}
# => load other scripts, tools or languages {{{
# Haskell binaries:
path_append $HOME/.cabal/bin

# Android:
path_append $HOME/Code/android/ndk
path_append $HOME/Code/android/sdk/tools
path_append $HOME/Code/android/sdk/platform-tools
# }}}
# => load local configuration, if any {{{
source_if_exists ~/.zshrc.local

if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        alias $COMMAND="nocorrect $COMMAND"
    done < ~/.zsh_nocorrect
fi
# }}}
