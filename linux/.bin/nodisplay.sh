#!/bin/bash

# Array associativa
#declare -A apps
# Array numerica
#declare -a apps
#declare -a element

homedir="${HOME}/.local/share/applications"
sysdir="/usr/share/applications"
apps=("yad-icon-browser" "gvim" "assistant" "designer" "linguist" "Thunar-bulk-rename" "qdbusviewer" "cmake" "xfce4-about" "caja." "gnome" "cinnamon" "qt4" "mate" "zenmap" "mpv" "links" "avahi-discover" "bssh" "bvnc" "-floaters" "elementary" "munch" "cosmos" "thunar-settings" "qv4l2")
nd='NoDisplay'

function uso {
	echo "Uso: $(basename $0) -rsa"
}

function nodisp {
	if [ "$1" = '-r' ]; then
        if [ -f $2 ]; then
			grep 'NoDisplay' $2 1> /dev/null
        	if [ $? = 0 ]; then
            	echo "Removendo NoDisplay de $2"
				sed -i.bak "/$nd/d" $2
        	fi
		fi
	elif [ "$1" = '-c' ]; then
        if [ -f $2 ]; then
			grep 'NoDisplay' $2 1> /dev/null
        	if [ $? = 0 ]; then
            	echo "$2"
        	fi
		fi
	else
		grep 'NoDisplay' $1 1> /dev/null
		if [ $? = 1 ]; then
			echo "Inserindo NoDisplay em $1"
			echo 'NoDisplay=true' >> $1
		else
			echo "$1 já tem o NoDisplay..."
		fi
	fi
}

if [ $1 ] && [ $1 != "-a" ] && [ $1 != "-c" ]; then
	if [ "$1" = "-s" ]; then
		if [ "$2" ]; then
			arquivos=($(grep -r "$@" /usr/share/applications/ | awk -F':' '{print $1}' | uniq))
			if [ ! -z $arquivos ]; then
				for a in ${arquivos[@]}; do
					echo $a
				done
				[ ${#arquivos[@]} = 1 ] && echo ${arquivos[0]} | xclip -r -selection c
			else
				echo "Nenhum arquivo encontrado."
			fi
		fi
	elif [ "$1" = '-r' ]; then
		if [ -f "${homedir}/$(basename $2)" ]; then
			nodisp -r "${homedir}/$(basename $2)"
		fi
	elif [ -f "${homedir}/$(basename $1)" ]; then
		nodisp "${homedir}/$(basename $1)"
	elif [ -f "${sysdir}/$(basename $1)" ]; then
		echo
		echo "Copiando $(basename $1) para ${homedir}..."
		cp "${sysdir}/$(basename $1)" "${homedir}/"
		nodisp "${homedir}/$(basename $1)"
	elif [ -f "${sysdir}/screensavers/$(basename $1)" ]; then
		[ ! -d ${homedir}/screensavers/ ] && mkdir -p ${homedir}/screensavers/
		echo
		echo "Copiando $(basename $1) para ${homedir}/screensavers/..."
		cp "${sysdir}/screensavers/$(basename $1)" "${homedir}/screensavers/"
		nodisp "${homedir}/screensavers/$(basename $1)"
	fi

elif [ "$1" = "-a" ]; then
	[ ! -d $homedir ] && mkdir -p $homedir
	todos=($(find $sysdir $homedir -type f | egrep .desktop))
	for app in ${apps[@]}; do
		echo
		echo "Procurando o regex *${app}*..."
    	for element in ${todos[@]}; do
        	if [[ $element == *"$app"* ]]; then
            	nome=$(basename $element)
            	echo
				echo "O nome $nome coincide com ${app}..."

    			if [ ! -f "${homedir}/${nome}" ]; then
    				echo
    		   		echo "$nome não existe em ${homedir}"

    		   		if [ -f "${sysdir}/screensavers/${nome}" ]; then
    		   			echo
    		       		echo "$nome existe em ${sysdir}/screensavers, copiando para ${homedir}/screensavers/${nome}"
    		       		cp "${sysdir}/screensavers/${nome}" "${homedir}/screensavers/"
    		   		elif [ -f "${sysdir}/${nome}" ]; then
    		   			echo
    		       		echo "$nome existe em ${sysdir}, copiando para ${homedir}/${nome}"
    		       		cp "${sysdir}/${nome}" "${homedir}/"
    		   		fi
    			fi
				if [ -f "${homedir}/${nome}" ]; then
					nodisp "${homedir}/${nome}"
				elif [ -f "${homedir}/screensavers/${nome}" ]; then
					nodisp "${homedir}/screensavers/${nome}"
				fi
        	fi
    	done
	done
elif [ "$1" = "-c" ]; then
	echo
	echo "Procurando por arquivos com NoDisplay em *${homedir}*..."
	echo "-----------------------------------------------------------"
	echo
	todos=($(find $homedir -type f | egrep .desktop))
	for e in ${todos[@]}; do
       	nome=$(basename $e)
		[ -f "${homedir}/${nome}" ] && nodisp -c "${homedir}/${nome}"
	done
else
	uso
fi
