#!/usr/bin/env sh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title task nextmodify
# @raycast.mode compact

# Optional parameters:
# @raycast.icon https://images.g2crowd.com/uploads/product/image/large_detail/large_detail_15928f1838f934cbd872dc2cb5da4eb1/ora.png
# @raycast.argument1 { "type": "text", "placeholder": "modification" }
# @raycast.packageName TaskWarrior

# Documentation:
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

_id=$(task next limit:1 | awk 'NR==4{print $1}')
echo "$(task mod $_id $@)"
