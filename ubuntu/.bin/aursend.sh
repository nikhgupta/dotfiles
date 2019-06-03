#!/bin/bash
#
# Script para o envios de pacotes para o AUR.
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em: 16/05/2016
# Última Atualização: 03/03/2017
#

if [ ! "$1" ]; then
	echo "Parametros insuficientes..."
	exit 1
fi

pacote=$1
nome=$(cat cerebro/.SRCINFO | grep pkgname | cut -d ' ' -f 3)
build=$(date +"%Y%m%d")

mv $pacote ${pacote}.old
git clone git+ssh://aur@aur.archlinux.org/${pacote}.git
cp ${pacote}.old/PKGBUILD ${pacote}/ 
cd $pacote
makepkg --printsrcinfo > .SRCINFO
git add PKGBUILD .SRCINFO
git commit -m "Pacote: ${nome} Build: ${build}"
git push
