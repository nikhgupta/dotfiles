#!/usr/bin/env zsh
# Credits:       =================================================== {{{
#
#            _ _    _                       _        _
#           (_) |  | |                     | |      ( )
#      _ __  _| | _| |__   __ _ _   _ _ __ | |_ __ _|/ ___
#     | '_ \| | |/ / '_ \ / _` | | | | '_ \| __/ _` | / __|
#     | | | | |   <| | | | (_| | |_| | |_) | || (_| | \__ \
#     |_| |_|_|_|\_\_| |_|\__, |\__,_| .__/ \__\__,_| |___/
#                          __/ |     | |
#                         |___/      |_|
#                            _       _    __ _ _
#                           | |     | |  / _(_) |
#                         __| | ___ | |_| |_ _| | ___  ___
#                        / _` |/ _ \| __|  _| | |/ _ \/ __|
#                       | (_| | (_) | |_| | | | |  __/\__ \
#                        \__,_|\___/ \__|_| |_|_|\___||___/
#
#
#   Hello, I am Nikhil Gupta, and
#   You can find me at http://nikhgupta.com
#
#   You can find an online version of this file at:
#   https://github.com/nikhgupta/dotfiles/blob/master/zshrc
#
#   This is the personal zsh configuration of Nikhil Gupta.
#   While much of it is beneficial for general use, I would recommend
#   picking out the parts you want and understand.
#
#   ---
#
#   This file provides the prompt used by current ZSH configuration. Any
#   prompt specific configuration should be added to this file.
#
#   Inspired from:
#   - @pengwynn (http://github.com/pengwynn/dotfiles)
#   - @sjl (http://github.com/sjl/dotfiles) <stevelosh.com>
#
#   Provides the following:
#   - displays current time.
#   - displays exit status for last command.
#   - displays time taken to run last command.
#   - displays git commit status, and time since last commit.
#   - allows to switch to a really concise and alternative prompt.
#   - displays remaining battery percentage and/or charging status.
#   - displays telephone icon on SSH connection from remote machines.
#   - displays icons depending upon nature of repo, e.g. git or mercurial.
#   - displays pending jobs, if any.
#
# ================================================================== }}}

