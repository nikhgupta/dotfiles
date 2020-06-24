#!/usr/bin/env bash

source ~/.zsh/utils.sh
[ "$#" -gt 2 ] || error "$0 takes atleast 3 arguments: $0 destin icon target [args args]"

_dir=$(dirname $1)
[[ ! -f $3 ]] && [[ ! -d $3 ]] && error "target must be a valid Unix path."
[[ ! -f $2 ]] && error "icon must be a valid Unix path."
[[ -d $1 ]] && error "destination must not be a Unix directory."
[[ ! -d $_dir ]] && error "destination must have a valid Unix directory."

_target=$(wslpath -w $3)
_icon=$(wslpath -w $2)
_path="$(wslpath -w $_dir)\\$(basename $1)"
shift; shift; shift;

_cmd="\$WshShell = New-Object -comObject WScript.Shell"
_cmd="$_cmd; \$Shortcut = \$WshShell.CreateShortcut(\"$_path.lnk\")"
_cmd="$_cmd; \$Shortcut.TargetPath = \"$_target\""
_cmd="$_cmd; \$Shortcut.IconLocation = \"$_icon\""
[ "$#" -gt 0 ] && _cmd="$_cmd; \$Shortcut.Arguments = \"$@\" "
_cmd="$_cmd; \$Shortcut.Save()"

echo $_cmd | powershell.exe &>/dev/null

[[ -f $_icon ]]
