# edit some files faster
alias edit_housekeeping=" vim ~/.bin/housekeep.sh"
alias run_zsh_benchmark="$HOME/.bin/benchmark_zsh.zsh"

# quickly create a script that is available globally
create_bin_script() {
    local file="$HOME/.bin/$1"
    touch $file
    chmod +x $file
    vim $file
}

# Update antibody config
update_antibody_config() {
    antibody bundle < ~/.zsh/plugs.txt > ~/.zshplugs
}

# check that our XDG dirs are correctly set.
check_xdg_directories() {
  for _var in $(                            \
      typeset -p |                          \
      grep -E "export XDG_.*_(DIR|HOME)=" | \
      cut -d ' ' -f2 | cut -d '=' -f1       \
  ); do
    _dir="$(realpath ${(P)_var} 2>/dev/null)"
    [[ -z "${_dir}" ]] && _dir="${(P)_var}"
    [[ -d "${_dir}" ]] && echo "\e[32m$_var ===== $_dir" || echo "\e[31m$_var ==!== $_dir"
  done
}
