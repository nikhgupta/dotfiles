# quick open files with editor or visual editor
alias vf="_fuzzy_execute_command_on_files_in_directory $EDITOR ."
alias gvf="_fuzzy_execute_command_on_files_in_directory $VISUAL ."
alias vfd="_fuzzy_execute_command_on_files_in_directory $EDITOR ~/.dotfiles --exclude Alfred.alfredpreferences"
alias gvfd="_fuzzy_execute_command_on_files_in_directory $VISUAL ~/.dotfiles --exclude Alfred.alfredpreferences"
_fuzzy_execute_command_on_files_in_directory() {
  _exe=$1; _dir=$2; shift; shift;
  _selected=$(fd . "${_dir:-.}" $@ | fzf)
  [[ -n "${_selected}" ]] && ${_exe:-vim} "${_selected}"
}

# fe [SEARCH TERM] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() { _fuzzy_execute_command_on_files_matching_pattern $EDITOR $@; }
gfe() { _fuzzy_execute_command_on_files_matching_pattern $VISUAL $@; }
_fuzzy_execute_command_on_files_matching_pattern() {
  _exe="$1"; shift
  IFS=$'\n' _files=($(rgf --files | fzfpr --query "$1" --multi --select-1 --exit-0))
  [[ -n "$_files" ]] && ${_exe:-edit} "${_files[@]}"
}

# find-in-file - usage: fif <SEARCH_TERM>
fif() { _fuzzy_execute_command_on_files_containing_pattern $EDITOR $@; }
gfif() { _fuzzy_execute_command_on_files_containing_pattern $VISUAL $@; }
_fuzzy_execute_command_on_files_containing_pattern() {
  _exe="$1"; shift;
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!"
    return 1
  fi
  IFS=$'\n' _files=($(rgf --files-with-matches $@ | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"))
  [[ -n "$_files" ]] && ${exe:-edit} "${_files[@]}"
}

# like normal z when used with arguments but displays an fzf prompt when used without.
unalias z 2>/dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
