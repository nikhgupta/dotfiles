#!/bin/bash

estacoes=(
'SDM=http://somdomato.com:8000/'
'Pinguin Radio=http://pr320.pinguinradio.nl:80/'
'Classics=http://pc192.pinguinradio.com/listen.pls'
'On the Rocks=http://po192.pinguinradio.com/listen.pls'
#'Aardschok=http://as192.pinguinradio.com/listen.pls'
'Skaradio=http://sr192.pinguinradio.com/listen.pls'
#'Grooves=http://pg192.pinguinradio.com/listen.pls'
'3FM Serious Radio=http://icecast.omroep.nl/3fm-bb-aac'
#'Alternative=http://icecast.omroep.nl/3fm-alternative-aac'
#'On Stage=http://icecast.omroep.nl/3fm-live-aac'
#'Serious Talent=http://icecast.omroep.nl/3fm-serioustalent-aac'
'Radio 6 Soul & Jazz=http://icecast.omroep.nl/radio6-bb-mp3'
#'Easy Listening=http://icecast.omroep.nl/radio6-easylistening-bb-mp3'
#'Back to the Old School=http://icecast.omroep.nl/radio6-oldschool-bb-aac'
#'Jazz Jong=http://icecast.omroep.nl/radio6-jazzjong-mp3'
#'World=http://icecast.omroep.nl/radio6-world-bb-mp3'
#'Jazz=http://icecast.omroep.nl/radio6-jazz-bb-mp3'
#'- Grooves=http://icecast.omroep.nl/radio6-grooves-bb-mp3'
#'- Blues=http://icecast.omroep.nl/radio6-blues-bb-mp3'
#'- Jupiter Broadcasting Radio=http://jbradio.out.airtime.pro:8000/jbradio_a'
#'Digitally Imported: Chillout=http://listen.di.fm/public3/chillout.pls'
#'- Chillout Dreams=http://listen.di.fm/public3/chilloutdreams.pls'
#'- Soulful House=http://listen.di.fm/public3/soulfulhouse.pls'
#'- Funky House=http://listen.di.fm/public3/funkyhouse.pls'
#'- Progressive=http://listen.di.fm/public3/progressive.pls'
#'- Lounge=http://listen.di.fm/public3/lounge.pls'
#'- PsyChill=http://listen.di.fm/public3/psychill.pls'
'SomaFM: Groove Salad=http://somafm.com/groovesalad.pls'
'Drone Zone=http://somafm.com/dronezone.pls'
'Indie Pop Rocks!=http://somafm.com/indiepop.pls'
'Space Station Soma=http://somafm.com/spacestation.pls'
#'- Lush=http://somafm.com/lush.pls'
'Secret Agent=http://somafm.com/secretagent.pls'
#'- Underground 80s=http://somafm.com/u80s.pls'
#'- Deep Space One=http://somafm.com/deepspaceone.pls'
'Beat Blender=http://somafm.com/beatblender.pls'
#'- Boot Liquor=http://somafm.com/bootliquor.pls'
#'- Suburbs of Goa=http://somafm.com/suburbsofgoa.pls'
#'- Poptron=http://somafm.com/poptron.pls'
#'- Sonic Universe=http://somafm.com/sonicuniverse.pls'
#'- Def Con=http://somafm.com/defcon.pls'
'Folk Forward=http://somafm.com/folkfwd.pls'
#'- BAGel Radio=http://somafm.com/bagel.pls'
#'- Fluid=http://somafm.com/fluid.pls'
#'- Illinois Street Lounge=http://somafm.com/illstreet.pls'
#'- The Trip=http://somafm.com/thetrip.pls'
#'- Left Coast 70s=http://somafm.com/seventies.pls'
'- Cliqhop idm=http://somafm.com/cliqhop.pls'
#'- Digitalis=http://somafm.com/digitalis.pls'
'Dub Step Beyond=http://somafm.com/dubstep.pls'
'Seven Inch Soul=http://somafm.com/7soul.pls'
#'- Thistle Radio=http://somafm.com/thistle.pls'
#'- Doomed=http://somafm.com/doomed.pls'
#'- Mission Control=http://somafm.com/missioncontrol.pls'
#'- Covers=http://somafm.com/covers.pls'
#'- Black Rock FM=http://somafm.com/brfm.pls'
)

listar() {
  for radio in "${estacoes[@]}"; do
    echo "${radio%%=*}"
  done
}

matar() {
	killall mpv
	exit 0
}

if [ $(pgrep -x mpv) ]; then
	m="Matar\n"
fi

opts='-width 10'


ESTACAO=$(echo -e "${m}$(listar)" | rofi $opts -dmenu -p "Selecione a estacao:")

if [ "$ESTACAO" ]; then
	if [ "$ESTACAO" == "Matar" ]; then
		matar
	else
		for i in "${!estacoes[@]}"; do
	   		if [[ "${estacoes[$i]}" == *"$ESTACAO"* ]]; then
	   			sel="${estacoes[${i}]}"
	       		break
	   		fi
		done

		if [ "$sel" ]; then
			[ $(pgrep -x mpv) ] && matar
			r=$(echo $sel | awk -F= '{print $2}')
			mpv -vo null --really-quiet --no-ytdl --no-resume-playback $r > /dev/null 2>&1 &
		fi
	fi
fi
