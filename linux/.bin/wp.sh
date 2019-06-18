#!/usr/bin/env bash
# 
# Por: Lucas Saliés Brum, a.k.a. sistematico <lucas@archlinux.com.br>
# Criado em: 23/01/2018 18:08:09
# Última atualização: 23/01/2018 18:08:20

if [ $(whoami) != "root" ]; then
    echo "Esse script precisa de privilégios do usuário root"
    exit
fi

echo -en "Instalação atutomatizada para o Wordpress\nDeseja continuar? [s/N]: "
read -r continuar

if [[ $continuar != [sS] ]]; then
	exit
fi

echo
read -p "Usuário root do MySQL [Padrão: root]: " usuario_root

echo
read -p "Senha do usuário root do MySQL [Padrão: wordpress]: " senha_root

echo
read -p "Nome do host do wordpress [Padrão: localhost]: " host

echo
read -p "Nome do banco de dados do wordpress [Padrão: wordpress]: " banco

mysqlshow -u${usuario_root} -p${senha_root} "$banco" > /dev/null 2>&1

if [ $? = 0 ]; then
	read -p "O banco de dados $banco já existe, deseja apagar e re-criar!? [s/n] " ap
	if [ "$ap" = "s" ]; then
		mysql -u${usuario_root} -p${senha_root} -e "DROP DATABASE ${banco}"
	fi
fi

echo
read -p "Nome do usuario do banco de dados do wordpress [Padrão: wordpress]: " usuario

echo
read -p "Nome da senha do banco de dados do wordpress [Padrão: wordpress]: " senha

if [ -z $usuario_root ]; then
	usuario_root="root"
fi

if [ -z $senha_root ]; then
	senha_root="wordpress"
fi

if [ -z $host ]; then
	host="localhost"
fi

if [ -z $banco ]; then
	banco="wordpress"
fi

if [ -z $usuario ]; then
	usuario="wordpress"
fi

if [ -z $senha ]; then
	senha="wordpress"
fi

cat << EOF > /tmp/wp.sql
CREATE DATABASE ${banco};
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
ON ${banco}.*
TO ${usuario}@${host}
IDENTIFIED BY '${senha}';
FLUSH PRIVILEGES;
EOF

cat /tmp/wp.sql | mysql -u $usuario_root -p${senha_root}