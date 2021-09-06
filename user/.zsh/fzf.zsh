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

# fzf with previews
alias fzfpr="fzf --preview='$FZF_PREVIEW_COMMAND'"

# search for a needle in all files
alias rgf='rg -Sl --color=never --no-messages --hidden --smart-case -g "!{.git,node_modules,vendor}/*"'

_fzf_compgen_path() { fd . "$1"; }
_fzf_compgen_dir() { fd --type d . "$1"; }

_vf() {
  _exe=$1
  _dir=$2
  shift; shift;
  _selected=$(fd . "${_dir:-.}" $@ | fzf)
  [[ -n "${_selected}" ]] && ${_exe:-vim} "${_selected}"
}
alias vf="_vf vim ."
alias gvf="_vf vimr ."
alias vfd="vf ~/.dotfiles --exclude Alfred.alfredpreferences"
alias gvfd="gvf ~/.dotfiles --exclude Alfred.alfredpreferences"

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' _files=($(rgf --files | fzfpr --query "$1" --multi --select-1 --exit-0))
  [[ -n "$_files" ]] && ${EDITOR:-vim} "${_files[@]}"
}

# fkill - kill processes - list only the ones you can kill.
kp() {
  if [ "$UID" != "0" ]; then
    _pid=$(ps -f -u $UID | sed 1d | fzf --query "$1" -m | awk '{print $2}')
  else
    _pid=$(ps -ef | sed 1d | fzf --query "$1" -m | awk '{print $2}')
  fi

  if [ -n "$_pid" ]; then
    echo $_pid | xargs kill -${1:-9}
  fi
}

# fshow - git commit browser
git-search() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzfpr --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
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
  rgf --files-with-matches "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

# like normal z when used with arguments but displays an fzf prompt when used without.
unalias z 2>/dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
