#!/usr/bin/env bash
# ---
# summary: |
#   This script is run as `root` user to boot WSL when Windows
#   starts. Primarily, used to run commands in WSL ubuntu that
#   are normally run using systemctl on boot.
#   This script is added to Windows Task Scheduler, and currently,
#   being run 30 seconds after login to the Windows account.

service cron start
service postgresql start
su - nikhgupta -c "sed -i ~/.mpd/mpd.state -e 's/state: play/state: stopped/g'"
su - nikhgupta -c mpd
