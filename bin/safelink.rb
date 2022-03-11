#!/usr/bin/env ruby
# frozen_string_literal: true

#
# ---
# summary: script to safely link $source to $destin

require 'optparse'
require 'fileutils'

options = { backup: true }
OptionParser.new do |parser|
  parser.on('--copy') { |_val| options.merge!(copy: true, backup: false) }
  parser.on('-n', '--dry-run') { |_val| options[:dry_run] = true }
  parser.on('-v', '--verbose') { |_val| options[:verbose] = true }
  parser.on('--no-backup') { |_val| options[:backup] = false }
  parser.on('-h', '--help') do
    puts 'Usage:'
    puts '  safelink.rb /path/to/source --dry-run'
    puts '  safelink.rb /path/to/source -n -v'
    puts '  safelink.rb /path/to/source --copy'
    puts '  safelink.rb /path/to/source --backup'
    puts '  safelink.rb /path/to/source /path/to/destin'
    puts '  safelink.rb /path/to/source /path/to/destin --copy'
    puts '  safelink.rb /path/to/source /path/to/destin --backup'
  end
end.parse!

def err(msg)
  puts "\e[31mERROR: #{msg}\e[0m"
  exit
end

def info(msg, options)
  return unless options[:verbose]

  sym = options[:dry_run] ? '#' : '✓'
  puts "\e[32m#{sym}\e[0m #{msg}\n"
end

def unless_dry_run(options)
  options[:dry_run] || yield
end

def symlink(src, dst, options)
  info "\e[35m#{src} => #{dst}\e[0m", options
  unless_dry_run(options) { FileUtils.symlink File.realpath(src), dst }
end

def move(src, dst, options)
  info "\e[33m#{src} == #{dst}\e[0m", options
  unless_dry_run(options) { FileUtils.mv src, dst }
end

def del(src, options)
  info "\e[31m#{src}\e[0m", options
  unless_dry_run(options) { FileUtils.rm src }
end

source, destin = ARGV
now = Time.now.utc.strftime('%Y%m%d%H%M%S')
destin = File.join(ENV['HOME'], ".#{File.basename(source)}") if destin.to_s.strip.empty?
backup = File.join(File.dirname(destin), "#{File.basename(destin)}.#{now}")

options[:verbose] = true if options[:dry_run]
err 'Source and destination are same.' if source == destin

if options[:copy] && options[:backup]
  err '--copy and --backup options are mutually exclusive.'
elsif ARGV.length > 2 || ARGV.empty?
  err 'Wrong number of arguments. Please, see safelink.rb --help for usage.'
end

del(destin, options) if File.symlink?(destin)
del(source, options) if options[:copy] && File.symlink?(source)

if !File.exist?(destin) || File.symlink?(destin)
  symlink source, destin, options
elsif !options[:copy] && options[:backup]
  move destin, backup, options
  symlink source, destin, options
elsif options[:copy] && !File.exist?(source)
  move destin, source, options
  symlink source, destin, options
elsif options[:copy] && File.directory?(source) && File.directory?(destin)
  move "#{destin}/*", "#{source}/*", options
  del destin, options
  symlink source, destin, options
elsif options[:copy]
  err "Source exists: #{destin}"
else
  err "Destination exists: #{source}"
end
