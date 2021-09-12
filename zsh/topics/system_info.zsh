# find a process in the activity monitor
alias p="ps -eo pid,command|grep -v grep|grep -i"

# Monitor processes usin top with command matching given str only:
function show_processes_matching_pattern() {
  pgrep "$1" && top $(pgrep "$1" | sed 's|^|-pid |g') || {
    echo "Found no process with name matching: $1"
    exit 1
  }
}

# check disk space using ncdu
alias check_disk_space='sudo ncdu / --exclude=/media/* --exclude=/mnt/* --exclude=/Volumes/*'

# Get current IP
alias show_ip_local="ipconfig getifaddr en0"
alias show_ip_remote='timeout 3s echo $(curl -s ipecho.net/plain)'
alias show_ip_all="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# shows apps using network currently
alias show_processes_consuming_net='lsof -PbwnR +c15 -sTCP:LISTEN -iTCP'

# List all TCP processes listening to ports on localhost
alias show_processes_on_local_ports="lsof -bwaRPiTCP@127.0.0.1 -sTCP:LISTEN"

# Find MB eating directories
alias show_files_consuming_disk="du -sm {*,.*} NOERR | sort -n|tail"

# Show active network interfaces
alias show_network_active_interfaces="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

kill_processes_on_port() {
  for port in "$@"; do; sudo lsof -i tcp:$port | awk 'NR!=1 {print $2}' | xargs kill; done
  sudo lsof -i tcp:$port
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
