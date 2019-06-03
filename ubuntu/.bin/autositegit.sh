#!/bin/bash
#
# AutoSite_Git.sh
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em:           06-03-2016 21:15:28
# Última alteração em: 06-03-2016 21:15:28

nome="sistematico"
dir="${HOME}/github"
repo="${nome}.github.io"

if [ ! -d "$dir" ]
then
	mkdir -p $dir
	cd $dir
    git clone https://github.com/${nome}/${nome}.github.io
fi

if [ -z "$1" ]
then
    desc="Alterações automáticas pelo autosite_git.sh..."	
else
    desc="$*"	
fi

cd $dir/$repo
git add --all
git commit -m "$desc"
git push -u origin master
