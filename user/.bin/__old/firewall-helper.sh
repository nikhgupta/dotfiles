#!/bin/sh
#
# Sintaxe para encontrar os IPS.
# host -t a DOMINIO
# whois -h whois.radb.net [IP] | grep origin
# whois -h whois.radb.net -- -i origin -T route AS32934 | grep route:
#
# Script por Lucas Saliés Brum, a.k.a. sistematico, <lucas AT archlinux DOT com DOT br>.
#
# Criado em 03/08/16 13:43:16 AMT
# Alterado em 24-08-2016 12:50:22 AMT

# Mode 0 (normal) | Mode 1 (Bloqueia Torrents)
mode=0

# ufw ou iptables
firewall="ufw"

# Lista de Trackers(somente mode 1)
trackers='https://gist.githubusercontent.com/sistematico/d9cb55664365d22999c3c926239d8035/raw/b75207d27020948cc3e94ebfb0f25d5e60fb7bed/trackers.txt'

################# NÃO ALTERE NADA ABAIXO DISTO! #################

[ "$EUID" -ne 0 ] && echo "É necessário rodar o script como root." && exit 1

ajuda () {	
	if [ "$mode" == 0 ]
	then
		echo
		echo "Uso: $(basename $0) --block google.com"
		echo "Uso: $(basename $0) --unblock google.com"
		echo
		exit 1
	else 
		echo 
		echo "Uso: $(basename $0) --block"
		echo "Uso: $(basename $0) --unblock"
		echo
		exit 1
	fi
}

if [ $mode -eq 0 ]; then
	[ $# -lt 2 ] && ajuda
	dominio="${2}"
	apps=( "ping" "whois" "host" $firewall )
	

	ping -c 1 $dominio 2>/dev/null 1>/dev/null

	if [ $? -ne 0 ]; then
		echo "Domínio inválido."
		exit 1
	fi	
	
	ip=$(host -t a $dominio | cut -d ' ' -f4)
else
	[ $# -lt 1 ] && ajuda
	apps=( "curl" $firewall )
fi

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

if [ "$mode" == 0 ]; then 
	if [ -f /tmp/as.txt ]; then 	
		rm -f /tmp/as.txt
	fi

	if [ -f /tmp/ips.txt ]; then 
		echo "O arquivo de ips existe, re-utilizar? [S/n]"
		read resp1
		if [ "$resp1" == "n" ]; then 
			rm -f /tmp/ips.txt
		fi
	fi

	whois -h whois.radb.net $ip | grep origin: | cut -d ':' -f2 | sed -e 's/ //g' > /tmp/as.txt

	while read as; do
		#echo "AS: ${as}"
		whois -h whois.radb.net -- -i origin -T route $as | grep route: | cut -d ':' -f2 | sed -e 's/ //g' | cut -d '/' -f1 > /tmp/ips.txt
	done < /tmp/as.txt

	tmp="/tmp/ips.txt"
else 
	if [ -f /tmp/trackers.txt ]; then 
		echo "O arquivo de trackers existe, re-utilizar? [S/n]"
		read resp1
		if [ "$resp1" == "n" ]; then 
			rm -f /tmp/trackers.txt
		fi
	fi

	tmp="curl ${trackers} | cut -d"/" -f3 | cut -d":" -f1 > /tmp/trackers.txt"
fi

if [ "$1" = "--block" ]; then
	while read dom; do
		if [ $firewall == "ufw" ]; then
			ufw deny from $dom
			ufw deny to $dom
			ufw reload
		else
			iptables -I INPUT -p tcp --dport 80 -m string --string \"Host: ${dom}\" --algo bm -j DROP
			iptables -I OUTPUT -p tcp --dport 80 -m string --string \"Host: ${dom}\" --algo bm -j DROP
		fi
		echo "IP: $dom bloqueado."
	done < $tmp
elif [ "$1" = "--unblock" ]; then
	while read dom; do
		if [ $firewall == "ufw" ]; then
			ufw delete deny from $dom
			ufw delete deny to $dom
			ufw reload
		else
			iptables -D INPUT -p tcp --dport 80 -m string --string \"Host: ${dom}\" --algo bm -j DROP
			iptables -D OUTPUT -p tcp --dport 80 -m string --string \"Host: ${dom}\" --algo bm -j DROP
		fi
		echo "IP: $dom desbloqueado."
	done < $tmp
else
	echo "Parametros incorretos."
	ajuda
fi
