#!/usr/bin/env zsh
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

# zmodload zsh/zprof

# => all the dotfiles code resides here, so this will be used often
export DOTCASTLE=$HOME/.dotfiles
source ~/.zsh/utils.sh
setenv DOTCASTLE $DOTCASTLE

# => setup editor for ourself
setenv CURRENT_EDITOR 'vim'
# setenv CURRENT_EDITOR "emacsclient -a ''"
setenv EDITOR    $CURRENT_EDITOR
setenv VISUAL    $CURRENT_EDITOR
setenv GUIEDITOR $CURRENT_EDITOR
setenv TERMINAL  kitty
echo $CURRENT_EDITOR | grep vim &>/dev/null || alias vim=$CURRENT_EDITOR
# setenv BROWSER   "open -a 'Google Chrome'"
# browser(){ eval "$BROWSER '$1'"; }; alias browse=browser

# dont wait for long timeouts when switching vi modes
export KEYTIMEOUT=1

# => other OSX dependent environment variables and mods
export HOMEBREW_NO_AUTO_UPDATE=1
if is_macosx; then
  setenv BREW_PREFIX /usr/local
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
else
  setenv BREW_PREFIX /home/linuxbrew/.linuxbrew
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

setenv ZSH "$HOME/.oh-my-zsh" # required by OhMyZSH!

# => load local configuration, if available
# ssh-add $HOME/.ssh/`whoami` &>/dev/null || echo "SSH identity could not be added!"
source_if_exists ~/.zshenv.local
source_if_exists ~/.localrc
export GPG_TTY=$(tty)

# load rbenv and pyenv, if available
export WORKON_HOME=~/.venv
export PROJECT_HOME=~/Code/python/workspace
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
setenv RBENV_ROOT $HOME/.rbenv
setenv PYENV_ROOT $HOME/.pyenv
path_prepend $PYENV_ROOT/bin
path_prepend $RBENV_ROOT/bin
# eval "$(rbenv init --no-rehash - zsh)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
is_installed rbenv && init_cache rbenv "rbenv init --no-rehash - zsh"
is_installed pyenv && init_cache pyenv "pyenv init - zsh"
is_installed pyenv-virtualenv && init_cache pyenv-virtualenv "pyenv virtualenv-init -"
gpip(){ PIP_REQUIRE_VIRTUALENV="" pip "$@"; }
gpip3(){ PIP_REQUIRE_VIRTUALENV="" pip3 "$@"; }

# required by spacevim to function properly
export PYTHON_HOST_PROG="$HOME/.pyenv/versions/neovim2/bin/python"
export PYTHON3_HOST_PROG="$HOME/.pyenv/versions/neovim3/bin/python3"

# GO Language
setenv GOPATH $HOME/.golang
path_append "${GOPATH}/bin"
path_append "${BREW_PREFIX}/opt/go/libexec/bin"
path_append ~/.composer/vendor/bin

# snaptic - ubuntu
which snap > /dev/null && path_prepend "/snap/bin"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig"

path_prepend ~/.local/bin
path_prepend ~/.bin

[[ -f ~/.config/user-dirs.dirs ]] && source ~/.config/user-dirs.dirs
[[ -f ~/.dircolors ]] && init_cache dircolors "dircolors -b ~/.dircolors"
is_installed pyenv-virtualenv && init_cache pyenv-virtualenv "pyenv virtualenv-init -"

# Erlang/Elixir
export ERL_AFLAGS="-kernel shell_history enabled"
touch ~/.iex_history # needed for up/down key support in IEx sessions