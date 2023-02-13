#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title string secret
# @raycast.mode compact

# Optional parameters:
# @raycast.icon https://user-images.githubusercontent.com/343840/103776935-caa00a80-4ff5-11eb-8fe8-034299c90859.png
# @raycast.argument1 { "type": "text", "placeholder": "keyword", "optional": false }
# @raycast.argument2 { "type": "text", "placeholder": "type", "optional": true }
# @raycast.packageName NIK Workflow

# Documentation:
# @raycast.author Nikhil Gupta
# @raycast.authorURL nikhgupta.com

require_relative './lib/utils'
type = ARGV[1].to_s.strip.empty? ? 'password' : ARGV[1].to_s.strip
SonicSecret.new(ARGV[0].to_s.strip).output_for(type)
