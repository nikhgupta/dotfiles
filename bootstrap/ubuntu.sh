#!/usr/bin/env zsh

gpgdir="${1:-$HOME/OneDrive/Backup/workstation/gpg}"
source ~/.zsh/utils.sh

highlight "Checking if OneDrive is setup correctly.."
[[ -d $gpgdir ]] || {
  info "You can pass directory containing GPG keys as first argument to this script."
  error "Please, make sure that $gpgdir is available."
}

highlight "Setting up GnuPG"
sudo apt install gpg pinentry-curses
import_gnupg.sh $gpgdir
ln -sf ~/.dotfiles/.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

highlight "Using GPG for SSH authentications"
killall gpg-agent
ln -sf ~/.dotfiles/.gnupg/sshcontrol ~/.gnupg/sshcontrol
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf &>/dev/null

highlight "Checking if I can access git@github.com with newly set GPG key"
ssh -T git@github.com 2>&1 | grep $(whoami) || error "SSH from GPG did not work!"

highlight "Checking if I can source secret files.."
source_secret ~/.dotfiles/secret/zshenv.asc
source ~/.zsh/aliases.zsh

highlight "Updating the yadm repo origin URL"
yadm remote set-url origin "git@github.com:nikhgupta/dotcastle.git"

highlight "Updating system"
sudo apt-get update
sudo apt-get upgrade -y

highlight "Installing dependencies"
sudo apt install -y curl wget make \
  libssl-dev automake autoconf libreadline-dev \
  libncurses5-dev zlib1g-dev build-essential libbz2-dev \
  libsqlite3-dev libncursesw5-dev libffi-dev liblzma-dev

highlight "Installing utilities"
sudo apt install -y curl wget make zsh vim tmux aria2 \
  rclone ripgrep fd-find jq inotify-tools ncdu

highlight "Installing asdf"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
asdfin() { asdf install $@ && asdf global $@; }

highlight "Setting up global gitconfig"
cp ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.gitignore-global ~/.gitignore
git config --global core.editor $EDITOR
git config --global user.name $NICK
git config --global user.email $EMAIL
git config --global github.user $NICK
git config --global github.token $GITHUB_TOKEN
git config --global github.password $GITHUB_TOKEN
git config --global github.oauth-token $GITHUB_TOKEN
git config --global user.signingkey $GPGKEY
git config --global commit.gpgsign true

highlight "Installing VIM plugins"
vim +PlugInstall +qall

highlight "Installing required components"
sudo apt install -y postgresql redis-server default-jre default-jdk

highlight "Install homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

highlight "Install packages depending on brew"
brew install monolith

highlight "Installing node.js"
asdf plugin add nodejs
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdfin nodejs 14.4.0

highlight "Installing erlang/elixir"
asdf plugin add erlang
asdf plugin add elixir
sudo apt install -y m4 wx-common libwxgtk3.0-gtk3-dev
sudo apt install -y libxml2-utils xsltproc fop unixodbc unixodbc-dev
asdfin erlang 23.0.2
asdfin elixir 1.10.3-otp-23

highlight "Installing ruby"
asdf plugin add ruby
asdfin ruby 2.7.1

highlight "Installing python"
sudo apt install -y llvm xz-utils tk-dev python-openssl
asdf plugin add python
asdf install python 2.7.18
asdfin python 3.8.3

highlight "Installing Youtube-DL"
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

highlight "Installing AntiBody"
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin
antibody bundle <~/.zsh/plugs.txt >~/.zshplugs

highlight "Installing MPD && ncmpcpp"
sudo apt install mpd mpv ncmpcpp
mkdir .mpd
mkdir -p ~/Music/Playlists
touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpd.state}

if is_wsl; then
  highlight "Install win32yank.exe for sharing clipboard between Vim and Windows"
  curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
  unzip -p /tmp/win32yank.zip win32yank.exe >/tmp/win32yank.exe
  chmod +x /tmp/win32yank.exe
  sudo mv /tmp/win32yank.exe /usr/local/bin

  highlight "Copying WindowsTerminal configuration from backup"
  cp -r ~/.dotfiles/.config/windows/terminal/settings.json $DATA_HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json

  highlight "Creating Windows Desktop shortcut for some ncurses programs"
  $HOME/.config/windows/shortcuts/generate.sh

  highlight "Downloading PulseAudio for enabling Audio in WSL"
  wget http://bosmans.ch/pulseaudio/pulseaudio-1.1.zip -O /tmp/pulseaudio.zip
  mkdir -p /tmp/PortableApps/pulseaudio
  unzip -q /tmp/pulseaudio.zip -d /tmp/PortableApps/pulseaudio

  highlight "Copying PortableApps setup to Windows User directory"
  cp -r ~/.config/windows/scripts/startup.bat /tmp/PortableApps/startup.bat
  cp -r /tmp/PortableApps $WIN_HOME/PortableApps
fi

highlight "Checking if XDG directories are properly setup"
check_xdg_dirs

highlight "Remaining tasks.."
echo "=> You should set keygrip of SSHKEY in ~/.gnupg/sshcontrol"

if is_wsl; then
  echo "=> You should add startup script to run 30 secs after Windows Login using Windows Task Scheduler"
  echo "   The Command to add would be:"
  echo ""
  echo "      C:\Windows\System32\wscript.exe //e:jscript \"C:\Users\nikhg\PortableApps/startup.bat\""
  echo ""
  echo "!! WSL is automatically started when you login to Windows due to the above scheduled Task."
  echo "!! You can update the above startup.bat script to include commands that you want to run on Windows boot."
  echo "!! You can update ~/.config/windows/scripts/init.sh to include commands that you want to run when WSL starts."
fi
