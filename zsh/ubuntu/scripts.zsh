#!/usr/bin/env zsh

# Install: TaskWarrior {{{
if ! installed task; then
  sudo apt-get install task -y
  restart_shell_message "TaskWarrior"
fi
# }}}
