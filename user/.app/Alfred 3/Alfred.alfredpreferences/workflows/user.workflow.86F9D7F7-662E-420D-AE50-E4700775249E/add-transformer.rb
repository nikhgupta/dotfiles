#!/usr/bin/env ruby
# encoding: utf-8

require 'yaml'
load 'alfred_feedback.rb'

items = Feedback.new
# name, command = ARGV.join(" ").split(" ---------- ")
# puts [name, command].inspect

if ARGV.any?

else
  items.add_item(title: "Add Custom Transformer", subtitle: "|a <command>")
end

# transformers = YAML.load_file('transformers.yaml')
# transformers ||= {}

if transformers.has_key?(name)
  items.add_item(title: "Filter already exists: #{name}", subtitle: "Command mapping: #{command}")
else
  transformers[name] = command
  # File.open("transformers.yaml", "w"){|f| f.puts transformers.to_yaml }
  items.add_item(title: "Filter added: #{name}", subtitle: "Command: #{command}", arg: command)
end

puts items.to_xml
# puts transformers.inspect
