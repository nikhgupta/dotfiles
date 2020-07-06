source ~/.zsh/utils.sh

if is_ubuntu || is_archlinux; then
  alias open=xdg-open
  alias pbcopy=xclip -in -selection clipboard
  alias pbpaste=xclip -out -selection clipboard
elif is_macosx; then
  echo "Nothing to do on MacOSX."
elif is_wsl; then
  alias pbcopy=clip.exe
  alias pbpaste="powershell.exe -noprofile -command Get-Clipboard"
  open() {
    _path=$(wslpath -wa $1 2>/dev/null)
    (($?)) && _path=$1
    shift
    powershell.exe -Command Start-Process "\"${_path}\"" $@
  }
fi
