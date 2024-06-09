#!/usr/bin/env zsh

source ~/.zsh/utils.sh
autoload -U colors && colors
setopt promptsubst

# Updates editor information when the keymap changes.
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/◉}/(main|viins)/}"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

PROMPT_BREAKPOINTS=(60 0)
PROMPT_FILE=~/.zsh/prompt.zsh

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
# => function: prompt entry for virtual environemnt {{{
export VIRTUAL_ENV_DISABLE_PROMPT=1
function virtualenv_prompt_info(){
  [[ -n ${VIRTUAL_ENV} ]] || return
  python -V 2>&1 | grep -E 'Python\s3\.' 2>&1 &>/dev/null && version=py3 || version=py2
  echo "\e[32m${version}${ZSH_THEME_VIRTUALENV_PREFIX:=[}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUALENV_SUFFIX:=]}\e[0m "
}
# }}}
# => function: check for active proxy {{{
function proxy_info(){
  [[ -n "${http_proxy}" ]] || return
  echo "\e[32m෴ \e[0m "
}
# }}}

function git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  ref=${ref#refs/heads/}
  [ "${#ref}" -gt 32 ] && ref="${ref:0:16}…"
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS
  local -a FLAGS
  FLAGS=('--porcelain')
  if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
    FLAGS+='--untracked-files=no'
  fi
  case "$GIT_STATUS_IGNORE_SUBMODULES" in
    git)
      # let git decide (this respects per-repo config in .gitmodules)
      ;;
    *)
      # if unset: ignore dirty submodules
      # other values are passed to --ignore-submodules
      FLAGS+="--ignore-submodules=${GIT_STATUS_IGNORE_SUBMODULES:-dirty}"
      ;;
  esac
  STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

_prompt_0(){
  RPROMPT=""
  before_prompt=""
  PROMPT=""
  PROMPT='$(proxy_info)'           # prompt icon for proxy
  [[ "$(arch)" == "i386" ]] && PROMPT+="🌱 "
  PROMPT+="%{$fg[magenta]%}%c%{$reset_color%} " # cwd name
  PROMPT+='$(git_prompt_info)$(_git_time_since_commit)'"%{$reset_color%}"

  # == every prompt should display the following information
  # display a telephone icon when we are in a SSH session.
  [[ -n $SSH_CONNECTION ]] && PROMPT+="%{$fg[cyan]%}☎️%{$reset_color%} " # <-- CAREFUL. emoji here.

  # PROMPT+='$(_set_prompt_char)'     # prompt icon for repo
  PROMPT+='$timer_show'             # time taken to run last command
  PROMPT+='$(_return_code)'         # return code for last command
  PROMPT+='%{$fg[red]%}☿%{$reset_color%} '

  # if is_macosx; then PROMPT+="%(!.!.➲) %{$reset_color%}"; else PROMPT+="➲ %{$reset_color%}"; fi
}

_prompt_60(){
  PROMPT='$(proxy_info)'           # prompt icon for proxy
  PROMPT+="$(_ssh_user_info)"
  [[ "$(arch)" -eq "i386" ]] && PROMPT+="🌱 "
  PROMPT+="%{$fg_bold[cyan]%}"'${PWD/#$HOME/~}'"%{$reset_color%} "
  PROMPT+='$(git_prompt_info)$(_git_time_since_commit)'"%{$reset_color%}"
  PROMPT+='$(virtualenv_prompt_info)'"%{$reset_color%}"

  # emacs gui messes up command ouputs unless columns size is specified manually
  is_emacs && let COLUMNS=COLUMNS-2

  RPROMPT+='$(_pending_jobs) '
  # NOTE: I never look at this info, anyways and this takes a 60-70ms each time.
  RPROMPT+='$(git_prompt_status)'"%{$reset_color%} "
  [[ -z "$TMUX" ]] && RPROMPT+='$(_current_time) '
  [[ -z "$TMUX" ]] && RPROMPT+='$(_battery_remaining)'

  # intelligently, add a new line char in prompt
  PROMPT+='$prompt_newline'

  # == every prompt should display the following information
  # display a telephone icon when we are in a SSH session.
  [[ -n $SSH_CONNECTION ]] && PROMPT+="%{$fg[cyan]%}☎ %{$reset_color%} " # <-- CAREFUL. emoji here.

  PROMPT+='$(_set_prompt_char)'     # prompt icon for repo
  PROMPT+='$timer_show'             # time taken to run last command
  PROMPT+='$(_return_code)'         # return code for last command
  if is_macosx; then PROMPT+="%(!.!.➲) "; else PROMPT+="➲ "; fi
  before_prompt="$(printf "-"%.0s {1..${COLUMNS}})\n"
}

precmd() {
  # print -P "%{%(?.$FG[253].$FG[124])%}$before_prompt%{$reset_color%}"
  print -Pn "\x1b[38;2;%(?.70;70;70.200;100;100)m${before_prompt}\x1b[0m"
}

alias miniprompt=_prompt_0;

# [[ $COLUMNS -gt 80 ]] && _prompt_60 || _prompt_0
miniprompt

# when in emacs, let the user know.
is_vim    && clear && miniprompt && echo "\e[33mYou're inside VIM Z-shell.\e[0m" || true
is_emacs  && clear && miniprompt && echo "\e[33mYou're inside Emacs Multi-Term Z-shell.\e[0m" || true
is_vscode && clear && miniprompt && echo "\e[33mYou're inside VSCode Z-shell.\e[0m" || true
