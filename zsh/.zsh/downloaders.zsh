# utility: youtube-dl
alias ydl=youtube-dl

# playlist
alias download_playlist="youtube-dl --yes-playlist"
alias ydlpl=download_playlist

# download MP3 music to proper directory
function download_mp3() {
  destin="${2:-mixed}"
  youtube-dl --extract-audio --audio-format mp3 \
    -o "${XDG_DOWNLOAD_MUSIC_DIR}/$destin/%(title)s.%(ext)s" \
    --download-archive $XDG_CACHE_HOME/youtube-dl/mp3-archive.txt $1
}

# download a song video to proper directory
function download_song() {
  destin="${2:-mixed}"
  youtube-dl -o "${XDG_DOWNLOAD_VIDEO_DIR}/$destin/%(title)s.%(ext)s" \
    --download-archive $XDG_CACHE_HOME/youtube-dl/songs-archive.txt $1
}

# Download all images from a website
alias download_images_from_website="wget -r -l1 --no-parent -nH -nd -P/tmp -A\".jpg,.png,.jpeg\""
