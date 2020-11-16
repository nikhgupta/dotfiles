# encoding: UTF-8
require "json"
load "alfred_feedback.rb"

items = Feedback.new
if ARGV.any?
  items.add_item(title: "Add a custom filter", subtitle: "Command: #{ARGV.join(" ")}", arg: ARGV.join(" "))
else
  items.add_item(title: "Add a custom filter", subtitle: "Use: |a <filter-name> <filter-command>")
end

puts items.to_xml
