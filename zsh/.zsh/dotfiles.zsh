#!/usr/bin/env zsh

# quickly create a script that is available globally
create_bin_script() {
  local file="$HOME/.bin/$1"
  touch "$file"
  chmod +x "$file"
  vim "$file"
}

# Update antibody config
update_antibody_config() {
  antibody bundle <~/.zsh/plugs.txt >~/.zsh/plugs
}

# check that our XDG dirs are correctly set.
check_xdg_directories() {
  for _var in $(
    typeset -p |
      grep -E "export XDG_.*_(DIR|HOME)=" |
      cut -d ' ' -f2 | cut -d '=' -f1
  ); do
    _rpath="$(eval echo \${$_var})"
    _dir="$(realpath "$_rpath" 2>/dev/null)"
    [[ -z "${_dir}" ]] && _dir="$_rpath"
    [[ -d "${_dir}" ]] && echo -e "\e[32m$_var ===== $_dir" || echo -e "\e[31m$_var ==!== $_dir"
  done
}
