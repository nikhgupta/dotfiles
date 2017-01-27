#!/usr/bin/env ruby
# encoding: utf-8
# Script to measure various load times for VIM, ZSH, etc. between 2 commits.

require 'benchmark'

def run_with(ref, n = 10, &block)
  %x(git checkout master &>/dev/null)
  %x(git checkout #{ref} &>/dev/null)
  yield if block_given?                 # rehearsal
  start = Time.now
  n.times { yield if block_given? }     # real
  time_taken = (Time.now - start)/n
  %x(git checkout master &>/dev/null)
  return time_taken
end

def compare(name, prev, curr, n = 10, &block)
  [prev, curr].each do |ref|
    printf "%12s on %s: ", name, ref
    time_taken = run_with(ref, n, &block)
    print "#{"%02.3f" % time_taken}s (ran #{n} times with rehearsal)\n"
  end
end

prev, curr, times = ARGV.flatten.join(".").split(".").flatten.reject(&:empty?)
times = times.to_s.strip.empty? ? 10 : times.to_i

unless system("command git status | grep nothing &>/dev/null")
  puts "\e[31mERROR: You must commit your changes first.\e[0m"
  exit
end

compare(:zsh, prev, curr, times) do
  %x(zsh -lic 'print -P "$PROMPT $RPROMPT"' &>/dev/null)
end

compare(:vim, prev, curr, times) do
  %x(vim +q &>/dev/tty)
end

File.open("/tmp/test.rb", "w"){ |f| f.puts "puts 'hello world!'" }

compare(:vim_ruby, prev, curr, times) do
  %x(vim /tmp/test.rb +q &>/dev/tty)
end
