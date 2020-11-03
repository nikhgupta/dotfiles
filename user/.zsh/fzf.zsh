# source fzf keybindings
export FZF_DEFAULT_COMMAND="fd --hidden --follow"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview-window=:hidden
--preview '([[ -f {} ]] && (bat --theme=OneHalfDark --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='$ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-x:execute(code {+})'
"

_fzf_compgen_path() { fd . "$1"; }
_fzf_compgen_dir() { fd --type d . "$1"; }

# search for a needle in all files
alias rgf='rg -Sl --color=never --no-messages --hidden'

vf() { vim $(fzf); }

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' _files=($(rgf --files | fzf --query "$1" --multi --select-1 --exit-0))
  [[ -n "$_files" ]] && ${EDITOR:-vim} "${_files[@]}"
}

# fkill - kill processes - list only the ones you can kill.
kp() {
  if [ "$UID" != "0" ]; then
    _pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
    _pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi

  if [ -n "$_pid" ]; then
    echo $_pid | xargs kill -${1:-9}
  fi
}

# fshow - git commit browser
git-search() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# find-in-file - usage: fif <SEARCH_TERM>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!"
    return 1
  fi
  rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

# like normal z when used with arguments but displays an fzf prompt when used without.
unalias z 2>/dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
