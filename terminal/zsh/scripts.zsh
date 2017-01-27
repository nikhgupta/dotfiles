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
#   https://github.com/nikhgupta/dotfiles/blob/master/zsh/scripts.zsh
#
#   This is the personal zsh configuration of Nikhil Gupta.
#   While much of it is beneficial for general use, I would recommend
#   picking out the parts you want and understand.
#
#   ---
#
#   This file contains scripts that should be sourced within our ZSH
#   configuration. Most often, scripts that are installed via brew or
#   manually will require sourcing a file, which can be added here.
#
# ================================================================== }}}

# => homebrew managed scripts:
if which brew &>/dev/null; then
  source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source $BREW_PREFIX/opt/autoenv/activate.sh
# else
#   source $ZSH/custom/plugins/zsh-syntax-highlighting
#   source $DOTCASTLE/scripts/autoenv/activate.sh
fi

if !which fasd &>/dev/null && [[ -s $DOTCASTLE/scripts/fasd/bin/fasd ]]; then
  PATH="$PATH:$DOTCASTLE/scripts/fasd/bin"
fi
init_cache fasd 'fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install'

# => load subs/scripts, along with completions
# init_cache jarvis "$DOTCASTLE/scripts/jarvis/bin/jarvis init -"

# => custom scripts
# transfer.sh
# source $DOTCASTLE/scripts/transfer.sh
