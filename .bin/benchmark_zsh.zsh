#!/usr/bin/env zsh
#
# ---
# summary: benchmark zsh startup time
# author: Nikhil Gupta
# usage: |
#   $0
#   $0 /path/to/a/zsh/script/to/benchmark
#
logfile=/tmp/zsh.profiler.log
summaryfile=/tmp/zsh.profiler.summary
rm -f $logfile
rm -f $summaryfile

zmodload zsh/zprof
zmodload zsh/datetime
setopt PROMPT_SUBST
PS4='+$EPOCHREALTIME %N:%i> '
echo "Logging to $logfile"
exec 3>&2 2>$logfile
setopt XTRACE

if [[ -z "$1" ]]; then
    source ~/.zshenv
    source ~/.zshrc
else
    for f; do source $f; done
fi

unsetopt XTRACE
exec 2>&3 3>&-

typeset -i prev_time=0
typeset prev_command

while read line; do
    if [[ $line =~ '^.*\+([0-9]{10})\.([0-9]{6})[0-9]* (.+)' ]]; then
        integer this_time=$match[1]$match[2]

        if [[ $prev_time -gt 0 ]]; then
            time_difference=$(($this_time - $prev_time))
            echo "$time_difference $prev_command" >>$summaryfile
        fi

        prev_time=$this_time

        local this_command=$match[3]
        prev_command=$this_command
    fi
done <$logfile
cat $summaryfile | sort -nr | head

if [[ -z "$1" ]]; then
    rm -rf ~/.zcache
    rm -rf ~/.zcompdump*
    time zsh -ic exit
    time zsh -ic exit
fi
