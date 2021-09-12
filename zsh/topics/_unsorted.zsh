function displays() {
  if [[ -z "$1" ]]; then
    system_profiler SPDisplaysDataType | ruby -e "
      require 'yaml';
      data=YAML.load(STDIN);
      puts data['Graphics/Displays'].map{ _2['Displays'] }.compact.map(&:keys)
    "
  else
    system_profiler SPDisplaysDataType | ruby -e "
      require 'yaml';
      data=YAML.load(STDIN);
      puts data['Graphics/Displays'].map{ _2['Displays'] }.compact.map{ |a| a.map{_2['$1']}}"
  fi
}

tmuxkill() {
  tmux list-panes -s -F "#{pane_pid} #{pane_current_command}" | grep -v tmux | awk '{print $1}' | xargs kill
}

function play-in-iina() {
  rgf --files | fzf --query "$1" --multi --select-1 --bind "ctrl-x:execute(iina {})" --preview-window=down,0% --print0 | xargs -0 -o iina
}
