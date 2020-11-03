# language: python
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
gpip2() { PIP_REQUIRE_VIRTUALENV="" pip2 "$@"; }
gpip3() { PIP_REQUIRE_VIRTUALENV="" pip3 "$@"; }
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

# download MP3 music to proper directory
function ydlmp3() {
  destin="${2:-mixed}"
  youtube-dl --extract-audio --audio-format mp3 \
    -o "${XDG_DOWNLOAD_MUSIC_DIR}/$destin/%(title)s.%(ext)s" \
    --download-archive $XDG_CACHE_HOME/youtube-dl/mp3-archive.txt $1
}

# download a song video to proper directory
function ydlsong() {
  destin="${2:-mixed}"
  youtube-dl -o "${XDG_DOWNLOAD_VIDEO_DIR}/$destin/%(title)s.%(ext)s" \
    --download-archive $XDG_CACHE_HOME/youtube-dl/songs-archive.txt $1
}

# download youtube videos bypassing a lot of restrictions
alias ydlyt="youtube-dl --verbose --cookies $XDG_CACHE_HOME/cookies-google.txt --user-agent \"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)\""

# utility: rclone and onedrive
# sync pictures and videos with onedrive storage
onedrivesync() {
  orig=$1
  shift
  dest=$1
  shift
  rclone sync $orig $dest -P --delete-excluded --fast-list --log-level=INFO --no-check-certificate --no-update-modtime $@
}
alias onedrivesync_photos="onedrivesync /Volumes/PICTURES onedrive:Photography"

# utility: vim
# write markdown in distraction free GVIM editor
function marked() {
  [[ -f "$@" ]] && _path="$@" || _path="$HOME/Documents/Writings/$@.md"
  gvim +"Goyo 80%x80%" "$_path"
}
