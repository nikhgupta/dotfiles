#!/usr/bin/env ruby
# coding: utf-8
#
# Script to bootstrap DotCastle, and setup dotfiles.
#
# This script will make appropriate symlinks to the dotfiles on the system,
# import your local configurations, and add git configuration options by reading
# them from environment variables.
#
# Make sure that dependencies like brew and oh-my-zsh have been installed on the
# system before running this script. You can install all dependencies by running
# the bundled `./scripts/dep-installer` script.

require 'pathname'
require 'fileutils'

module DotCastle
  PATH = ENV['DOTCASTLE'] || "#{ENV['HOME']}/Code/dotcastle"
  class << self
    def define(&block)
      @afterwards = []
      self.instance_eval(&block)
    end

    def within(name, &block)
      @module = name
      highlight "Setting up module: #{@module}"
      self.instance_eval(&block)
      puts
    end

    def on_macosx(message, &block)
      @module = nil
      return unless RUBY_PLATFORM =~ /darwin/
      highlight "[MacOSX] #{message}"
      self.instance_eval(&block)
      puts
    end

    def on_debian(message, options = {}, &block)
      [options[:unless]].flatten.each do |os|
        return if !os.to_s.strip.empty? && `uname -a`.include?(os)
      end

      @module = nil
      return unless File.exists?("/etc/debian")
      highlight "[Debian] #{message}"
      self.instance_eval(&block)
      puts
    end

    def on_debian_and_macosx(message, options = {}, &block)
      [options[:unless]].flatten.each do |os|
        return if !os.to_s.strip.empty? && `uname -a`.include?(os)
      end

      @module = nil
      return unless File.exists?("/etc/debian") || RUBY_PLATFORM =~ /darwin/
      highlight "[Debian/MacOSX] #{message}"
      self.instance_eval(&block)
      puts
    end

    def highlight(message)
      puts "👉  \e[1;32m#{message}\e[0m"
    end

    def warn(message)
      puts "\e[4;33mWarning\e[0m: #{message}"
    end

    def error(message)
      puts "\e[4;31m[ERROR]: #{message}\e[0m"
    end

    def action(message)
      puts "\e[4;34m#{message}\e[0m"
    end

    def execute(command)
      puts "Running: \e[37m;40m#{command}\e[0m"
      pipe = IO.popen command
      while (line = pipe.gets)
        print line
      end
    end

    def run_file(path, options = {})
      mod  = options.fetch(:module, @module)
      path = "#{ENV['DOTCASTLE']}/#{mod}/#{path}"
      execute "#{options.fetch(:command, "bash")} #{path}"
    end

    def require_var(name, query)
      return unless ENV[name.to_s.upcase].to_s.strip.empty?
      print "#{query} "
      ENV[name.to_s.upcase] = gets.strip
    end

    def git_config(key, var)
      execute "git config --add --global #{key} '#{ENV[var.to_s.upcase]}'"
    end

    def backup(destin)
      if File.exist?(destin)
        warn "Backing up existing: #{destin} to #{destin}.pre_dotcastle"
        system "mv '#{destin}' '#{destin}.pre_dotcastle' &>/dev/null"
      elsif File.symlink?(destin)
        warn "Removing interfering symlink: #{destin}"
        system "rm -f '#{destin}' &>/dev/null"
      end
    end

    def copy_path(name, options = {})
      destin = "#{ENV['HOME']}/.#{options.fetch(:destination, name)}"
      backup destin

      # FileUtils.mkdir_p(File.dirname(destin))
      suffix  = options.fetch(:suffix,  nil)
      command = options.fetch(:command, "cp -r")
      execute "#{command} '#{DotCastle::PATH}/#{@module}/#{name}#{suffix}' '#{destin}'"
    end

    def symlink(name, options = {})
      copy_path name, options.merge(command: "ln -sf")
    end

    def example(name, message)
      path = File.join(ENV['DOTCASTLE'], @module.to_s, "#{name}.example")
      action "Example: #{path}\n        #{message}"
    end

    def git_clone(path, url)
      path = Pathname.new(path).absolute? ? path : "#{ENV['HOME']}/.#{path}"
      if `cd #{path}; git remote show origin`.include?(url)
        warn "Skipping git clone for: #{url}"
        warn "Seems like that repository already exists in #{path}"
      else
        backup path
        execute "git clone #{url} '#{path}'"
      end
    end

    def set_environment(var, value)
      ENV[var.to_s.upcase] = value.to_s
    end

    def is_installed?(package, options = {})
      via_brew = options.fetch(:brew, false)
      command  = via_brew ? "brew list" : "which"
      system "#{command} #{package} &>/dev/null"
    end

    def download_and_run(url, options = {})
      command = options.fetch(:command, "bash -c")
      execute "#{command} \"$(curl -fsSL '#{url}')\""
    end

    def cask_install(app)
      return if RUBY_PLATFORM =~ /darwin/
      return if File.exist? "/Applications/#{app}.app"

      execute "brew cask install #{app.to_s.lowercase}"
      execute "brew cask #{app.to_s.lowercase} link"
    end

    # FIX THIS!
    def running?(name)
      system "ps auwwx | egrep '#{name}' | grep -v egrep &>/dev/null"
    end

    def install_preferences(path)
      name = File.basename(path)
      success = system "cat \"#{path}\" | plutil -convert binary1 -o \"/tmp/#{name}.#{$$}\" -"
      return unless success
      system "mv \"/tmp/#{name}.#{$$}\" \"#{ENV['HOME']}/Library/Preferences/#{name}\""
    end

    def after_setup(command)
      puts "Queued:  \e[35m#{command}\e[0m"
      @afterwards << command
    end

    def finish_setup!
      @afterwards.each{ |command| execute command }
      highlight "All set."
      highlight "You, still, need to copy your SSH and GPG keys on this machine."
    end
  end
end
