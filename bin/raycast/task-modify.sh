#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title task modify
# @raycast.mode compact

# Optional parameters:
# @raycast.icon https://images.g2crowd.com/uploads/product/image/large_detail/large_detail_15928f1838f934cbd872dc2cb5da4eb1/ora.png
# @raycast.argument1 { "type": "text", "placeholder": "ID" }
# @raycast.argument2 { "type": "text", "placeholder": "modifications", "optional": true }
# @raycast.packageName TaskWarrior

# Documentation:
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

echo "$(task $1 mod ${2:-done})"
