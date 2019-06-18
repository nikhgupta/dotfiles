#!/bin/sh
#
# ufw_helper.sh: Programa feito em dialog para administração do UFW Firewall.
#
# Criado por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
# Em 		14/09/2016 18:12:13 AMT
# Alterado: 20/10/2018 21:00:20 AMT

if [ "$(id -u)" != "0" ]; then
   echo "Este script precisa ser usado como root." 1>&2
   exit 1
fi

apps=( "ufw" "dialog" )

for app in ${apps[@]}
do
	which $app 1> /dev/null 2> /dev/null
	if [ $? != 0 ]; then
		echo
		echo "O aplicativo $app não foi encontrado."
		echo "Abortando..."
		echo
		exit 1
	fi
done

altura=15
largura=40
escolha_altura=6
titulo="UFW Helper"
subtitulo="Nível de Proteção"
menu="Escolha um nível de proteção:"
opcoes=(1 "Desabilitado" 2 "Mínima" 3 "Forte" 4 "Bloqueio Total(sem conexão)" 5 "Reconfigurar(default)" 6 "Status")
estado=$(ufw status | grep Status | cut -d ' ' -f2)

ufw_principal() {
	escolha=$(dialog --clear \
		            --title "$subtitulo" \
		            --backtitle "$titulo" \
		            --menu "$menu" \
		            $altura $largura $escolha_altura \
		            "${opcoes[@]}" \
		            2>&1 >/dev/tty)

	clear

	case $escolha in
		1) ufw_desabilitado ;;
		2) ufw_minimo ;;
		3) ufw_forte ;;
		4) ufw_bloqueio ;;
		5) ufw_reconfig ;;
		6) ufw_status ;;
	esac
}

ufw_desabilitado() {
	ufw disable
	ufw_principal
}

ufw_minimo() {
	ufw --force reset
	ufw enable
	ufw default deny incoming
	ufw reload
	rm -f /etc/ufw/after.rules.* /etc/ufw/after6.rules.* /etc/ufw/before.rules.* /etc/ufw/before6.rules.* /etc/ufw/user.rules.* /etc/ufw/user6.rules.*
	ufw_principal
}

ufw_forte() {
	ufw --force reset
	ufw enable
	ufw default deny incoming
	ufw default deny outgoing
	ufw allow in 6881:6891/tcp
	ufw allow in 6881:6891/udp
	ufw allow out 6981:6991/tcp
	ufw allow out 6981:6991/udp
	ufw allow out proto tcp to any port 21,22,80,443,465,587,993,2211,2200,2222,5902
	ufw allow out proto udp to any port 53
	ufw reload
	ufw_principal
	rm -f /etc/ufw/after.rules.* /etc/ufw/after6.rules.* /etc/ufw/before.rules.* /etc/ufw/before6.rules.* /etc/ufw/user.rules.* /etc/ufw/user6.rules.*
}

ufw_bloqueio() {
	ufw --force reset
	ufw enable
	ufw default deny incoming
	ufw default deny outgoing
	ufw reload
	rm -f /etc/ufw/after.rules.* /etc/ufw/after6.rules.* /etc/ufw/before.rules.* /etc/ufw/before6.rules.* /etc/ufw/user.rules.* /etc/ufw/user6.rules.*
	ufw_principal
}

ufw_reconfig() {
	ufw --force reset
	ufw reload
	rm -f /etc/ufw/after.rules.* /etc/ufw/after6.rules.* /etc/ufw/before.rules.* /etc/ufw/before6.rules.* /etc/ufw/user.rules.* /etc/ufw/user6.rules.*
	ufw_principal
}

ufw_status() {
	ufw status verbose > /tmp/ufw_helper_status.txt
	dialog 	--clear \
			--backtitle "$titulo" \
			--title "Status do Firewall" \
			--tailbox /tmp/ufw_helper_status.txt \
			0 0 \
			2>&1 >/dev/tty
	if [ $? = 0 ]; then
		ufw_principal
	fi
}

if [ $estado == "inactive" ]; then
	dialog 	--clear \
			--title "Ligar Firewall?" \
			--backtitle "$titulo" \
			--yesno 'Firewall desabilitado, deseja habilitar?' 0 0

	if [ $? = 0 ]; then
		ufw enable
	fi
fi

ufw_principal
