#!/bin/sh

# mc, thunar, caja, nautilus, etc...
apps=("dialog" "sshfs" "mc")
porta=2211
titulo="SSHFS GUI"

for app in ${apps[@]}; do
	which $app >/dev/null 2>&1 || { echo >&2 "O programa $app não está instalado. Abortando."; exit 1; }
done

if grep -Fxq "#user_allow_other" /etc/fuse.conf
then
    echo "A opção user_allow_other está comentada no arquivo /etc/fuse.conf. Abortando..."
	exit 1
fi

options=$(dialog --title "$titulo" --inputbox "Opções Adicionais" 8 40 "-p ${porta} -o allow_other" 3>&1 1>&2 2>&3)
usuario=$(dialog --title "$titulo" --inputbox "Usuario Remoto" 8 40 "$(whoami)" 3>&1 1>&2 2>&3)

num=0

while [ ! ${host} ] || [ ! $ok ]; do
	let num="num + 1"
	if [ "$num" -gt 10 ]; then
		echo "Abortando pelo número máximo de tentativas..."
		exit 1
	fi

	host=$(dialog --title "$titulo" --inputbox "Host" 8 40 "" 3>&1 1>&2 2>&3)

	if [ "$?" -eq 1 ]; then
		dialog --title "$titulo" --infobox "Programa cancelado." 6 35; sleep 3
		exit 1
	fi

	if [ ! -z "$host" ]; then

		ping -q -c5 $host > /dev/null 2> /dev/null

		if [ $? -eq 0 ]
		then
			ok=true
			echo "Host: $host encontrado."
			echo "Prosseguindo..."

			#while [ ! ${checa_porta} ] && [ ! $porta ]; do

			#	exec 6<>/dev/tcp/${host}/${porta} && "Porta do SSH encontrada!" && checa_porta=true || echo "Porta do SSH não encontrada. Digite uma nova porta."
			#	exec 6>&- # close output connection
			#	exec 6<&- # close input connection

			#	if [ ! ${checa_porta} ]; then
			#		read -p "Porta: " porta
			#	fi

			#done

		else
			dialog --title "$titulo" --infobox "O host: $host não foi encontrado.\nDigite um host válido...\n\n\n${num}ª tentativa..." 8 50; sleep 5
		fi

	else
		dialog --title "$titulo" --infobox "Host não digitado, digite um host válido...\n\n\n${num}ª tentativa..." 8 50; sleep 5
	fi
done

dir="${HOME}/sshfs/${host}"

if [ ! -d ${dir} ]; then
	dialog --title "$titulo" --yesno "O diretório $dir não existe, deseja cria-lo?" 8 50

	if [ "$?" -eq 0 ]; then
		dialog --title "$titulo" --infobox "Criando o diretório: $dir" 8 50; sleep 3
		mkdir -p "$dir"
	else
		dialog --title "$titulo" --infobox "A criação do diretório: $dir falhou\n\nPrograma abortado..." 8 50; sleep 5
		exit 0
	fi
fi

remoto=$(dialog --title "$titulo" --inputbox "Caminho remoto" 8 40 "/" 3>&1 1>&2 2>&3 )

sshfs ${usuario}@${host}:${remoto} $dir $options
mc ~ $dir
fusermount -u ${dir}
