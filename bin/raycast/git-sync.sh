#!/bin/zsh -li

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title git sync
# @raycast.mode fullOutput
# @raycast.packageName NIK Workflow

# Optional parameters:
# @raycast.icon https://user-images.githubusercontent.com/343840/103776935-caa00a80-4ff5-11eb-8fe8-034299c90859.png

# Documentation:
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

_paths=(Code/dotfiles Code/plaintxt)

for _path in $_paths; do
  echo "synchronizing: ~/$_path"
  echo "==============================="
  cd ~/$_path
  git sync
  echo "-------------------------------"

  ssh cws -C "cd ~/${_path}; git sync"
  echo
done
