#!/bin/bash
# Códigos: 

METRIC=1 #Should be 0 or 1; 0 for F, 1 for C

if [ -z "$1" ]; then
	echo
	echo "USO: $0 <codigo>"
	echo
	exit 0;
fi

#localidade="$1"

info=$(curl -s http://rss.accuweather.com/rss/liveweather_rss.asp\?metric\=${METRIC}\&locCode\=${1/ /+} | grep -iPo '(?<=<title>Currently:)(.*)(?=</title>)' | tr -d "[:blank:]")
cond=$(echo $info | cut -d ":" -f1)
temp=$(echo $info | cut -d ":" -f2)
hora=$(date +"%H")
dia=6
noite=7

# Mostly Cloudy / Cloudy / Dreary (Overcast) / Fog
if [ "$cond" = "*Cloudy*" ] || [ "$cond" = "*Mostly Cloudy*" ] || [ "$cond" = "*Dreary (Overcast)*" ] || [ "$cond" = "*Fog*" ]; then
	icone=""
# Showers / Mostly Cloudy w/ Showers / Partly Sunny w/ Showers / T-Storms / Mostly Cloudy w/ T-Storms / Partly Sunny w/ T-Storms / Rain
elif [ "$cond" = "*Showers*" ] || [ "$cond" = "*Mostly Cloudy*Showers*" ] || [ "$cond" = "*Partly Sunny*Showers*" ] || [ "$cond" = "*T-Storms*" ] || [ "$cond" = "*Mostly Cloudy*T-Storms*" ] || [ "$cond" = "*Partly Sunny*T-Storms*" ] || [ "$cond" = "*Rain*" ]; then
	icone=""
# Windy
elif [ "$cond" = "*Windy*" ]; then
	icone=""
# Flurries / Mostly Cloudy w/ Flurries / Partly Sunny w/ Flurries / Snow / Mostly Cloudy w/ Snow / Ice / Sleet / Freezing Rain / Rain and Snow / Cold
elif [ "$cond" = "*Flurries*" ]; then
	icone=""
else
	if [ ${hora} -ge ${dia} -a ${hora} -le ${noite} ]; then
		icone=""
	else
   		icone=""
	fi
fi

echo "$icone $temp"
echo "$temp"

#      
