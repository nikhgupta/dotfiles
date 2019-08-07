#!/bin/bash
#
# help: set Bing PoTD as wallpaper
# ref: http://askubuntu.com/a/400984/411885
# updated: 10-06-19 01:15:15

if [ "$1" == "-r" ]; then
    feh --bg-fill $(cat ${HOME}/.wallpaper)
    exit
fi 

bing="www.bing.com"

# Valid values are: en-US, zh-CN, ja-JP, en-AU, en-UK, de-DE, en-NZ, en-CA.
# The idx parameter determines where to start from. 0 is the current day, 1 the previous day, etc.
xmlurl="http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=en-US"
dir="$XDG_WALLPAPER_DIR/bing/"
mkdir -p $dir

# Valid options are: none,wallpaper,centered,scaled,stretched,zoom,spanned
picOpts="zoom"

# Valid options: "_1024x768" "_1280x720" "_1366x768" "_1920x1200"
resolutions="_1366x768"
extension=".jpg"

# Form the URL for the desired pic resolution
resolution=$bing$(echo $(curl -s $xmlurl) | grep -oP "<urlBase>(.*)</urlBase>" | cut -d ">" -f 2 | cut -d "<" -f 1)$resolutions$extension

# Form the URL for the default pic resolution
resolution_default=$bing$(echo $(curl -s $xmlurl) | grep -oP "<url>(.*)</url>" | cut -d ">" -f 2 | cut -d "<" -f 1)

# $image contains the filename of the Bing pic of the day

# Attempt to download the desired image resolution. If it doesn't
# exist then download the default image resolution
if wget --quiet --spider "$resolution"
then
    # Set image to the desired image
    image=$(echo ${resolution##*/} | cut -d'=' -f2)
    # Download the Bing pic of the day at desired resolution
    curl -s -o $dir$image $resolution
else
    # Set image to the default image
    image=${resolution_default##*/}
    # Download the Bing pic of the day at default resolution
    curl -s -o $dir$image $resolution_default
fi

feh --bg-fill $dir$image
echo $dir$image > ${HOME}/.wallpaper
find $dir -atime 30 -delete
exit
