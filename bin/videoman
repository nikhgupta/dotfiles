#!/usr/bin/env bash
#
# ---------------------------------------------------------------------
#
#   Summary:     Cut a video and reduce the resulting size
#   Author:      Nikhil Gupta
#   Description: Script to cut a video for given durations and reduce
#                the size, optionally.
#   Usage:       video_cut <filename> <from> <duration>
#                video_resize <filename>
#                videoman <filename> <from> <duration>
#
# ---------------------------------------------------------------------
#

[[ "$1" == "-h" ]] || [[ "$1" == "--help" ]] && list-commands $0 && exit 1

video_cut() {
  src="${1}"
  dst="${1:t:r}.cut.${2//[^[:alnum:]]/_}-${3//[^[:alnum:]]/_}.${1:e}"
  if ! is_installed ffmpeg; then
    echo "You must install ffmpeg to cut videos."
    return 1
  elif [[ $# -lt 3 ]]; then
    echo "Error: Invalid number of arguments."
    echo
    echo "Cuts a video of specific duration from a specified time by copying the video stream."
    echo "Usage: video_cut <filename> <from> <duration>"
    echo "Generated file is named as: <basename>.cut.<duration-info>.<extension>"
    echo
    echo "Example:"
    echo "  video_cut video.mov 00:15:00 00:05:00 4"
    echo "will cut the above video file from 15 mins mark for a duration of 5 minutes,"
    echo "and save the new file as: video.cut.00_15_00-00_05_00.mov"
    return 1
  elif [[ ! -f "${src}" ]]; then
    echo "Provided input video file: ${src} doesn't exist."
    return 1
  elif [[ -e "${dst}" ]]; then
    echo "File exists at: ${dst}. Please, rename it before continuing."
    echo "For further info, run video_cut without any arguments."
    return 1
  elif [[ -t 1 ]]; then
    ffmpeg -n -stats -ss "$2" -i "${src}" -c copy -avoid_negative_ts 1 -to "${3}" "${dst}"
    echo "File created at: ${dst}"
  else
    ffmpeg -n -v 0 -ss "$2" -i "${src}" -c copy -avoid_negative_ts 1 -to "${3}" "${dst}"
    echo "${dst}"
  fi
}

# Reduce video size for the given video
video_reduce() {
  src="${1}"
  dst="${1:t:r}.reduced.${1:e}"
  if ! is_installed ffmpeg; then
    echo "You must install ffmpeg to reduce video size."
    return 1
  elif [[ $# -lt 1 ]]; then
    echo "Error: Invalid number of arguments."
    echo
    echo "Reduces file size of a video with minimal loss of quality."
    echo "Usage: video_reduce <filename>"
    echo "Generated file is named as: <basename>.reduced.<extension>"
    echo
    echo "Example:"
    echo "  video_reduce video.mov"
    echo "will reduce the file size for video.mov, and"
    echo "save the new file as: video.reduced.mov"
    return 1
  elif [[ ! -f "${src}" ]]; then
    echo "Provided input video file: ${src} doesn't exist."
    return 1
  elif [[ -e "${dst}" ]]; then
    echo "File exists at: ${dst}. Please, rename it before continuing."
    echo "For further info, run video_reduce without any arguments."
    return 1
  elif [[ -t 1 ]]; then
    ffmpeg -n -stats -i "${src}" -crf 20 "${dst}"
    echo "File created at: ${dst}"
  else
    ffmpeg -n -v 0 -i "${src}" -crf 20 "${dst}"
    echo "${dst}"
  fi
}

# Cut and reduce video size for the given video

src="${1}"
dst1="${src:t:r}.cut.${2//[^[:alnum:]]/_}-${3//[^[:alnum:]]/_}.${src:e}"
dst2="${dst1:t:r}.reduced.${dst1:e}"

if [[ ! -f "${src}" ]]; then
  echo "You must specify a video file!"
  exit
fi

if video_cut $@ && [[ -e "${dst1}" ]]; then
  echo; echo
  if video_reduce "${dst1}" && [[ -e "${dst2}" ]]; then
    echo; echo
    echo "Created the uncompressed cut video at: ${dst1}"
    echo "Created the compressed version of above at: ${dst2}"
  else
    echo; echo
    echo "Reducing the file size failed."
    echo "However, I was successful in cutting the video."
    echo "Created the uncompressed cut video at: ${dst1}"
    return 1
  fi
else
  echo; echo
  echo "Cutting the video failed."
  return 1
fi
