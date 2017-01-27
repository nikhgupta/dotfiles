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
PROMPT_BREAKPOINTS=(60 0)
PROMPT_FILE=$DOTCASTLE/zsh/prompt.zsh

# => various environment variables used within this script {{{
GIT_PS1_SHOWUPSTREAM=verbose

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}[ "
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$fg[blue]%}] "
ZSH_THEME_GIT_PROMPT_DIRTY=": %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=": %{$fg[cyan]%}✔"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✰"
# }}}
# => function: set prompt character based on repo and SSH status {{{
_set_prompt_char() {
  if  is_git; then echo -ne '± ';
  elif is_hg; then echo -ne '☿ ';
  elif is_svn; then echo -ne '⑆ ';
  fi
}
# }}}
# => function: prompt entry for time since last git commit {{{
_git_time_since_commit() {

  # Get the last commit.
  last_commit=$(command git log --pretty=format:'%at' -1 2>/dev/null)
  (( $? )) && return    # probably, not a git repo.

  now=$(date +%s)
  seconds_since_last_commit=$((now - last_commit))

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
    echo "$COLOR${DAYS}d "
  elif [ "$MINUTES" -gt 60 ]; then
    echo "$COLOR${HOURS}h${SUB_MINUTES}m "
  else
    echo "$COLOR${MINUTES}m "
  fi
}
# }}}
# => function: prompt entry for the return status of last command {{{
_return_code() { echo "%(?..%{$fg[red]%}⏎ %? %{$reset_color%})"; }
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
# Wed Oct 22 23:42:48 IST 2014:
# - added bell for commands that take more than 20 seconds to run.
_prompt_timer_precmd() {
  unset timer_show     # only show time for a single prompt
                       # i.e. ENTER in shell should reset the timer.
  local bell="%{$(echo '\a')%}"
  if [ $timer ]; then
    timer_result=$(($SECONDS - $timer))
    unset timer
    if [[ $timer_result -ge 3600 ]]; then
      let "timer_hours = $timer_result / 3600"
      let "remainder = $timer_result % 3600"
      let "timer_minutes = $remainder / 60"
      let "timer_seconds = $remainder % 60"
      timer_show="%B%F{red}${timer_hours}h${timer_minutes}m${timer_seconds}s%b${bell} "
    elif [[ $timer_result -ge 60 ]]; then
      let "timer_minutes = $timer_result / 60"
      let "timer_seconds = $timer_result % 60"
      timer_show="%B%F{yellow}${timer_minutes}m${timer_seconds}s%b${bell} "
    elif [[ $timer_result -gt 20 ]]; then
      timer_show="%B%F{green}${timer_result}s%b${bell} "
    elif [[ $timer_result -gt 5 ]]; then
      timer_show="%B%F{green}${timer_result}s%b "
    fi
  fi
}
is_installed add-zsh-hook && add-zsh-hook preexec _prompt_timer_preexec
is_installed add-zsh-hook && add-zsh-hook precmd _prompt_timer_precmd
# }}}
# => function: prompt entry for battery remaining (in percent) {{{
_battery_remaining() {
  if is_macosx; then
    battery_data=$(ioreg -rc "AppleSmartBattery")
    if echo $battery_data | grep -e '"FullyCharged"\s*=\s*Yes' &>/dev/null; then
      echo -ne "🔌 "    # fully charged
    elif echo $battery_data | grep -e '"ExternalConnected"\s*=\s*Yes' &>/dev/null; then
      echo -ne "⚡ "    # external connected
    elif echo $battery_data | grep -e '"IsCharging"\s*=\s*Yes' &>/dev/null; then
      echo -ne "⚡ "    # being charged
    else
      current=$(echo $battery_data|grep --color=never -e '"CurrentCapacity"\s*=\s*'|sed -e 's/^.*"CurrentCapacity"\ =\ //' )
      maxcapc=$(echo $battery_data|grep -e '"MaxCapacity"\s*=\s*'|sed -e 's/^.*"MaxCapacity"\ =\ //' )
      (( battery_pct = (current * 100 ) / maxcapc ))
      [[ $battery_pct -gt 20 ]] && color='yellow'
      [[ $battery_pct -gt 50 ]] && color='green'
      echo -ne "🔋 %{$fg[${color:-red}]%}[$battery_pct%%]%{$reset_color%}"
    fi
  elif is_installed acpi; then
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
# }}}
# => function: prompt entry for host and user name in SSH connection {{{
_ssh_user_info(){
  [[ -z "$SSH_CONNECTION" ]] && return
  echo -ne "%{$fg[magenta]%}%n%{$reset_color%} at "
  echo -ne "%{$fg[yellow]%}%m%{$reset_color%} in "
}
# }}}
export VIRTUAL_ENV_DISABLE_PROMPT=1
function virtualenv_prompt_info(){
  [[ -n ${VIRTUAL_ENV} ]] || return
  python -V 2>&1 | grep -E 'Python\s3\.' 2>&1 &>/dev/null && version=py3 || version=py2
  echo "\e[32m${version}${ZSH_THEME_VIRTUALENV_PREFIX:=[}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUALENV_SUFFIX:=]}\e[0m "
}

_after_prompt_all(){
  # intelligently, add a new line char in prompt
  PROMPT+='$prompt_newline'

  # == every prompt should display the following information
  # display a telephone icon when we are in a SSH session.
  [[ -n $SSH_CONNECTION ]] && PROMPT+="%{$fg[cyan]%}☎ %{$reset_color%} " # <-- CAREFUL. emoji here.

  PROMPT+='$(_set_prompt_char)'     # prompt icon for repo
  PROMPT+='$timer_show'             # time taken to run last command
  PROMPT+='$(_return_code)'         # return code for last command
  if is_macosx; then PROMPT+="%(!.!.➲) "; else PROMPT+="➲ "; fi
  before_prompt="$(printf "-"%.0s {1..${COLUMNS}})"
}

_prompt_0(){
  RPROMPT=""
  PROMPT="%{$fg[green]%}%c%{$reset_color%} " # cwd name
  _after_prompt_all
}
alias miniprompt=_prompt_0

_prompt_60(){
  PROMPT="$(_ssh_user_info)"
  PROMPT+="%{$fg_bold[cyan]%}"'${PWD/#$HOME/~}'"%{$reset_color%} "
  PROMPT+='$(git_prompt_info)$(_git_time_since_commit)'"%{$reset_color%}"
  PROMPT+='$(virtualenv_prompt_info)'"%{$reset_color%}"
  # PROMPT+='$(git_prompt_info)'"%{$reset_color%}"

  # emacs gui messes up command ouputs unless columns size is specified manually
  is_emacs && let COLUMNS=COLUMNS-2

  # NOTE: I never look at this info, anyways and this takes a 60-70ms
  # each time.
  # RPROMPT+='$(git_prompt_status)'"%{$reset_color%} "

  RPROMPT='$(_pending_jobs) '
  [[ -z "$TMUX" ]] && RPROMPT+='$(_current_time) '
  [[ -z "$TMUX" ]] && RPROMPT+='$(_battery_remaining)'

  _after_prompt_all
}

_prompt_60

precmd() {
  print -P "%{%(?.$FG[253].$FG[124])%}$before_prompt%{$reset_color%}"
}

# when in emacs, let the user know.
is_emacs && clear && echo "${txtgrn}Welcome $(whoami)!\n${txtylw}You're inside Emacs Multi-Term Z-shell.${txtrst}"
