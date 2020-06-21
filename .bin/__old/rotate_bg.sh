#!/bin/bash

mode=0
dia=$(date +'%a') 
hora=$(date +'%H') 
walls_dir="/usr/share/backgrounds/modelos/"

if [ "$1" == "-o" ]; then
	if [ -f $(cat ${HOME}/.wallpaper) ]; then
		viewnior $(cat ${HOME}/.wallpaper)
	else 
		echo "Arquivo não encontrado."
	fi
	exit 0
fi

if [ "$1" == "-w" ]; then
	selection=$(find $walls_dir -type f -iname "${keyword}" | shuf -n1)	
	exit 0
else

	if [ "$mode" == 1 ]; then
		case $dia in
		   "dom") keyword="*jynx*jpg";;
		   "seg") keyword="*candela*jpg";;
		   "ter") keyword="*marsha*jpg";;
		   "qua") keyword="*marsha*jpg";;
		   "qui") keyword="*milana*jpg";;
		   "sex") keyword="*marry*jpg";;
		   *) keyword="*.jpg";;
		esac
		selection=$(find $walls_dir -type f -iname "${keyword}" | shuf -n1)	
	elif [ "$mode" == 2 ]; then
		case $hora in
		   00) echo "00" ; keyword="*jynx*jpg";;
		   0[1-3]) echo "1 até 3" ; keyword="*jynx*jpg";;
		   0[4-6]) echo "4 até 6" ; keyword="*candela*jpg";;
		   0[7-9]) echo "7 até 9" ; keyword="*marsha*jpg";;
		   1[0-2]) echo "10 até 12" ; keyword="*marsha*jpg";;
		   1[3-5]) echo "13 até 15" ; keyword="*milana*jpg";;
		   1[6-8]) echo "16 até 18" ; keyword="*marsha*jpg";;
		   19|2[0-1]) echo "19 até 21" ; keyword="*marry*jpg";;
		   2[1-3]) echo "21 até 23" ; keyword="*marry*jpg";;
		   *) echo "hora nao encontrada" ; keyword="*.jpg";;
		esac
		selection=$(find $walls_dir -type f -iname "${keyword}" | shuf -n1)	
	elif [ "$mode" == 3 ]; then
		case $hora in
		   00) keyword="*blessed*jpg";;
		   01) keyword="*jynx*jpg";;
		   02) keyword="*candela*jpg";;
		   03) keyword="*courtney*jpg";;
		   04) keyword="*marsha*jpg";;
		   05) keyword="*milana*jpg";;
		   06) keyword="*marsha*jpg";;
		   07) keyword="*wicky*jpg";;
		   08) keyword="*stevens*jpg";;
		   09) keyword="*sierra*jpg";;
		   10) keyword="*jewels*jpg";;
		   11) keyword="*marry*jpg";;
		   12) keyword="*marry*jpg";;
		   13) keyword="*crouz*jpg";;
		   14) keyword="*lylith*jpg";;
		   15) keyword="*lowe*jpg";;
		   16) keyword="*lavey*jpg";;
		   17) keyword="*stella*jpg";;
		   18) keyword="*julia*de*jpg";;
		   19) keyword="*nappi*jpg";;
		   20) keyword="*dhalia*jpg";;
		   21) keyword="*jemma*jpg";;
		   22) keyword="*jenna*jpg";;
		   23) keyword="*lydia*lust*jpg";;
		   *) keyword="*.jpg";;
		esac
		selection=$(find $walls_dir -type f -iname "${keyword}" | shuf -n1)		
	else 
		selection=$(find $walls_dir -type f -name "*.jpg" -o -name "*.png" | shuf -n1)
	fi
fi	

if [ -f "$selection" ]; then

	if [ "$DESKTOP_SESSION" == "mate" ]; then
		gsettings set org.mate.background picture-filename "$selection"
	elif [ "$DESKTOP_SESSION" == "gnome" ]; then
		gsettings set org.gnome.desktop.background picture-uri "file://$selection"
	else
		/usr/bin/feh --bg-fill "$selection"
	fi

	echo "$selection" > ${HOME}/.wallpaper

else 
	echo "Arquivo não encontrado."
	exit 1
fi
