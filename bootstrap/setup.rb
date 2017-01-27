require_relative "dotcastle.rb"

DotCastle.define do
  highlight "DotCastle - a castle for my dotfiles"
  puts "This script will install DotCastle on this machine."
  puts "Please, follow the instructions when the script finishes."
  puts "DotCastle location: \e[35m#{ENV['DOTCASTLE']}\e[0m"
  puts

  within :git do
    symlink   :gitignore
    copy_path :gitconfig
    symlink   :template, destination: "git-template"

    require_var :editor,              "Terminal Editor you would like to use?"
    require_var :git_author_name,     "Username for your Git commits?"
    require_var :git_author_email,    "Email address for your Git commits?"
    require_var :github_user,         "Username for your Github account?"
    require_var :github_token,        "Github API token for your account?"
    require_var :git_gmail_smtp_user, "GMail SMTP user for your account?"

    git_config "core.editor", :editor
    git_config "user.name", :git_author_name
    git_config "user.email", :git_author_email
    git_config "github.user", :github_user
    git_config "github.token", :github_token
    git_config "github.password", :github_token
    git_config "github.oauth-token", :github_token
    git_config "sendmail.smtpuser", :git_gmail_smtp_user
  end

  within :terminal do
    symlink :zshrc
    symlink :zshenv
    symlink :zsh
    symlink "tmux.conf"
    example "zshenv.local", "You should add your passwords and API tokens to \e[33m~/.zshenv.local\e[0m"
  end

  within :editor do
    symlink :vim
    symlink :vimrc

    symlink "spacemacs/spacemacs", destination: :spacemacs
    git_clone "emacs.d", "https://github.com/syl20bnr/spacemacs"

    after_setup "emacs -nw --kill"
    after_setup "vim +BundleInstall +qall"
  end

  within :miscelleneous do
    symlink  :gemrc
    symlink  :powconfig
    symlink  "youtube-dl-config", destination: "config/youtube-dl/config"
  end

  on_macosx "Install Homebrew and relevant packages" do
    run_file :osxrc, module: :miscelleneous
    download_and_run "https://raw.githubusercontent.com/Homebrew/install/master/install", command: "ruby -e" unless is_installed? :brew
    set_environment :homebrew_prefix, "/usr/local"
  end

  on_debian "Install Homebrew and relevant packages", unless: "kali" do
    execute "sudo apt-get install build-essential curl git python-setuptools ruby"
    download_and_run "https://raw.githubusercontent.com/Linuxbrew/install/master/install", command: "ruby -e" unless is_installed? :brew
    set_environment :homebrew_prefix, "~/.linuxbrew"
  end

  on_debian_and_macosx "Install Brew packages", unless: "kali" do
    if is_installed? :brew
      execute "brew upgrade"
      execute "brew install git curl wget tmux zsh zsh-syntax-highlighting"
      execute "brew install fasd fortune cowsay autoenv fontconfig freetype"
      execute "brew install reattach-to-user-namespace"
      execute "brew install node npm rbenv ruby-build rbenv-ctags rbenv-vars"
      execute "brew install certbot coreutils cloc ffmpeg gnupg"
      execute "brew install mysql perl phantomjs postgresql elixir redis sqlite"
      execute "brew install the_platinum_searcher youtube-dl"
      execute "brew install vim --with-custom-ruby --with-lua"
      execute "brew tap d12frosted/emacs-plus && brew install emacs-plus && brew linkapps emacs-plus"
    else
      error "Homebrew could not be installed for some reasons."
      error "Not installing these packages: #{brew_packages}"
    end
  end

  puts
  highlight "Install OhMyZSH"
  download_and_run "http://install.ohmyz.sh"

  puts
  highlight "Install Powerline Fonts"
  git_clone "#{ENV['DOTCASTLE']}/miscelleneous/powerline-fonts", "https://github.com/Lokaltog/powerline-fonts.git"
  run_file "powerline-fonts/install.sh", module: :miscelleneous

  puts
  on_macosx "Install Brew Cask Packages" do
    execute "brew tap caskroom/cask"
    execute "brew cask install --force alfred dropbox nvalt todoist"
    execute "brew cask install --force vlc transmission"
    execute "brew cask install --force google-chrome"
    execute "brew cask install --force vimr"
  end

  on_macosx "Installing iTerm2 along with Preferences" do
    execute "brew cask install iterm2 --force"
    git_clone "#{ENV['DOTCASTLE']}/terminal/iterm2/base16-shell", "https://github.com/chriskempson/base16-shell.git"

    if ENV['TERM_PROGRAM'] == "iTerm.app"
      warn "iTerm2 preferences can only be loaded from Terminal.app"
      puts "Please, quit iTerm and run this script again from Terminal.app"
    elsif running? "iTerm\.app"
      warn "You appear to have iTerm.app running at the moment."
      puts "Please, quit iTerm and run this script again from Terminal.app"
    else
      plist = "#{ENV['DOTCASTLE']}/terminal/iterm2/com.googlecode.iterm2.plist"
      if install_preferences plist
        puts "iTerm preferences installed/updated, w00t."
      else
        warn "Conversion from XML to binary failed."
        puts "Your current iTerm2 preferences have not been changed."
      end
    end
  end

  on_macosx "Install Ubersicht and its widgets" do
    execute "brew cask install ubersicht --force"
    git_clone "#{ENV['DOTCASTLE']}/ubersicht", "https://github.com/nikhgupta/ubersicht"
    puts "Please, setup Widget path in Ubersicht to: \e[33m#{ENV['DOTCASTLE']}/ubersicht\e[0m"
  end

  finish_setup!
end
