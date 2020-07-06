#!/bin/bash

hora=$1
audio="${HOME}/.alarme.mp3"
#audio="${HOME}/audio/alarmes/naval/cvn77whistle.wav"
audio_web="https://github.com/sistematico/majestic/raw/master/home/lucas/audio/alarme.mp3"

function alarme {
	n=1
	i=3
	while (( $n <= $1 )); do
		mpg123 $audio
		sleep $i
		n=$(( n+1 ))
	done
}

if [ $hora ]; then
	if [ "$hora" = "c" ]; then
		killall -9 $(basename $0)
		msg="Alarme Cancelado! $(basename $0)"
	else
		date "+%H:%M" -d "$hora" > /dev/null 2>&1
		if [ $? != 0 ]; then
			msg="Hora inválida!\n\nVocê digitou: $hora \n\nFormato: (HH:MM)"
		else
			h=$(( $(date --date=${hora} +%s) - $(date +%s) ))
			if [ $h -gt 1 ]; then
				echo -e "O alarme irá tocar as:\n$(date --date=${hora})"
				sleep $(( $(date --date=${hora} +%s) - $(date +%s) ));
				echo "ACORDA!!!"
				#while true; do
	  				/usr/bin/mpg123 $audio
	  			#	sleep 3
				#done
				alarme 30			
				msg="Alarme ajustado para:\n\n${hora}"				
			else
				msg="A hora tem que ser positiva!\n\nVocê digitou: $hora\nTimestamp: $h \n\nFormato: (HH:MM)"
			fi
		fi
	fi

	echo -e $msg
fi