#!/bin/sh

ARQUIVO="$1"

ffmpeg -i "$ARQUIVO" -codec copy "${ARQUIVO%.flv}.mp4"
