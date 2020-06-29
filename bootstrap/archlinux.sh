#!/usr/bin/env zsh

gpgdir="${1:-$HOME/OneDrive/Backup/workstation/gpg}"
source ~/.zsh/utils.sh

pac_install() { sudo pacman -S --needed --no-confirm $@; }
enable_services() {
  for service in $@; do
    sudo systemctl start $service && sudo systemctl enable $service;
  done
}

highlight "Checking if OneDrive is setup correctly.."
[[ -d $gpgdir ]] || {
  info "You can pass directory containing GPG keys as first argument to this script."
  error "Please, make sure that $gpgdir is available."
}

highlight "Enabling some basic services"
enable_services avahi-daemon cronie NetworkManager tlp ufw sshd systemd-timesyncd bluetooth

highlight "Setting up GnuPG"
import_gnupg.sh $gpgdir
ln -sf ~/.dotfiles/.gpg-agent.conf ~/.gnupg/gpg-agent.conf

highlight "Using GPG for SSH authentications"
killall gpg-agent
ln -sf ~/.dotfiles/.gpg-sshcontrol ~/.gnupg/sshcontrol
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf &>/dev/null

highlight "Checking if I can access git@github.com with newly set GPG key"
ssh -T git@github.com 2>&1 | grep $(whoami) || error "SSH from GPG did not work!"

highlight "Checking if I can source secret files.."
source_secret ~/.dotfiles/secret/zshenv.asc
source ~/.zsh/aliases.zsh

highlight "Updating the yadm repo origin URL"
git remote set-url origin "git@github.com:nikhgupta/dotcastle.git"

highlight "Updating system"
sudo pacman -Syyu

highlight "Installing utilities"
pac_install curl wget make zsh vim tmux aria2 rclone ripgrep fd \
  jq inotify-tools ncdu xclip ntfs-3g ttf-fira-code

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

highlight "Install HyperSnazzy for Gnome-Terminal"
if is_installed gnome-terminal; then
  wget https://raw.githubusercontent.com/tobark/hyper-snazzy-gnome-terminal/master/hyper-snazzy.sh -O /tmp/hyper-snazzy.sh
  GCONFTOOL= bash /tmp/hyper-snazzy.sh
  action "Set hyper-snazzy as default profile for Gnome Terminal."
fi

highlight "Installing required components"
pac_install postgresql redis jre-openjdk jdk-openjdk
sudo su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
enable_services redis postgresql

highlight "Installing node.js"
asdf plugin add nodejs
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdfin nodejs 14.4.0

highlight "Installing erlang/elixir"
pac_install --needed base-devel
pac_install ncurses libssh unixodbc glu mesa wxgtk2 libpng
asdf plugin add erlang
asdf plugin add elixir
asdfin erlang 23.0.2
asdfin elixir 1.10.3-otp-23

highlight "Installing ruby"
pac_install libffi libyaml openssl zlib
asdf plugin add ruby
asdfin ruby 2.7.1

highlight "Installing python"
pac_install xz
asdf plugin add python
asdf install python 2.7.18
asdf install python 3.8.3
asdf global python 3.8.3 2.7.18

highlight "Installing AntiBody"
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin
antibody bundle <~/.zsh/plugs.txt >~/.zshplugs

highlight "Installing Youtube-DL"
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

highlight "Installing MPD && ncmpcpp"
pac_install mpd mpv ncmpcpp
mkdir ~/.mpd
mkdir -p ~/Music/Playlists
touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpd.state}
enable_services mpd

highlight "Checking if XDG directories are properly setup"
check_xdg_dirs

highlight "Install some more utilities.."
if is_installed yay; then
  yay -Syu
  yay -aS monolith
  yay -aS google-chrome
  yay -aS visual-studio-code-bin
fi

highlight "Remaining tasks.."
action "You should set keygrip of SSHKEY in ~/.gnupg/sshcontrol"
action "You should setup OneDrive sync locally."
action "You should setup correct entries in /etc/fstab for other drives on this machine."
action "You should setup links to various XDG Directories."
action "You should follow this link to speed up Boot: https://wiki.archlinux.org/index.php/Silent_boot"
