#!/usr/bin/env sh

USER=$1
HOST=$2
PORT=2210
OPTIONS="allow_other"
MONT="${HOME}/sshfs/${HOST}"
RPATH="/home/${USER}"

if [ ! -d $MONT ]; then
	mkdir -p $MONT
fi

if [ "$3" ]; then
	RPATH=$3
fi

if [ "$4" ]; then
	PORT=$4
fi

if [ "$5" ]; then
    OPTIONS=$5
fi

versao() {
	echo "$(basename $0) v0.1"
	echo
	echo "Por Lucas Saliés Brum"
	echo "a.k.a. sistematico <lucas at archlinux dot com dot br>"
}

erro() {
	echo "Numero errado de parametros."
}

uso() {
	echo "Uso: $(basename $0) [usuario] [host]"
	echo "     $(basename $0) -u [usuario] [host] [remote_path]"
	echo "     $(basename $0) -u [usuario] [host] [remote_path] [port]"
	echo "     $(basename $0) -u [usuario] [host] [remote_path] [port] [options]"
	echo
	echo "     $(basename $0) -u [host]"
	echo
	echo "Exemplos: $(basename $0) lucas site.com /home/lucas 2222 allow_other"
	echo "$(basename $0) -u site.com"
}

if [ "$1" == "-u" ]; then
	if [ "$#" == 2 ]; then
		fusermount -u ${MONT}
		exit 0
	else
		echo
		erro
		echo
		uso
		echo
		exit 0
	fi
elif [ "$1" == "-h" ]; then
	echo
	uso
	echo
	exit 0
elif [ "$1" == "-v" ]; then
	echo
	versao
	echo
	exit 0
else
	if [ "$#" -gt 1 ]; then
		sshfs ${USER}@${HOST}:${RPATH} ${MONT} -C -p $PORT -o $OPTIONS
	else
		echo
		erro
		echo
		uso
		echo
		exit 0
	fi
fi
