# adapted from @pengwynn (http://github.com/pengwynn/dotfiles)
# adapted from @sjl (http://github.com/sjl/dotfiles) <stevelosh.com>

# Expectations:
# - If the last command failed, convey to the user nicely :)
# - Allow the user to switch to a really concise and alternate prompt.
# - Let the user know, if he is logged in via a remote session.
# - If inside a repository, display the time since last commit.
# - Display the kind of repository, we are working with.
# - Display status for the current repository, i.e. what statuses files have.
# - Display current battery status.
# - Display current time.
# - Display external IP address.

# Expected: 
# - Allow the user to switch to a really concise and alternate prompt.
alias miniprompt=" export PROMPT_TYPE='mini'; source $DOTZSH/prompt.zsh"
alias origprompt=" export PROMPT_TYPE='orig'; source $DOTZSH/prompt.zsh"

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

ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[cyan]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[yellow]%}"

# Expected:
# - Let the user know, if he is logged in via a remote session.
# - Display the kind of repository, we are working with.
set_prompt_char() {
  [[ -n $SSH_CONNECTION ]] && echo -ne "%{$fg[cyan]%}☎ %{$reset_color%}"
  git log &>/dev/null && echo -ne '± '
  hg root &>/dev/null && echo -ne '☿ '
  echo '%(!.!.➲)'
}

# Expected:
# - If the last command failed, convey the exit status to the user nicely :)
return_code() {
  echo "%(?..%{$fg[red]%}↵ %? %{$reset_color%})"
}

# Expected:
# - If inside a repository, display the time since last commit.
git_time_since_commit() {

  git rev-parse --git-dir &>/dev/null || return
  git log &>/dev/null || return

  # Get the last commit.
  last_commit=`git log --pretty=format:'%at' -1 2>/dev/null`
  now=`date +%s`
  seconds_since_last_commit=$((now-last_commit))

  # Totals
  MINUTES=$((seconds_since_last_commit / 60))
  HOURS=$((seconds_since_last_commit/3600))

  # Sub-hours and sub-minutes
  DAYS=$((seconds_since_last_commit / 86400))
  SUB_HOURS=$((HOURS % 24))
  SUB_MINUTES=$((MINUTES % 60))

  if [[ -n $(git status -s 2>/dev/null) ]]; then
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
}

get_battery_charge() {
  # TODO: battery status should auto-update in intervals of 5 mins?
  [ -n "${BATTERY_CHARGE_SCRIPT}" ] &&
    echo "`python ${BATTERY_CHARGE_SCRIPT} 2>/dev/null`"
}

pending_jobs() {
  local job_nos=`jobs | wc -l`
  [[ $job_nos != 0 ]] && echo "%{$fg_bold[red]%}${job_nos}JP%{$reset_color%}"
}

