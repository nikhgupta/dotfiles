#!/usr/bin/env bash
#
# ---------------------------------------------------------------------
#
#   Summary:  Script to create a data URL from the given file
#   Author:   Nikhil Gupta
#   Usage:    dataurl <filename>
#
# ---------------------------------------------------------------------
#

mimeType=$(file -b --mime-type "$1")
if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
fi

echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
