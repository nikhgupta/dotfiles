#!/usr/bin/env zsh

export EDITOR="mvim -v"
export GEDITOR="mvim"
export GBROWSER="open"

# make sure we use gnu version of commands like ls, etc.
for package in coreutils gnu-sed gnu-tar; do
  add_to_path_nicely "/usr/local/opt/$package/libexec/gnubin" at_start
  MANPATH="/usr/local/opt/$package/libexec/gnuman:$MANPATH"
done

# add paths created by heroku toolbelt
# add_to_path_nicely "/usr/local/heroku/bin" at_start

# add custom php
# if which brew &>/dev/null; then
#     add_to_path_nicely "$(brew --prefix josegonzalez/php/php53)/bin"
# fi

# add paths for Haskell binaries
# add_to_path_nicely "${HOME}/.cabal/bin"

add_to_path_nicely "/usr/local/opt/go/libexec/bin"
