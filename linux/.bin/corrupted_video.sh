#!/bin/bash
#
#
# Fonte: https://www.linuxquestions.org/questions/linux-general-1/recursively-find-and-delete-corrupted-movie-files-4175531035/#post5301092
#

root="$1"
filecount=$(find "$root" -type f | wc -l)
find "$root" -iname \*.avi -o -iname \*.mp4 -o -iname \*.mkv -o -iname \*.m4v -o -iname \*.wmv -o -iname \*.mov -o -iname \*.mpg -o -iname \*.mpeg -o -iname \*.wma -o -iname \*.asf -o -iname \*.asx -o -iname \*.rm -o -iname \*.3gp -o -iname \*.0gm | {
    processed=0
    corrupt=0
    while read -r pathname; do
        if ! ffprobe -v quiet -i "$pathname"
        #if ! mplayer -benchmark -identify -really-quiet -vo null -ao null "$pathname"
        #if ! mplayer -benchmark -really-quiet -vo null -ao null "$pathname"
		then
            let ++corrupt
            printf 'rm %q\n' "$pathname" >> corrompidos.sh
        fi
        echo -ne "Processados: $((++processed)) Total: $filecount Corrompidos: $corrupt \r"
    done
}

echo "Arquivos corrompidos: "
cat corrompidos.sh
