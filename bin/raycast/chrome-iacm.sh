#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Chrome IACM
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🏢
# @raycast.argument1 { "type": "text", "placeholder": "url", "optional": true }

# Documentation:
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome "$1" --args --profile-email="nick@itsacheckmate.com"
