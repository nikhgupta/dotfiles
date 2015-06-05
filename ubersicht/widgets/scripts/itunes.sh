#!/usr/bin/env bash

# check that itunes is running or exit early..
pgrep -xiq itunes || exit 1

track=$(osascript -e 'tell application "iTunes"' \
                  -e 'if player state is playing then' \
                  -e 'set loc to location of current track' \
                  -e 'return POSIX path of loc' \
                  -e 'end if' -e 'end tell')

# check that some song is playing or exit early
[[ -n "${track}" ]] && [[ -f "${track}" ]] || exit 2

osascript -e 'try' -e 'tell application "iTunes"' \
          -e 'set vCover to data of artwork 1 of current track' \
          -e 'set vTarget to open for access file ((path to home folder as text) & "Code:__dotfiles:ubersicht:widgets:albumart.jpg") with write permission' \
          -e 'write vCover to vTarget' \
          -e 'close access vTarget' \
          -e 'end tell' -e 'end try'

PATH="/usr/local/bin:$PATH"
for config in $(find ~/Music/Beets/Configurations -iname '*.yml'); do
  fields="artist,length,lyrics,title"
  response=$(echo -n "${track}\0" | xargs -0 -I {} /usr/local/bin/beet -c $config info -i $fields "{}" 2>/dev/null | tail -n +2)

  title=$( echo "${response}" | tail -1 | sed -e 's/^[^:]*:\s*//')
  artist=$(echo "${response}" | head -1 | sed -e 's/^[^:]*:\s*//')
  length=$(echo "${response}" | head -2 | tail -1 | sed -e 's/^[^:]*:\s*//')
  lyrics=$(echo "${response}" | tail +3 | tail -r | tail +2 | tail -r | sed -e 's/^[^:]*:\s*//' -e 's/$/<br\/>/')
  length=$(echo "${length}" | awk -F. '{ printf("%02d:%02d", int($1/60), ($1 % 60))}')
  [[ -n "${lyrics}" ]] && rating=$(osascript -e "tell application \"iTunes\" to return rating of current track")

  if [[ -n "${lyrics}" ]]; then
    echo -ne "<div class='albumart'><img src='/albumart.jpg' /></div>"
    echo -ne "<div class='meta'>"
    [[ -n "${rating}" ]] && echo -ne "<div class='rating' data-score='${rating}'></div>"
    [[ -n "${title}" ]]  && echo -ne "<h1 class='title'>${title}</h1>"
    [[ -n "${artist}" ]] && echo -ne "<h3 class='artist'>${artist}</h3>"
    [[ -n "${length}" ]] && echo -ne "<h3 class='duration'>${length}</h3>"
    echo "</div><div class='lyrics'><p>${lyrics}</p></div>"
    break
  fi
done
