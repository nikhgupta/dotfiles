#!/usr/bin/env sh

usuario="simone"
host="neptunium.hopto.org"
porta_interna=5901
porta_externa=5901
porta_dest=5901

ssh -t -L $porta_interna:localhost:$porta_externa $usuario@$host "x11vnc -localhost -ncache 10 -display :0 -rfbport $porta_dest"

#if [ $? == 0 ]; then
#	vncviewer -ViewOnly -PreferredEncoding=ZRLE localhost:1
#fi

