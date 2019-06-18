#!/bin/sh

repo="$(basename "$(pwd)")"

echo "Nome de usuário: "
read usuario

echo $user $repo

echo "Tem certza? [s/N]: "
read certeza

if [ "$certeza" == "s" ]; then
	git remote set-url origin git@github.com:usuario/repositorio.git
fi
