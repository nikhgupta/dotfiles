# OSX dev server specific ZSH configuration.
# ==========================================
[[ `hostname` == 'MacBookPro.local' && `uname -a` =~ 'Darwin' ]] || return

# make sure we use gnu version of commands like ls, etc.
add_to_path_nicely "/usr/local/opt/coreutils/libexec/gnubin" at_start
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# add paths created by heroku toolbelt
add_to_path_nicely "/usr/local/heroku/bin" at_start

# add custom php
if which brew &>/dev/null; then
    add_to_path_nicely "$(brew --prefix josegonzalez/php/php53)/bin"
fi

# add paths for Haskell binaries
add_to_path_nicely "${HOME}/.cabal/bin"

# add paths created by homebrew
add_to_path_nicely "/usr/local/sbin" at_start
add_to_path_nicely "/usr/local/bin" at_start
