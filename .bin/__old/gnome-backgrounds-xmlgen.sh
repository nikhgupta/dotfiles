#!/bin/bash
# gnome-backgrounds-xmlgen.sh
#
# usage:./gnome-backgrounds-xmlgen.sh background_dir_1 background_dir_2 background_dir_3
#
# description: simply generate a backgrounds xml that can be consumed by gnome's background configuration
#
# authors: ozhoo & browner @ ubuntuforums.org
#
# note: only looks for .JPG and .jpg files

# output file
FILENAME="$(basename $(pwd)).xml"

# start time (any time in the past works)
YEAR=2009
MONTH=04
DAY=02
HOUR=00
MINUTE=00
SECOND=00

# time to show background (seconds)
WALLDURATION=60.0

# transition time (seconds)
TRANSDURATION=5.0

# script specifics
if [ ! "$1" ]; then
	DIRS=$(pwd)
else
	DIRS=$*
fi
T1="echo -e \t"
T2="echo -e \t\t"
T3="echo -e \n"

echo "<background>" > "$FILENAME"
${T1}"<starttime>" >> "$FILENAME"
${T2}"<year>${YEAR}</year>" >> "$FILENAME"
${T2}"<month>${MONTH}</month>" >> "$FILENAME"
${T2}"<day>${DAY}</day>" >> "$FILENAME"
${T2}"<hour>${HOUR}</hour>" >> "$FILENAME"
${T2}"<minute>${MINUTE}</minute>" >> "$FILENAME"
${T2}"<second>${SECOND}</second>" >> "$FILENAME"
${T1}"</starttime>" >> "$FILENAME"
${T3} >> "$FILENAME"

get_first()
{
    for d in $DIRS; do
        find "$d"|grep -i .jpg|while read j; do
            echo "$j"
            break
        done
        break
    done
}

FIRST="$(get_first)"

${T1}"<static>" >> "$FILENAME"
${T2}"<duration>${WALLDURATION}</duration>" >> "$FILENAME"
${T2}"<file>${FIRST}</file>" >> "$FILENAME"
${T1}"</static>" >> "$FILENAME"
echo >> "$FILENAME"
${T1}"<transition>" >> "$FILENAME"
${T2}"<duration>${TRANSDURATION}</duration>" >> "$FILENAME"
${T2}"<from>${FIRST}</from>" >> "$FILENAME"

for d in $DIRS; do
    find "$d"|sort -R|grep -i .jpg|while read j; do
        if [ "$j" == "$FIRST" ]; then
            continue
        else
            ${T2}"<to>${j}</to>" >> "$FILENAME"
            ${T1}"</transition>" >> "$FILENAME"
			echo >> "$FILENAME"
            ${T1}"<static>" >> "$FILENAME"
            ${T2}"<duration>${WALLDURATION}</duration>" >> "$FILENAME"
            ${T2}"<file>${j}</file>" >> "$FILENAME"
            ${T1}"</static>" >> "$FILENAME"
			echo >> "$FILENAME"
            ${T1}"<transition>" >> "$FILENAME"
            ${T2}"<duration>${TRANSDURATION}</duration>" >> "$FILENAME"
            ${T2}"<from>${j}</from>" >> "$FILENAME"
        fi
    done
done

${T2}"<to>${FIRST}</to>" >> "$FILENAME"
${T1}"</transition>" >> "$FILENAME"
echo "</background>" >> "$FILENAME"
