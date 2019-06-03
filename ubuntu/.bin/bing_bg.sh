#!/bin/bash
#
# Original: http://askubuntu.com/a/400984/411885


if [ "$1" == "-r" ]; then
    feh --bg-fill $(cat ${HOME}/.wallpaper)
    exit
fi 

bing="www.bing.com"

# Valid values are: en-US, zh-CN, ja-JP, en-AU, en-UK, de-DE, en-NZ, en-CA.
# The idx parameter determines where to start from. 0 is the current day, 1 the previous day, etc.
xmlurl="http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=en-US"
diretorio="$HOME/img/bing/"
mkdir -p $diretorio

# Valid options are: none,wallpaper,centered,scaled,stretched,zoom,spanned
picOpts="zoom"

# Valid options: "_1024x768" "_1280x720" "_1366x768" "_1920x1200"
resolucoes="_1366x768"
extensao=".jpg"

# Form the URL for the desired pic resolution
resolucao=$bing$(echo $(curl -s $xmlurl) | grep -oP "<urlBase>(.*)</urlBase>" | cut -d ">" -f 2 | cut -d "<" -f 1)$resolucoes$extensao

# Form the URL for the default pic resolution
resolucao_padrao=$bing$(echo $(curl -s $xmlurl) | grep -oP "<url>(.*)</url>" | cut -d ">" -f 2 | cut -d "<" -f 1)

# $imagem contains the filename of the Bing pic of the day

# Attempt to download the desired image resolution. If it doesn't
# exist then download the default image resolution
if wget --quiet --spider "$resolucao"
then
    # Set imagem to the desired imagem
    imagem=${resolucao##*/}
    # Download the Bing pic of the day at desired resolution
    curl -s -o $diretorio$imagem $resolucao
else
    # Set imagem to the default imagem
    imagem=${resolucao_padrao##*/}
    # Download the Bing pic of the day at default resolution
    curl -s -o $diretorio$imagem $resolucao_padrao
fi

feh --bg-fill $diretorio$imagem
echo $diretorio$imagem > ${HOME}/.wallpaper
find $diretorio -atime 30 -delete
exit
