#!/bin/bash
period=20
tumblerpath="/usr/lib/*/tumbler-1/tumblerd" # The * here should find the right one, whether 32 and 64-bit
cpu_threshold=50
mem_threshold=20
max_strikes=2                               # max number of above cpu/mem-threshold's in a row
log="/tmp/tumblerd-watcher.log"

if [[ -n "${log}" ]]; then
    cat /dev/null > "${log}"
    exec >"${log}" 2>&1
fi


strikes=0
while sleep "${period}"; do
    while read pid; do
	cpu_usage=$(ps --no-headers -o pcpu -f "${pid}"|cut -f1 -d.)
	mem_usage=$(ps --no-headers -o pmem -f "${pid}"|cut -f1 -d.)

	if [[ $cpu_usage -gt $cpu_threshold ]] || [[ $mem_usage -gt $mem_threshold ]]; then
	    echo "$(date +"%F %T") PID: $pid CPU: $cpu_usage/$cpu_threshold %cpu MEM: $mem_usage/$mem_threshold STRIKES: ${strikes} NPROCS: $(pgrep -c -f ${tumblerpath})"
	    (( strikes++ ))
	    if [[ ${strikes} -ge ${max_strikes} ]]; then
		kill "${pid}"
		echo "$(date +"%F %T") PID: $pid KILLED; NPROCS: $(pgrep -c -f ${tumblerpath})"
		strikes=0
	    fi
	else
	    strikes=0
	fi
    done < <(pgrep -f ${tumblerpath})
done
