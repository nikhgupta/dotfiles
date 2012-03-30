#!/usr/bin/env ruby
require 'rake'

desc "Hook our dotfiles into system-standard positions."
task :install do

  # dont run the installer unless private.symlink file exists
  unless File.exists?("private.symlink")
    puts "Could not find 'private.symlink' file in repository"
    puts "Please, modify and rename private.symlink.example file, before running this install"
    exit 1
  end

  # get/update submodules before installing/updating
  #system("git submodule update --init")

  # get a list of linkable files
  linkables = Dir.glob('**/**{.symlink}')

  skip_all      = false
  overwrite_all = false
  backup_all    = true

  linkables.each do |linkable|
    overwrite = false
    backup    = false
    skip      = false

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite     = true
        when 'b' then backup        = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all    = true
        when 'S' then skip_all      = true
        when 's' then skip          = true
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mkdir -p "$HOME/.backup/dotfiles" && mv "$HOME/.#{file}" "$HOME/.backup/dotfiles/.#{file}"` if backup || backup_all
    end

    system "echo \"linking file.. #{target} --> $PWD/#{linkable}\" && ln -s \"$PWD/#{linkable}\" \"#{target}\"" unless skip || skip_all
  end
end

task :uninstall do
  linkables = Dir.glob('**/**{.symlink}')

  linkables.each do |linkable|

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    # Remove all symlinks created during installation
    if File.symlink?(target)
      FileUtils.rm(target)
    end

    # Replace any backups made during installation
    if File.exists?("#{ENV["HOME"]}/.backup/dotfiles/.#{file}")
      `mv "$HOME/.backup/dotfiles/.#{file}" "$HOME/.#{file}"`
    end

  end
end

task :reload do
  puts
  system "zsh ~/.zshrc"
end

task :default => [ "install", "reload" ]
task :reinstall => [ "uninstall", "install", "reload" ]
