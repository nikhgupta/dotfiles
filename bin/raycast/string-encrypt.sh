#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title string encrypt
# @raycast.mode compact

# Optional parameters:
# @raycast.icon https://user-images.githubusercontent.com/343840/103776935-caa00a80-4ff5-11eb-8fe8-034299c90859.png
# @raycast.argument1 { "type": "text", "placeholder": "secret", "optional": false }
# @raycast.argument2 { "type": "text", "placeholder": "recipient", "optional": true }
# @raycast.packageName NIK Workflow

# Documentation:
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

echo "$1" | gpg --encrypt -r "${2:-me@nikhgupta.com}" --armor | base64 -b 64 >/tmp/$$.asc
cat /tmp/$$.asc | pbcopy
echo "Copied PGP string to clipboard"
rm -f /tmp/$$.asc
