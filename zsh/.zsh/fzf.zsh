# source fzf keybindings
export BAT_THEME=Nord
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_PREVIEW_COMMAND="$HOME/.bin/fzf-preview.zsh {}"
export FZF_DEFAULT_OPTS="
--sort 100000
--ansi
--layout=reverse
--info=inline
--height=60%
--multi
--preview-window='right:60%'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='$ ' --pointer='▶' --marker='✓'
--bind 'ctrl-\\:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-x:execute(code {+})'
"

# source fzf default config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf with previews
alias fzfpr="fzf --preview='$FZF_PREVIEW_COMMAND'"

# search for a needle in all files
alias rgc='rg -S --color=always --no-messages --hidden --smart-case -g "!{.git,node_modules,vendor}/*"'
alias rgf='rgc -l --color=never'

_fzf_compgen_path() { fd . "$1"; }
_fzf_compgen_dir() { fd --type d . "$1"; }

# quick open files with editor or visual editor
alias vf="_fuzzy_execute_command_on_files_in_directory $EDITOR ."
alias gvf="_fuzzy_execute_command_on_files_in_directory $VISUAL ."
alias vfd="_fuzzy_execute_command_on_files_in_directory $EDITOR $DOTCASTLE -H"
alias gvfd="_fuzzy_execute_command_on_files_in_directory $VISUAL $DOTCASTLE -H"
_fuzzy_execute_command_on_files_in_directory() {
  _exe=$1
  _dir=$2
  shift
  shift
  cd ${_dir:-.} && fd . -tf $@ | fzfpr --print0 | xargs -0 -o "${_exe:-vim}"
}

# fe [SEARCH TERM] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() { _fuzzy_execute_command_on_files_matching_pattern $EDITOR $@; }
gfe() { _fuzzy_execute_command_on_files_matching_pattern $VISUAL $@; }
_fuzzy_execute_command_on_files_matching_pattern() {
  _exe="$1"
  shift
  IFS=$'\n' _files=($(rgf --files | fzfpr --query "$1" --multi --select-1 --exit-0))
  [[ -n "$_files" ]] && ${_exe:-edit} "${_files[@]}"
}

# find-in-file - usage: fif <SEARCH_TERM>
fif() { _fuzzy_execute_command_on_files_containing_pattern $EDITOR $@; }
gfif() { _fuzzy_execute_command_on_files_containing_pattern $VISUAL $@; }
_fuzzy_execute_command_on_files_containing_pattern() {
  _exe="$1"
  shift
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!"
    return 1
  fi
  IFS=$'\n' _files=($(rgf --files-with-matches $@ | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"))
  [[ -n "$_files" ]] && ${_exe:-edit} "${_files[@]}"
}

# like normal z when used with arguments but displays an fzf prompt when used without.
unalias z 2>/dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
