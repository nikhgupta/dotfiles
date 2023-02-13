#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title task next
# @raycast.mode inline
# @raycast.refreshTime 1m

# Optional parameters:
# @raycast.icon https://images.g2crowd.com/uploads/product/image/large_detail/large_detail_15928f1838f934cbd872dc2cb5da4eb1/ora.png
# @raycast.packageName TaskWarrior

# Documentation:
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

_id=$(task limit:1 | awk 'NR==4{print $1}')
echo -e "[${_id}] $(task _get $_id.project): $(task _get $_id.description)"
