#!/usr/bin/env ruby
#
# ---
# summary: Get IP address for the domain names provided.
# author: Nikhil Gupta
# status: working
# usage: domain-ip <list-of-domains>
# example: domain-ip nikhgupta.com google.com yahoo.com
# output: |
#   nikhgupta.com    62.171.184.72
#   google.com       172.217.174.238
#   yahoo.com        98.138.219.232
#

require 'optparse'
ARGV.options do |opts|
  opts.on("-h", "--help") { puts %x(list-commands #{$0}); exit(0) }
  opts.parse!
end

max_length = ARGV.max_by(&:length).length + 4

ARGV.each do |domain|
  print "#{domain}#{" " * (max_length - domain.length)}"

  result = %x(ping -c 1 -t 1 "#{domain}")

  output = result.match(/\((.*?)\)/)[1] rescue "-"
  output = "-" if result.include?("100.0% packet loss")

  puts output
end
