# miscelleneous but useful functions
function md5()    { echo -ne "$@" | md5sum    | cut -d ' ' -f1; }
function sha256() { echo -ne "$@" | sha256sum | cut -d ' ' -f1; }
function sha512() { echo -ne "$@" | sha512sum | cut -d ' ' -f1; }

# random text function - ascii chars by default - pass `[:alnum:] | [:xdigit:] | [:print:] etc. as 2nd argument`
function generate_random_text() {
  cat /dev/urandom \
    | gtr -dc 'a-zA-Z0-9\{\}\[\]\<\>,\.\/?;:\-=_\+\!@#$%\^\&\*\(\)~' \
    | gtr -d '[:space:]' \
    | gtr -dc "${2:-'\11\12\40-\176'}" \
    | head -c "${1:-96}"
  echo -ne "\n"
}

# generate a grid (80x24) of random text for arbitrary use such as password generation etc.
function generate_random_grid { repeat "${2:-24}" { random_text "${1:-80}" "$3" } }
function generate_random_md5_grid() { random_grid 1028 "${1:-24}" PROCESS_EACH_LINE md5 }
function generate_random_sha256_grid() { random_grid 1028 "${1:-24}" PROCESS_EACH_LINE sha256 }
function generate_random_password_grid() { random_grid "${1:-16}" "${2:-8}" }
