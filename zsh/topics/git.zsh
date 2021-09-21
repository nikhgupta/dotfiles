git_web() {
  local gitdir=$(git rev-parse --show-toplevel 2>/dev/null)
  echo $gitdir

  if [[ -z "${gitdir}" ]]; then
    echo "[Error]: Could not get path to git repo!"
  else
    local tmpcache=/tmp/git-web-last.dir
    local last=$(cat $tmpcache)

    local query="a=summary"
    [[ -z "$@" ]] || query="a=history;f=$@";

    echo "opening repo in: ${gitdir}"
    if [[ -z "${last}" ]]; then
      cd "${gitdir}" && git instaweb -d webrick start && \
        open "http://127.0.0.1:1234/?p=.git;${query}" && \
        echo "${gitdir}" > $tmpcache
    else
      cd "${last}" && git instaweb stop && \
        cd "${gitdir}" && git instaweb -d webrick start && \
        open "http://127.0.0.1:1234/?p=.git;${query}" && \
        echo "${gitdir}" > $tmpcache
    fi
  fi
}
