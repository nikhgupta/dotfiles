# tmux run command
th(){ tmux split -h "$@"; }
tv(){ tmux split -v "$@"; }
tw(){ tmux new-window "$@"; }
alias tl="tmux list-sessions"
alias tko="tmux detach -a"

# start a tmux session in current directory
function ts() {
  name="${1:-$(basename $(realpath .))}"
  if tmux list-sessions | grep "${name}" >/dev/null; then
    tmux attach -t "${name}"
  else
    tmux new-session -s "${name}"
  fi
}

# work on a given tmuxinator project
function workon(){
  local session_name="${1:-$(basename $(realpath .))}"
  local other_session_name="${1:-$(basename $(dirname $(realpath .)))}"
  if tmuxinator list | grep "${session_name}" &>/dev/null; then
    tmuxinator start "${session_name}"
  elif tmuxinator list | grep "${other_session_name}" &>/dev/null; then
    tmuxinator start "${other_session_name}"
  else
    ts "${session_name}"
  fi

}

# sign off from working on a project - take some rest!
function workoff() {
  if [[ -n "${1}" ]] && tmuxinator list | grep $1 &>/dev/null; then
    tmuxinator stop $1
  else
    local session_name="$(tmux display-message -p '#S')"
    tmuxinator stop $session_name || tmux kill-session -t $session_name
  fi
}
