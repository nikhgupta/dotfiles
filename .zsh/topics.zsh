# language: python
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
gpip2(){ PIP_REQUIRE_VIRTUALENV="" pip2 "$@"; }
gpip3(){ PIP_REQUIRE_VIRTUALENV="" pip3 "$@"; }
alias venv="python -m env"
alias venv3="python3 -m env"

# language: go
export GOPATH=$HOME/.golang
path_append "${GOPATH}/bin"

# language: elixir
export ERL_AFLAGS="-kernel shell_history enabled"
touch ~/.iex_history # needed for up/down key support in IEx sessions

# language: ruby
alias be='bundle exec'
alias rspecff='rspec --fail-fast'
alias rspecof='rspec --only-failures'
alias rspecffof='rspec --fail-fast --only-failures'
alias bundled="bundle install --local || bundle install || bundle update"

# utility: youtube-dl
alias ydl=youtube-dl
alias ydlpl="youtube-dl --yes-playlist"
function ydlmp3() {
  destin="${2:-mixed}"
  youtube-dl --extract-audio --audio-format mp3 \
    -o "${XDG_DOWNLOAD_MUSIC_DIR}/$destin/%(title)s.%(ext)s" \
    --download-archive ~/.cache/youtube-dl/mp3-archive.txt $1
}

function ydlsong() {
  destin="${2:-mixed}"
  youtube-dl -o "${XDG_DOWNLOAD_VIDEO_DIR}/$destin/%(title)s.%(ext)s" \
    --download-archive ~/.cache/youtube-dl/songs-archive.txt $1
}
