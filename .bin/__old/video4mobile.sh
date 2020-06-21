#!/bin/sh

ffmpeg -y -i $1 -c:v mpeg4 -b:v 600k -c:a libmp3lame $1.mobile.avi
