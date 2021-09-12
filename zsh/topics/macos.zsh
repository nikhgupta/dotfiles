# Flush Directory Service cache
alias remove_dns_cache="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Recursively delete `.DS_Store` files
alias remove_dsstore_files="find . -type f -name '*.DS_Store' -ls -delete"

# battery percentage
function battery_percent() { pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';' | tr -d '%'; }
