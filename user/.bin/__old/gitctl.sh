#!/usr/bin/env bash
#
# Arquivo: gitctl.sh
#
# Feito por Lucas Saliés Brum, lucas@archlinux.com.br
#
# Criado em: 2018-05-24 16:09:58
# Última alteração: 2018-05-24 16:19:17
#
# Source: https://gist.github.com/alexpchin/dc91e723d4db5018fef8
#
# Copie sua chave pública para o github.

novo() {
	touch README.md
	git init
	git add README.md
	git commit -m "first commit"
	git remote add origin git@github.com:alexpchin/<reponame>.git
	git push -u origin master
}

existente() {
	git remote add origin git@github.com:alexpchin/<reponame>.git
	git push -u origin master
}

ends=$(curl -s "https://api.github.com/users/sistematico/repos?per_page=100" | grep -o 'git@[^"]*')

for repo in $ends; do
	#echo ${repo##*/}
	r=$(basename "$repo")
	echo ${r%.*}
done