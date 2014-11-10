#!/usr/bin/env bash
#
# Bash script to get the external IP address of this machine, and store
# it in a file only if the last known IP is different than current one.
#
# This file is run via Crontab every 60 seconds.
#
# Now, whenever a script requires to fetch external IP address for
# display, e.g. tmux configuration, it can receive the IP address by
# querying the IP file, instead.

datapath="$(dirname $(dirname $(dirname $0)))/data"
ipfile="${datapath}/ip-addresses.txt"
[[ -d "${datapath}" ]] || mkdir -p "${datapath}"
[[ -f "${ipfile}" ]] || touch "${ipfile}"

url="https://widget-data-feeder.herokuapp.com/ip?format=txt&keys=jttp_x_forwarded_for"
lastip="$(tail -n1 "${ipfile}" | cut -d '/' -f3)"
currentip="$(curl -sS ${url} 2>/dev/null)"
if [[ $? != 0 ]]; then currentip="OFFLINE"; fi
if [[ ${#currentip} -gt 15 ]]; then currentip="ONLINE"; fi

stamp="$(date +%Y%m%d%H%M%S)/$(date +%s)/${currentip}"
[[ "${currentip}" != "${lastip}" ]] && echo "${stamp}" >> $ipfile

echo $currentip
[[ "${currentip}" != "OFFLINE" ]]
