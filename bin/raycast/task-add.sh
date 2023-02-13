#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title task add
# @raycast.mode compact
# @raycast.packageName TaskWarrior

# Optional parameters:
# @raycast.icon https://images.g2crowd.com/uploads/product/image/large_detail/large_detail_15928f1838f934cbd872dc2cb5da4eb1/ora.png
# @raycast.argument1 { "type": "text", "placeholder": "description", "optional": false }
# @raycast.argument2 { "type": "text", "placeholder": "attributes", "optional": true }

# Documentation:
# @raycast.description Capture new task in TaskWarrior
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

output=$(task add "$1" $2)
echo $output
