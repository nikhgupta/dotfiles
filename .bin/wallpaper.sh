#!/usr/bin/env bash
#
# ---
# summary: set wallpaper for different operating systems using CLI
# author: Nikhil Gupta
# usage: $0 /path/to/wallpaper.jpg

source ~/.zsh/utils.sh

change_in_macosx() {
  _path=$(realpath $1)
  sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$_path'" && killall Dock
}

change_in_gnome() {
  _path=$(realpath $1)
  gsettings set org.gnome.desktop.background picture-uri file://$_path
}

change_using_feh() {
  _path=$(realpath $1)
  feh --bg-fill $_path
  echo $_path > $HOME/.wallpaper
}

change_in_wsl() {
  _count=25
  _path=$(wslpath -w $1)
  _update="RUNDLL32.EXE USER32.DLL, UpdatePerUserSystemParameters, 1 True;"
  _count=$(printf "%${_count}s")
  _com="reg add \"HKEY_CURRENT_USER\Control Panel\Desktop\" /v Wallpaper /t REG_SZ /d ${_path} /f"
  _com="$_com; ${_count// /$_update}"
  echo $_com | powershell.exe | grep operation
}

if is_macosx; then
  change_in_macosx $@
elif is_ubuntu; then
  if [[ $XDG_CURRENT_DESKTOP == "ubuntu:GNOME" ]]; then
    change_in_gnome $@
  elif is_installed feh; then
    change_using_feh $@
  elif is_installed gsettings; then
    change_in_gnome $@
  fi
elif is_wsl; then
  change_in_wsl $@
fi
