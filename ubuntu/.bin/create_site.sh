#!/bin/sh
#
# Script para a criação automática de usuários para o Nginx + MySQL + vsftpd
#
# Criado por Lucas Saliés Brum a.k.a. sistematico <lucas@archlinux.com.br>
#
# Criado em: 15/05/2015 15:08:14
# Última alteração: 15/05/2015 15:08:18


if [ $(whoami) != "root" ]; then
    echo "Esse script precisa de privilégios do usuário root"
    exit
fi

NGINX_USER="nginx" # Usuário do Nginx
NGINX_ROOT="/var/www" # Diretório padrão do Nginx
NGINX_CONF="/etc/nginx/sites.d" # Diretório de configuração dos sites
SENHA_MYSQL="SENHA" # Senha do root
VSFTPD_DIR="/etc/vsftpd" # Diretorio de configuração do Nginx
# Não altere nada abaixo disto!

HTPASSWD_BIN=$(which htpasswd)


if [ ! -d $NGINX_CONF ]
then
	echo "O diretório $NGINX_CONF não existe."
	echo -n "Deseja cria-lo?[s/n] "

	read resposta
	resposta2=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')

	if [ ! -z "$resposta" ] && [ "$resposta2" = "s" ]
	then
		mkdir -pv $NGINX_CONF
	else
		exit 1
	fi

fi

if [ ! -d $VSFTPD_DIR ]
then
	echo "O diretório $VSFTPD_DIR não existe."
	echo -n "Deseja cria-lo?[s/n] "

	read resposta
	resposta2=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')

	if [ ! -z "$resposta" ] && [ "$resposta2" = "s" ]
	then
		mkdir -pv $VSFTPD_DIR
	else
		exit 1
	fi

fi

cat <<HERE

Script para criação dinâmica de usuários ftp, web server e mysql...

Iniciando...

HERE

echo -n "Endereço do site(exemplo: joao.dominio.com): "
read site
if [ -z "$site" ]
then
	echo
	echo "Site nulo, saindo..."
	exit 1
fi

echo -n "Usuário do FTP e Banco de Dados(exemplo: joao): "
read usuario
if [ -z "$usuario" ]
then
	echo
	echo "Usuário nulo, saindo..."
	exit 1
fi

echo -n "Senha do FTP e Banco de Dados: "
read senha
if [ -z "$senha" ]
then
	echo
	echo "Senha nula, saindo..."
	exit 1
fi

mkdir -p ${NGINX_ROOT}/${site}
chown -R $NGINX_USER:$NGINX_USER ${NGINX_ROOT}/${site}

echo
echo "Criando arquivos de configuração... "
cat <<EOL >${NGINX_CONF}/${site}.conf 
server {
	listen   80;
	root /var/www/${site};
	server_name ${site};

	include conf.d/erros.conf;
	include conf.d/wordpress.conf;

	location ~ /\.ht {
		deny all;
	}
}
EOL
echo "Sucesso!"
echo

echo "Criando arquivos de senha do vsftpd em ${VSFTPD_DIR}/passwd... "

if [ ! -f ${VSFTPD_DIR}/passwd ]
then
	$HTPASSWD_BIN -c -b -d ${VSFTPD_DIR}/passwd $usuario $senha
else 
	$HTPASSWD_BIN -b -d ${VSFTPD_DIR}/passwd $usuario $senha
fi

echo "Sucesso!"
echo

echo "Criando arquivos de configuração do vsftpd... "
echo "local_root=${NGINX_ROOT}/${site}" > /etc/vsftpd/users/$usuario
echo "Sucesso!"
echo

echo "Criando banco de dados... "
mysql -u root -p${SENHA_MYSQL} -e "CREATE DATABASE ${usuario};"
echo "Sucesso!"
echo

echo "Criando usuario do banco de dados... "
mysql -u root -p${SENHA_MYSQL} -e "CREATE USER ${usuario}@localhost IDENTIFIED BY \"${senha}\";"
echo "Sucesso!"
echo

echo "Garantindo privilégios... "
mysql -u root -p${SENHA_MYSQL} -e "GRANT ALL PRIVILEGES ON ${usuario}.* TO ${usuario}@localhost;"
echo "Sucesso!"
echo

echo "Recarregando privilégios... "
mysql -u root -p${SENHA_MYSQL} -e 'FLUSH PRIVILEGES;'
echo "Sucesso!"
echo

echo "Reiniciando o nginx..."
service nginx restart
echo

echo "Reiniciando o vsftpd..."
service vsftpd restart
echo
echo "Pronto..."
echo
exit 0
