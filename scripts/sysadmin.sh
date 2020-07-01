#!/usr/bin/env bash

pac_install() { sudo pacman -S --needed --noconfirm $@; }
enable_services() { for service in $@; do sudo systemctl enable --now $service; done; }
yay_install() {
    if is_installed yay; then
        for package in $@; do
            su - $SUDO_USER -c "yay -aS --nocleanmenu --noeditmenu --nodiffmenu $package"
        done
    else
        action "Install AUR packages: $@"
    fi
}

HOMEDIR=$(eval echo ~$SUDO_USER)
source $HOMEDIR/.zsh/utils.sh

highlight "Enabling some basic services"
enable_services avahi-daemon cronie NetworkManager tlp ufw sshd systemd-timesyncd bluetooth

highlight "Updating system"
sudo pacman -Syyu
is_installed yay && yay

highlight "Installing utilities and essential tools"
pac_install curl wget make zsh vim tmux aria2 rclone ripgrep fd \
    jq inotify-tools ncdu xclip ntfs-3g ttf-fira-code

highlight "Installing dependencies for web dev setup"
pac_install base-devel
pac_install xz                                             # python
pac_install libffi libyaml openssl zlib                    # ruby
pac_install ncurses libssh unixodbc glu mesa wxgtk2 libpng # erlang

highlight "Installing other requisite packages"
pac_install postgresql redis jre-openjdk jdk-openjdk
sudo su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
enable_services redis postgresql

highlight "Installing other useful system apps"
pac_install vlc neofetch
yay_install google-chrome visual-studio-code-bin skypeforlinux-stable-bin

highlight "Installing Youtube-DL"
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

highlight "Installing MPD && ncmpcpp"
pac_install mpd mpc mpv ncmpcpp
sudo systemctl disable --now mpd
su - $SUDO_USER -c "mkdir ~/.mpd"
# su - $SUDO_USER -c "mkdir -p ~/Music/Playlists"
su - $SUDO_USER -c "touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpd.state}"
