#!/usr/bin/env zsh

# Install: Homebrew {{{
if ! installed brew; then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  restart_shell_message "Homebrew"
fi
# }}}
# Install: TaskWarrior {{{
if ! installed task; then
  brew install task
  restart_shell_message "TaskWarrior"
fi
# }}}
