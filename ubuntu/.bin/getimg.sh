#!/bin/bash
# Based on: https://stackoverflow.com/a/27910080/1844007

# function to create all dirs til file can be made
function mkdirs {
    file="$1"
    dir="/"

    # convert to full path
    if [ "${file##/*}" ]; then
        file="${PWD}/${file}"
    fi

    # dir name of following dir
    next="${file#/}"

    # while not filename
    while [ "${next//[^\/]/}" ]; do
        # create dir if doesn't exist
        [ -d "${dir}" ] || mkdir "${dir}"
        dir="${dir}/${next%%/*}"
        next="${next#*/}"
    done

    # last directory to make
    [ -d "${dir}" ] || mkdir "${dir}"
}

# get optional 'o' flag, this will open the image after download
getopts 'o' option
[[ $option = 'o' ]] && shift

# parse arguments
count=${1}
shift
query="$@"
[ -z "$query" ] && exit 1  # insufficient arguments

# set user agent, customize this by visiting http://whatsmyuseragent.com/
useragent='Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:31.0) Gecko/20100101 Firefox/31.0'

# construct google link
link="www.google.com.br/search?q=${query}\&tbm=isch"

# fetch link for download
imagelink=$(wget -e robots=off --user-agent "$useragent" -qO - "$link" | sed 's/</\n</g' | grep '<a href.*\(png\|jpg\|jpeg\)' | sed 's/.*imgurl=\([^&]*\)\&.*/\1/' | head -n $count | tail -n1)
imagelink="${imagelink%\%*}"

# get file extention (.png, .jpg, .jpeg)
ext=$(echo $imagelink | sed "s/.*\(\.[^\.]*\)$/\1/")

# set default save location and file name change this!!
dir="$PWD"
file="google image"

# get optional second argument, which defines the file name or dir
if [[ $# -eq 2 ]]; then
    if [ -d "$2" ]; then
        dir="$2"
    else
        file="${2}"
        mkdirs "${dir}"
        dir=""
    fi
fi

# construct image link: add 'echo "${google_image}"'
# after this line for debug output
google_image="${dir}/${file}"

# construct name, append number if file exists
if [[ -e "${google_image}${ext}" ]] ; then
    i=0
    while [[ -e "${google_image}(${i})${ext}" ]] ; do
        ((i++))
    done
    google_image="${google_image}(${i})${ext}"
else
    google_image="${google_image}${ext}"
fi

# get actual picture and store in google_image.$ext
wget --max-redirect 0 -qO "${google_image}" "${imagelink}"

# if 'o' flag supplied: open image
[[ $option = "o" ]] && gnome-open "${google_image}"

# successful execution, exit code 0
exit 0
