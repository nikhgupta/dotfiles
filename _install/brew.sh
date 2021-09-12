#!/usr/bin/env bash

_root=$(dirname $(dirname $0))
source $_root/zsh/utils.sh
export HOMEBREW_NO_AUTO_UPDATE=1

highlight "Installing/Upgrading brew"
is_installed brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
HOMEBREW_NO_AUTO_UPDATE= brew upgrade

highlight "Installing utilities using brew"
brew install antibody
brew install aria2
brew install automake
brew install cmake
brew install coreutils
brew install curl
brew install fasd
brew install fd
brew install ffmpeg
brew install findutils
brew install fzf
brew install git
brew install gnu-sed
brew install gnu-tar
brew install gnupg
brew install htop
brew install imagemagick
brew install ispell
brew install jq
brew install koekeishiya/formulae/skhd
brew install koekeishiya/formulae/yabai
# brew install libtool
brew install lunchy
# brew install media-info
# brew install moreutils
brew install mpc
brew install mpd
# brew install mysql
brew install ncdu
brew install ncmpcpp
brew install ntfs-3g
brew install openssh
brew install openssl
brew install pinentry-mac
brew install postgresql
brew install pv
brew install rclone
brew install readline
brew install reattach-to-user-namespace
brew install redis
brew install rename
brew install ripgrep
brew install rsync
brew install sqlite
# brew install sshfs
brew install svn
brew install terminal-notifier
brew install tmux
brew install tmuxinator
brew install wget
brew install youtube-dl
brew install zsh
# brew install fontconfig
# brew install freetype
# brew install ta-lib
# brew install unison
# brew install weechat
brew tap heroku/brew && brew install heroku

highlight "Installing apps/casks using brew"
# brew install alacritty
brew install alfred
brew install atom
# brew install dropbox
brew install google-chrome
# brew install iterm2
brew install kitty
brew install nvalt
# brew install osxfuse
brew install skype
brew install slack
# brew install ubersicht
brew install upwork
brew install vimr
brew install visual-studio-code
brew install vlc
brew install whatsapp
brew install qlimagesize qlmarkdown qlvideo quicklook-csv quicklook-json

highlight "Enable brew managed services"
brew tap homebrew/services
# brew services restart mysql
brew services restart postgresql
brew services restart redis

highlight "Install some fonts"
brew tap homebrew/cask-fonts
brew install font-fira-code
brew install font-fira-code-nerd-eont
brew install font-droid-sans-mono-for-powerline
brew install font-fira-mono-for-powerline
brew install font-noto-mono-for-powerline
brew install font-powerline-symbols
brew install font-source-code-pro-for-powerline

# cleanup
brew cleanup

highlight 'Switch to using brew-installed zsh as default shell'
if ! fgrep -q "${BREW_PREFIX}/bin/zsh" /etc/shells; then
  echo "${BREW_PREFIX}/bin/zsh" | sudo tee -a /etc/shells
  chsh -s "${BREW_PREFIX}/bin/zsh"
fi
