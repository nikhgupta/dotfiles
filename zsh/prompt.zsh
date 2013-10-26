# adapted from @pengwynn (http://github.com/pengwynn/dotfiles)
# adapted from @sjl (http://github.com/sjl/dotfiles) <stevelosh.com>

# declare colors for the time_since_last_commit component {{{
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[cyan]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[yellow]%}"
# }}}

# show a different prompt character based on which kind of repository you are in {{{
set_prompt_char() {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  hg root >/dev/null 2>/dev/null && echo '☿' && return
  echo '%(!.!.⚡ )'
}
# }}}

# Determine the time since last commit. If branch is clean,... {{{
# use a neutral color, otherwise colors will vary according to time.
function git_time_since_commit() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    # Only proceed if there is actually a commit.
    if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
      # Get the last commit.
      last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
      now=`date +%s`
      seconds_since_last_commit=$((now-last_commit))

      # Totals
      MINUTES=$((seconds_since_last_commit / 60))
      HOURS=$((seconds_since_last_commit/3600))

      # Sub-hours and sub-minutes
      DAYS=$((seconds_since_last_commit / 86400))
      SUB_HOURS=$((HOURS % 24))
      SUB_MINUTES=$((MINUTES % 60))

      if [[ -n $(git status -s 2> /dev/null) ]]; then
          if [ "$MINUTES" -gt 30 ]; then
              COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
          elif [ "$MINUTES" -gt 10 ]; then
              COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
          else
              COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
          fi
      else
          COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
      fi

      if [ "$HOURS" -gt 24 ]; then
          echo "$COLOR${DAYS}d"
      elif [ "$MINUTES" -gt 60 ]; then
          echo "$COLOR${HOURS}h${SUB_MINUTES}m"
      else
          echo "$COLOR${MINUTES}m"
      fi
    else
      COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
      echo "$COLOR"
    fi
  fi
}
# }}}

# This keeps the number of todos always available the right hand side of my command line. {{{
# I filter it to only count those tagged as "+next", so it's more of a motivation to clear out the list.
todo_count(){
  if $(which t &> /dev/null)
  then
    num=$(echo $(t ls $1 | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

function todo_prompt() {
  local COUNT=$(todo_count $1);
  local TOTAL=$(todo_count)
  if [[ $COUNT != 0 ]]; then
    echo "$1: $COUNT | total: $TOTAL";
  elif [[ $TOTAL != 0 ]]; then
    echo "total: $TOTAL";
  else
    echo "";
  fi
}
# }}}

# display a count of CODE NOTES e.g. TODO, FIXME, HACK etc. {{{
function notes_count() {
  # if [[ -z $1 ]]; then
    # local NOTES_PATTERN="TODO|FIXME|HACK";
  # else
    # local NOTES_PATTERN=$1;
  # fi
  # grep -ERn "\b($NOTES_PATTERN)\b" {app,config,lib,spec,test} 2>/dev/null | wc -l | sed 's/ //g'
}

function notes_prompt() {
  # local COUNT=$(notes_count $1);
  # if [ $COUNT != 0 ]; then
    # echo "$1: $COUNT";
  # else
    # echo "";
  # fi
}
# }}}

# some miscelleneous functions {{{
function get_nr_jobs() {
  jobs | wc -l
}

function get_load() {
  uptime | awk '{print $11}' | tr ',' ' '
}

# display the current ruby version
function ruby_version()
{
    if which rvm-prompt &> /dev/null; then
      rvm-prompt i v g
    else
      if which rbenv &> /dev/null; then
        rbenv version | sed -e "s/ (set.*$//"
      fi
    fi
}
# }}}

# PROMPT = MINI        | change using: `promptmini` {{{
if [[ "$PROMPT_TYPE" == "mini" ]]; then

  # example (without colors):
  #
  # python $

  export PROMPT="%{$fg[green]%}%c%{$reset_color%} %{$fg[yellow]%}$%{$reset_color%} "
  set_right_prompt() { export RPROMPT=""; }
# }}}
# PROMPT = NICE        | change using: `promptnice` {{{
elif [[ "$PROMPT_TYPE" == "nice" ]]; then

  # example (without colors):
  #
  # scripts/python [1.9.3-p194 global] [master *] $                      ▸▸▸▸▹▹▹▹▹▹

  ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
  ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  export PROMPT=$'%{$fg[blue]%}%2c%{$reset_color%} %{$fg[red]%}$(ruby_version)%{$reset_color%} $(git_prompt_info)%{$reset_color%}%{$fg_bold[yellow]%}$%{$reset_color%} '

  set_right_prompt() { export RPROMPT="${BATTERY_CHARGE}"; }
# }}}
# PROMPT = EXTRAVAGANT | change using: `promptorig` {{{
else

  # example (without colors):
  #
  # nikhgupta at MacBookPro in ~/Code/__dotfiles/scripts/python [ master: ✗ ] 12h29m
  # ± cd                                                      +next: 7 | ▸▸▸▸▹▹▹▹▹▹

  ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}[ "
  ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$fg[blue]%}] "
  ZSH_THEME_GIT_PROMPT_DIRTY=": %{$fg[red]%}✗"
  ZSH_THEME_GIT_PROMPT_CLEAN=": %{$fg[cyan]%}✔"

  export PROMPT='\
%{$fg[magenta]%}%n%{$reset_color%} \
at %{$fg[yellow]%}%m%{$reset_color%} \
in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} \
$(git_prompt_info)\
$(git_time_since_commit)%{$reset_color%}
$(set_prompt_char) '

  set_right_prompt () {
    export RPROMPT="$(notes_prompt TODO) \
%{$fg_bold[yellow]%}$(notes_prompt HACK)%{$reset_color%} \
%{$fg_bold[red]%}$(notes_prompt FIXME)%{$reset_color%} \
%{$fg_bold[white]%}$(todo_prompt +next)%{$reset_color%} \
| ${BATTERY_CHARGE}"
  }
fi
# }}}

# we want right prompt to be recalculated before every prompt display
precmd() { set_right_prompt; }
