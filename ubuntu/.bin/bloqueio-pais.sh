#!/usr/bin/env bash
#
# Arquivo: bloqueio-pais.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
# Com base no trabalho de: http://www.cyberciti.biz/faq/?p=3402
#
# Criado em: 24-03-2018 20:12:17
# Última alteração: 02-04-2018 18:31:09

# Países a serem bloqueados
PAISES="af cn" 
 
### PATH ###
IPT=/sbin/iptables
CURL=/usr/bin/curl
EGREP=/usr/bin/egrep
 
### NÃO EDITE ABAIXO ###
LISTASPAM="paisbloqueado"
CAMINHODAZONA="/root/iptables"
SITEDAZONA="http://www.ipdeny.com/ipblocks/data/countries"
 
limpaRegras () {
	$IPT -F
	$IPT -X
	$IPT -t nat -F
	$IPT -t nat -X
	$IPT -t mangle -F
	$IPT -t mangle -X
	$IPT -P INPUT ACCEPT
	$IPT -P OUTPUT ACCEPT
	$IPT -P FORWARD ACCEPT
}
 
# Cria o diretório
[ ! -d $CAMINHODAZONA ] && /bin/mkdir -p $CAMINHODAZONA
 
# Limpa regras antigas
limpaRegras
 
# Cria uma nova lista do iptables
$IPT -N $LISTASPAM
 
for c in $PAISES
do 
	# Arquivo de zona local
	tDB=$CAMINHODAZONA/$c.zone
 
	# Baixa o arquivo com a zona
	$CURL -s -o $tDB $SITEDAZONA/$c.zone
 
	# Log específico do país
	MENSAGEMSPAM="${c} País Bloqueado"
 
	# get 
	IPSRUINS=$(egrep -v "^#|^$" $tDB)
	for ip in $IPSRUINS
	do
	   $IPT -A $LISTASPAM -s $ip -j LOG --log-prefix "$MENSAGEMSPAM"
	   $IPT -A $LISTASPAM -s $ip -j DROP
	done
done
 
# Dropa tudo
$IPT -I INPUT -j $LISTASPAM
$IPT -I OUTPUT -j $LISTASPAM
$IPT -I FORWARD -j $LISTASPAM
 
# Chame outros scripts do iptables aqui:
# /caminho/do/outros/script/iptables.sh
 
exit 0