#!/usr/bin/env bash
# ---
# summary: |
#   This script is run as `root` user to boot WSL when Windows
#   starts. Primarily, used to run commands in WSL ubuntu that
#   are normally run using systemctl on boot.
#   This script is added to Windows Task Scheduler, and currently,
#   being run 30 seconds after login to the Windows account.

start_service() { service $1 start; }

if [[ "$(uname -a)" = *microsoft* ]] && [[ $UID -eq 0 ]]; then
  start_service cron
  start_service postgresql
else
  echo "Startup script for WSL should be run as root user, and is meant only for Linux OS running on WSL"
  exit 127
fi
