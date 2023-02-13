#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title task list
# @raycast.mode fullOutput
# @raycast.packageName TaskWarrior

# Optional parameters:
# @raycast.icon https://images.g2crowd.com/uploads/product/image/large_detail/large_detail_15928f1838f934cbd872dc2cb5da4eb1/ora.png
# @raycast.argument1 { "type": "text", "placeholder": "filters", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "limit", "optional": true }

# Documentation:
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

task rc.defaultwidth:100 summarize $1 limit:${2:-page}
