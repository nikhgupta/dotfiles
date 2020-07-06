#!/bin/bash
# Swatch Internet Time
# http://www.timeanddate.com/time/internettime.html
# https://www.swatch.com/en/internettime/
# https://en.wikipedia.org/wiki/Swatch_Internet_Time#Calculation_from_UTC.2B1

command -v bc >/dev/null 2>&1 || { echo "bc não encontrado." ; exit 1; }
read h m s <<<$(date -u "+%H %M %S")
# (UTC+1sec + (UTC+1min * 60) + (UTC+1hr * 3600)) / 86.4 
echo $(bc -l <<< "scale=0; ($s + ($m * 60) + (($h) * 3600)) / 86.4")
#echo $b

