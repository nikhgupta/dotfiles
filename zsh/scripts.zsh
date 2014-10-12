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

# => source all custom dependencies
source_if_exists "$DOTCASTLE/zsh/base16-eighties.dark.sh" || \
  echo '[WARN] Base16 Shell support is missing.'

# => homebrew managed scripts:
if which brew &>/dev/null; then
  source_if_exists `brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source_if_exists `brew --prefix`/opt/autoenv/activate.sh
else
  source_if_exists $ZSH/custom/plugins/zsh-syntax-highlighting
  source_if_exists $DOTCASTLE/scripts/autoenv/activate.sh
fi

if ! which fasd &>/dev/null && [[ -s $DOTCASTLE/scripts/fasd/bin/fasd ]]; then
  PATH="$PATH:$DOTCASTLE/scripts/fasd/bin"
fi
if which fasd &>/dev/null; then eval "$(fasd --init auto)"; fi

# => load subs/scripts, along with completions
#    refer: https://github.com/basecamp/sub
for sub in `find $DOTCASTLE/scripts -maxdepth 1 -mindepth 1 -type d`; do
  if [[ -f "${sub}/libexec/$(basename $sub)-commands" ]]; then
    eval "$($sub/bin/$(basename $sub) init -)"
  else
    path_append $sub/bin
    [[ -d $sub/completions ]] && source $sub/completions/*.zsh
  fi
done
