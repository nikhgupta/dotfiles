#!/usr/bin/env bash
#
# ---------------------------------------------------------------------
#
#   Summary:     Copy directory recursively while resizing all image files.
#   Author:      Nikhil Gupta
#   Description: Script that copies all image files within a given
#                directory (and its sub-directories) and resizes them to
#                a given size.
#   Usage:       resize-images <source_dir> <destin_dir> <extension> <max_size>
#                resize-images ./pictures ./resized jpg 3600
#
# ---------------------------------------------------------------------
#

[[ "$1" == "-h" ]] || [[ "$1" == "--help" ]] && list-commands $0 && exit 1

if [[ $# -lt 4 ]]; then
  echo "Error: Invalid number of arguments."
  echo
  echo "Copies a directory recursively while resizing all image files of a specific type."
  echo "Usage: copy_resize_images <source_dir> <destin_dir> <extension> <max_size>"
  echo
  echo "Example:"
  echo "  copy_resize_images ./pictures ./resized jpg 3600"
  echo "will copy all 'jpg' files (case-insensitive) from './pictures'"
  echo "to './resized' directory, while reducing the max dimension "
  echo "(width or height) to 3600 pixels."
  return 1
else
  cd $1; files=$(find . -type f -iname "*.${3}"); cd -;

  IFS=$'\n'
  for file in $(echo $files); do
    echo "Processing file: $(realpath $1/$file)"
    mkdir -p "$2/${file:h}"
    sips -Z $4 "$1/$file" --out "$2/$file" 1&>/dev/null
  done
fi
