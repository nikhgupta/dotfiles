#!/usr/bin/env ruby
#
# ---------------------------------------------------------------------
#
#   Summary: Get IP address for the domain name provided.
#   Author:  Nikhil Gupta
#   Usage:   domain-ip <list-of-domains>
#            domain-ip nikhgupta.com google.com yahoo.com
#
# ---------------------------------------------------------------------
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