# when only 2 dir deep and we are not on a git repo, only use a single line:
display_prompt() {
  # display host information when inside ssh connection
  if [[ -n $SSH_CONNECTION ]]; then
    echo -ne "%{$fg[magenta]%}%n%{$reset_color%} at "
    echo -ne "%{$fg[yellow]%}%m%{$reset_color%} in "
  fi

  # display the path to current directory
  echo -ne "%{$fg_bold[cyan]%}${PWD/#$HOME/~}%{$reset_color%} "

  # display git information
  echo -ne "$(git_prompt_info)$(git_time_since_commit)%{$reset_color%}"

  # intelligently, use a single line or a double line
  if (( ${#PWD/#$HOME/\~} > 16 )) || [[ -n $SSH_CONNECTION ]] || git log &>/dev/null; then echo; fi

  echo "$(return_code)$(set_prompt_char) "
}

PROMPT='$(display_prompt)'

RPROMPT='$(git_prompt_status)%{$reset_color%} \
$(pending_jobs) \
%{$fg_bold[blue]%}[%*] %{$reset_color%}\
$(get_battery_charge)'

# # display the current ruby version
# ruby_version() {
#   which rvm-prompt &>/dev/null && return rvm-prompt i v g
#   which rbenv &>/dev/null && rbenv version | sed -e "s/ (set.*$//"
# }

# # PROMPT = MINI        | change using: `promptmini` {{{
# if [[ "$PROMPT_TYPE" == "mini" ]]; then

#   # example (without colors):
#   #
#   # python $

#   export PROMPT="%{$fg[green]%}%c%{$reset_color%} %{$fg[yellow]%}$%{$reset_color%} "
#   export RPROMPT=""
#   # }}}
#   # # PROMPT = NICE        | change using: `promptnice` {{{
#   # elif [[ "$PROMPT_TYPE" == "nice" ]]; then

#   #   # example (without colors):
#   #   #
#   #   # scripts/python [1.9.3-p194 global] [master *] $                      ▸▸▸▸▹▹▹▹▹▹

#   #   ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
#   #   ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
#   #   ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
#   #   ZSH_THEME_GIT_PROMPT_CLEAN=""

#   #   export PROMPT=$'%{$fg[blue]%}%2c%{$reset_color%} %{$fg[red]%}$(ruby_version)%{$reset_color%} $(git_prompt_info)%{$reset_color%}%{$fg_bold[yellow]%}$%{$reset_color%} '

#   #   set_right_prompt() { export RPROMPT="${BATTERY_CHARGE}"; }
#   # # }}}
#   # PROMPT = EXTRAVAGANT | change using: `promptorig` {{{
#   # else

#   #   # example (without colors):
#   #   #
#   #   # nikhgupta at MacBookPro in ~/Code/__dotfiles/scripts/python [ master: ✗ ] 12h29m
#   #   # ± cd                                                      +next: 7 | ▸▸▸▸▹▹▹▹▹▹

#   #   ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}[ "
#   #   ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$fg[blue]%}] "
#   #   ZSH_THEME_GIT_PROMPT_DIRTY=": %{$fg[red]%}✗"
#   #   ZSH_THEME_GIT_PROMPT_CLEAN=": %{$fg[cyan]%}✔"

#   #   export PROMPT='\
#     # %{$fg[magenta]%}%n%{$reset_color%} \
#     # at %{$fg[yellow]%}%m%{$reset_color%} \
#     # in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} \
#     # $(git_prompt_info)\
#     # $(git_time_since_commit)%{$reset_color%}
#   # $(set_prompt_char) '

#   #   set_right_prompt () {
#   #     export RPROMPT="$(notes_prompt TODO) \
#     # %{$fg_bold[yellow]%}$(notes_prompt HACK)%{$reset_color%} \
#     # %{$fg_bold[red]%}$(notes_prompt FIXME)%{$reset_color%} \
#     # %{$fg_bold[white]%}$(todo_prompt +next)%{$reset_color%} \
#     # | ${BATTERY_CHARGE}"
#   #   }
#   # fi
# else

#   # example (without colors):
#   #
#   # nikhgupta at MacBookPro in ~/Code/__dotfiles/scripts/python [ master: ✗ ] 12h29m
#   # ± cd                                                      +next: 7 | ▸▸▸▸▹▹▹▹▹▹


#   # display exitcode on the right when >0
#   return_code="| %(?..%{$fg[red]%}%? ↵%{$reset_color%}) |"

#   # export PROMPT='\
#     #   %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} \
#     #   $(git_prompt_info)\
#     #   $(git_time_since_commit)%{$reset_color%}
#   # $(set_prompt_char) % '

#   # RPROMPT='$(git_prompt_status)%{$reset_color%} ${return_code} [%*] | ${BATTERY_CHARGE}'
#   # $(set_prompt_char) '
#   # set_right_prompt () {
#   #   export RPROMPT="\
#     # ${BATTERY_CHARGE}"
#   # }
# fi
# # }}}

# # we want right prompt to be recalculated before every prompt display
# # precmd() { display_prompt; }