# => various environment variables used within this script {{{
GIT_PS1_SHOWUPSTREAM=verbose

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}[ "
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$fg[blue]%}] "
ZSH_THEME_GIT_PROMPT_DIRTY=": %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=": %{$fg[cyan]%}✔"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ♻"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✰"
# }}}
# => function: set prompt character based on repo and SSH status {{{
_set_prompt_char() {
  if command git log &>/dev/null; then; echo -ne '± ';
  elif command hg root &>/dev/null; then; echo -ne '☿ '; fi
}
# }}}
# => function: prompt entry for time since last git commit {{{
_git_time_since_commit() {

  command git rev-parse --git-dir &>/dev/null || return
  command git log &>/dev/null || return

  # Get the last commit.
  last_commit=`command git log --pretty=format:'%at' -1 2>/dev/null`
  now=`date +%s`
  seconds_since_last_commit=$((now-last_commit))

  # Totals
  MINUTES=$((seconds_since_last_commit / 60))
  HOURS=$((seconds_since_last_commit/3600))

  # Sub-hours and sub-minutes
  DAYS=$((seconds_since_last_commit / 86400))
  SUB_HOURS=$((HOURS % 24))
  SUB_MINUTES=$((MINUTES % 60))

  if [[ -n $(command git status -s 2>/dev/null) ]]; then
    if [ "$MINUTES" -gt 60 ]; then
      COLOR="%{$fg[red]%}"
    elif [ "$MINUTES" -gt 10 ]; then
      COLOR="%{$fg[yellow]%}"
    else
      COLOR="%{$fg[cyan]%}"
    fi
  else
    COLOR="%{$fg[green]%}"
  fi

  if [ "$HOURS" -gt 24 ]; then
    echo "$COLOR${DAYS}d"
  elif [ "$MINUTES" -gt 60 ]; then
    echo "$COLOR${HOURS}h${SUB_MINUTES}m"
  else
    echo "$COLOR${MINUTES}m"
  fi
}
# }}}
# => function: prompt entry for the return status of last command {{{
_return_code() { echo "%(?..%{$fg[red]%}↵ %? %{$reset_color%})"; }
# }}}
# => function: prompt entry for pending jobs {{{
_pending_jobs() {
  [[ $(jobs | wc -l) -gt 0 ]] && echo "%{$fg_bold[red]%}${job_nos}JP%{$reset_color%}"
}
# }}}
# => function: prompt entry for time taken to run last command {{{
_prompt_timer_preexec() {
  unset timer_show
  timer=${timer:-$SECONDS}
}
_prompt_timer_precmd() {
  if [ $timer ]; then
    timer_result=$(($SECONDS - $timer))
    unset timer
    if [[ $timer_result -ge 3600 ]]; then
      let "timer_hours = $timer_result / 3600"
      let "remainder = $timer_result % 3600"
      let "timer_minutes = $remainder / 60"
      let "timer_seconds = $remainder % 60"
      timer_show="%B%F{red}${timer_hours}h${timer_minutes}m${timer_seconds}s%b "
    elif [[ $timer_result -ge 60 ]]; then
      let "timer_minutes = $timer_result / 60"
      let "timer_seconds = $timer_result % 60"
      timer_show="%B%F{yellow}${timer_minutes}m${timer_seconds}s%b "
    elif [[ $timer_result -gt 5 ]]; then
      timer_show="%B%F{green}${timer_result}s%b "
    fi
  fi
}
add-zsh-hook preexec _prompt_timer_preexec
add-zsh-hook precmd _prompt_timer_precmd
# }}}
# => function: prompt entry for battery remaining (in percent) {{{
_battery_remaining() {
  if [[ "$OSTYPE" = darwin* ]]; then
    battery_data=$(ioreg -rc "AppleSmartBattery")
    if echo $battery_data | grep -e '"FullyCharged"\s*=\s*Yes' &>/dev/null; then
      echo -ne "🔌 "    # fully charged
    elif echo $battery_data | grep -e '"ExternalConnected"\s*=\s*Yes' &>/dev/null; then
      echo -ne "⚡ "    # external connected
    elif echo $battery_data | grep -e '"IsCharging"\s*=\s*Yes' &>/dev/null; then
      echo -ne "⚡ "    # being charged
    else
      current=$(echo $battery_data|grep -e '"CurrentCapacity"\s*=\s*'|sed -e 's/^.*"CurrentCapacity"\s*=\s*//' )
      maxcapc=$(echo $battery_data|grep -e '"MaxCapacity"\s*=\s*'|sed -e 's/^.*"MaxCapacity"\s*=\s*//' )
      (( battery_pct = (current * 100.0 ) /maxcapc ))
      [ $battery_pct -gt 20 ] && color='yellow'
      [ $battery_pct -gt 50 ] && color='green'
      echo -ne "🔋 %{$fg[${color:-red}]%}[$battery_pct%%]%{$reset_color%}"
    fi
  elif which acpi &>/dev/null; then
    battery_data=$(acpi 2&>/dev/null)
    if echo $battery_data | grep -e '^Battery.*Discharging' &>/dev/null; then
      battery_pct=$(echo $battery_data | cut -f2 -d ',' | tr -cd '[:digit:]')
      [ $battery_pct -gt 20 ] && color='yellow'
      [ $battery_pct -gt 50 ] && color='green'
      echo -ne "🔋 %{$fg[${color:-red}]%}[$battery_pct%%]%{$reset_color%}"
    else
      echo -ne "⚡ "    # external connected
    fi
  fi
}
# }}}
# => function: prompt entry for current time {{{
_current_time() {
  echo "$(emoji-clock) %{$fg_bold[blue]%}[%*]%{$reset_color%}"
  # echo "%{$fg_bold[blue]%}[%*]%{$reset_color%}"   # faster
}
# TODO: To be removed after upstream changes to OMZ are accepted
_git_prompt_status() {
  command git symbolic-ref HEAD &>/dev/null || return 1
  git_prompt_status
}
# }}}
# => function: print the original 'extravagent' prompt {{{
#    note: we will call these functions only once when sourcing this
#    file, and hence, all logic that is fixed when session starts should
#    go inside these functions, and things that can/do change on each
#    prompt rendering should be moved to separate functions, and
#    referenced from here.
_display_extravagent_prompt_left() {
  # display host information when inside ssh connection
  echo -ne '%{$fg[magenta]%}%n%{$reset_color%} at '
  echo -ne '%{$fg[yellow]%}%m%{$reset_color%} in '

  # display the path to current directory
  echo -ne '%{$fg_bold[cyan]%}${PWD/#$HOME/~}%{$reset_color%} '

  # display git information
  echo -ne '$(git_prompt_info)$(_git_time_since_commit)%{$reset_color%}'

  # intelligently, use a single line or a double line
  # if (( ${#PWD/#$HOME/\~} > 16 )) || [[ -n $SSH_CONNECTION ]] || command git log &>/dev/null; then echo; fi
  echo

  [[ -n $SSH_CONNECTION ]] && echo -ne "%{$fg[cyan]%}☎ %{$reset_color%} " # <-- CAREFUL. emoji here.
  echo -ne '$(_set_prompt_char)$timer_show$(_return_code)'
  echo '%(!.!.➲) '
}
_display_extravagent_prompt_right(){
  echo -ne '$(_git_prompt_status)%{$reset_color%} '
  echo -ne '$(_pending_jobs) '
  echo -ne '$(_current_time) '
  echo -ne '$(_battery_remaining)'
}
# }}}

# aliases to quickly change the prompt
alias prompt_mini="export PROMPT_TYPE=mini; source ~/.zsh/prompt.zsh"
alias prompt_reset="export PROMPT_TYPE=extravagent; source ~/.zsh/prompt.zsh"

# => display the actual prompt:
if [[ "$PROMPT_TYPE" =~ "mini" ]]; then
  export PROMPT="%{$fg[green]%}%c%{$reset_color%} %{$fg[yellow]%}$%{$reset_color%} "
  export RPROMPT=""
else
  export PROMPT="$(_display_extravagent_prompt_left)"
  export RPROMPT="$(_display_extravagent_prompt_right)"
fi
