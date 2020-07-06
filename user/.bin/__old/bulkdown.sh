#!/usr/bin/env bash
#
# help: bulk download images from a URL
# ref: https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a
# updated: 10-06-19 01:18:16

ext="jpg,png,jpeg"
dir="$XDG_DOWNLOAD_PICTURE_DIR/bulkdown/$$"

usage() {
    echo "Use: $(basename $0) \"http://site.com/page\""
}

if [ "$#" -lt 1 ]; then
  usage
  exit 1
fi

for u in $@; do
  echo "Downloading images from URL: $u"
  wget --quiet -P $dir -nd -p -H -A $ext "$u"
done
