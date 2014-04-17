#!/usr/bin/env ruby
require 'rake'

# all my (code-related) backups go inside the '__backups' directory, in a nicely structured way :)
BACKUP_DIRECTORY = "#{ENV['HOME']}/Code/__backups/__dotfiles/#{Time.now.to_i}"

# linkables - files that need to be linked/de-linked
LINKABLES = ["git/gitconfig", "git/gitignore", "localrc", "zsh/inputrc",
             "private", "ruby/gemrc", "vim/vimrc", "zsh/zshrc", "vim",
             "zsh/zshenv"]

# function adopted from @holman
# oh, and very inspiring: http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/
desc "Hook our dotfiles into system-standard positions."
task :install do

  # dont run the installer unless private.symlink file exists
  unless File.exists?("private")
    puts "Could not find 'private' file in repository"
    puts "Please, modify and rename 'private.example' file, before running this install"
    puts "You can also create a shortcut named 'private' to a file in your Dropbox ;)"
    exit 1
  end

  # get/update submodules before installing/updating
  system("git submodule update --init")

  skip_all      = false
  overwrite_all = false
  backup_all    = false

  # create our backups directory, if it does not yet exists..
  `mkdir -p "#{BACKUP_DIRECTORY}"`

  LINKABLES.each do |linkable|
    overwrite = false
    backup    = false
    skip      = false

    file = linkable.split('/').last
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
      `mv "#{target}" "#{BACKUP_DIRECTORY}/"` if backup || backup_all
    end

    puts %{echo "linking file.. #{target} --> ./#{linkable}"}
    if file == "gitconfig" && !skip && !skip_all
      FileUtils.cp(linkable, target)
      # setting configuration via git config -g will otherwise make changes to this file, which is versioned :/
    elsif !skip && !skip_all
      `ln -s "$PWD/#{linkable}" "#{target}"`
    end
  end

  # TODO: figure out a way to do this nicely from inside the install rake task
  puts "now! please run 'vim +BundleInstall +qall' in your terminal :)"
end

task :uninstall do
  LINKABLES.each do |linkable|

    file = linkable.split('/').last
    target = "#{ENV["HOME"]}/.#{file}"

    # Remove all symlinks created during installation
    if File.symlink?(target)
      FileUtils.rm(target)
    end

    # Replace any backups made during installation
    # (now obsolete - since we store backups in directories with timestamps in the name)
    # we can optionally restore the last available backups after asking the user - but laters!
    #
    # if File.exists?("#{BACKUP_DIRECTORY}/.#{file}")
    #    `mv "$HOME/.backup/dotfiles/.#{file}" "$HOME/.#{file}"`
    # end

  end
end

task :reload do
  puts
  system "zsh ~/.zshrc"
end

task :default => [ "install" ]
task :reinstall => [ "uninstall", "install", "reload" ]
