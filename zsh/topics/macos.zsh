# Flush Directory Service cache
alias remove_dns_cache="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Recursively delete `.DS_Store` files
alias remove_dsstore_files="find . -type f -name '*.DS_Store' -ls -delete"

# battery percentage
function battery_percent() { pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';' | tr -d '%'; }

# change architecture
function xarch() {
  is_intel_macos && {
    echo "=> running command in arm64 architecture.."
    if (( $# )); then arch -arm64 $@; else exec arch -arm64 zsh -li; fi
  }

  is_arm_macos && {
    echo "=> running command in i386 (x86_64) architecture.."
    if (( $# )); then arch -x86_64 $@; else exec arch -x86_64 zsh -li; fi
  }
}
