#!/home/nikhgupta/.asdf/shims/ruby
# frozen_string_literal: true

# !/usr/bin/env ruby
#
# ---
# summary: Search font-awesome icons for a given search term

require 'pry'
require 'yaml'
require 'open-uri'
require 'fileutils'

cache = File.join(ENV['HOME'], '.cache', 'scripts', 'icon-search')
recent = File.join('/', 'tmp', 'scripts', 'recent.txt')
FileUtils.mkdir_p cache

def sanitize(str)
  str.to_s.downcase.gsub(/[^a-z0-9\-]/, '-')
end

def add_item(items, name, code)
  name = sanitize(name)
  items[name] = [] unless items.key?(name)
  items[name].push(code)
  items[name] = items[name].uniq
end

# parse and cache fontawesome-4 icons
path4 = File.join(cache, '4.yaml')
unless File.exist?(path4)
  items = {}
  url = 'https://raw.githubusercontent.com/FortAwesome/Font-Awesome/v4.7.0/src/icons.yml'
  data = YAML.safe_load(URI.open(url).read)
  data['icons'].map do |val|
    add_item items, val['id'], val['unicode']
    add_item items, val['name'], val['unicode']
    add_item(items, val['id'].split('-').first, val['unicode'])
    add_item(items, val['name'].split('-').first, val['unicode'])
    (val['filter'] || []).each { |i| add_item items, i, val['unicode'] }
  end
  File.open(path4, 'w') { |f| f.puts items.to_yaml }
  puts 'Cached fontawesome-4 icons..'
end

# parse and cache fontawesome-5 icons
path5 = File.join(cache, '5.yaml')
unless File.exist?(path5)
  items = {}
  url = 'https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/metadata/icons.yml'
  data = YAML.safe_load(URI.open(url).read)
  data.map do |key, val|
    add_item items, key, val['unicode']
    add_item items, val['label'], val['unicode']
    add_item(items, key.split('-').first, val['unicode'])
    add_item(items, val['label'].split('-').first, val['unicode'])
    (val['search']['terms'] || []).each { |i| add_item items, i, val['unicode'] }
  end
  File.open(path5, 'w') { |f| f.puts items.to_yaml }
  puts 'Cached fontawesome-5 icons..'
end

# parse and cache all icons data
path = File.join(cache, 'all.marshal')
unless File.exist?(path)
  data = YAML.load_file(path4)
  data = data.merge(YAML.load_file(path5))
  File.open(path, 'wb') { |f| f.puts Marshal.dump(data) }
end
data = Marshal.load(File.read(path))

# process search terms
icon = 'f17a'
ARGV.join(' ').split('-').map do |a|
  sanitize(a.strip).split('-')
end.reject { |v| v.count > 3 }.map do |a|
  a.permutation(3).to_a + a.permutation(2).to_a + a.permutation(1).to_a
end.each do |terms|
  found = []
  terms.sort_by(&:length).reverse.map do |t|
    next if t.join('-').strip.empty?

    [t,  data[t.join('-')]]
  end.compact.reject { |a| a[1].nil? }.each do |i|
    i[1].each do |j|
      found.push([i[0].length, j])
    end
  end
  next if found.empty?

  icon = found.max_by(&:first).last
  break
end

icon = [icon.to_i(16)].pack('U*')
File.open(recent, 'a') { |f| f.puts "#{ARGV.join(' ')} --_x_x_x_-- #{icon}" }

truncated = File.readlines(recent).last(100).join
File.open(recent, 'w') { |f| f.puts truncated }
print icon
