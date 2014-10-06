#!/usr/bin/env zsh

# Install: Homebrew {{{
if ! installed brew; then
  exit 127
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  restart_shell_message "Homebrew"
fi
# }}}
# Install: TaskWarrior {{{
# if ! installed task; then
#   brew install task
#   restart_shell_message "TaskWarrior"
# fi
# }}}
