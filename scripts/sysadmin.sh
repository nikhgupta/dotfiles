#!/usr/bin/env bash

HOMEDIR=$(su - $SUDO_USER -c "echo \$HOME")
DOTCASTLE=$(su - $SUDO_USER -c "echo \$DOTCASTLE")
source $HOMEDIR/.zsh/utils.sh

enable_services() { for service in $@; do systemctl enable --now $service; done; }
yay_install() {
    if is_installed yay; then
        for package in $@; do
            su - $SUDO_USER -c "yay -aS --nocleanmenu --noeditmenu --nodiffmenu $package"
        done
    else
        action "Install AUR packages: $@"
    fi
}

highlight "Enabling some basic services"
enable_services avahi-daemon cronie NetworkManager tlp ufw sshd systemd-timesyncd bluetooth

highlight "Updating system"
pacman -Syyu
is_installed yay && yay

highlight "Enable VA-API support via Intel drivers"
pac_install libva-intel-driver libva-utils

highlight "Installing utilities and essential tools"
pac_install curl wget make zsh gvim tmux aria2 rclone ripgrep fd \
    jq inotify-tools ncdu xclip ntfs-3g ttf-fira-code timeshift \
    pkgfile kitty alacritty xorg-xsetroot noto-fonts powerline-fonts \
    feh procps-ng blueman
yay_install libinput-gestures
pkgfile --update
gpasswd -a $SUDO_USER input

highlight "Linking system related configuration files"
syslink() { ln -s $DOTCASTLE/system$1 $1; }
syslink /etc/X11/xorg.conf.d/30-touchpad.conf

highlight "Installing dependencies for web dev related stuff"
pac_install base-devel postgresql redis jre-openjdk jdk-openjdk
su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
enable_services redis postgresql
pac_install xz                                             # python
pac_install libffi libyaml openssl zlib                    # ruby
pac_install ncurses libssh unixodbc glu mesa wxgtk2 libpng # erlang

highlight "Installing useful system apps"
pac_install vlc neofetch extra/pamac-gtk pavucontrol maim weechat qutebrowser \
    telegram-desktop viewnior
yay_install google-chrome visual-studio-code-bin skypeforlinux-stable-bin \
    mailspring slack-desktop

highlight "Installing Youtube-DL"
curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl

highlight "Installing MPD && ncmpcpp"
pac_install mpd mpc mpv ncmpcpp
systemctl disable --now mpd
su - $SUDO_USER -c "mkdir ~/.mpd"
# su - $SUDO_USER -c "mkdir -p ~/Music/Playlists"
su - $SUDO_USER -c "touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpd.state}"

highlight "Adding housekeeping to cron daily"
ln -s $DOTCASTLE/user/.bin/housekeep.sh /etc/cron.daily/
