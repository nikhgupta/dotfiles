#!/bin/sh

DIR=/var/lib/csgo
USER="csgo"
GROUP="csgo"
SESS="csgo"

iniciar() {
	sudo -u $USER tmux new-session -d -s $SESS -d "cd $DIR/server ; $DIR/server/srcds_run -game csgo -usercon +game_type 0 +game_mode 0 +mapgroup mg_bomb_se +map de_dust2 +sv_setsteamaccount CB38BACAD5852BD63062585A5764CE46 -net_port_try 1"
}

conectar() {
	sudo -u $USER tmux attach -t $SESS
}

parar() {
	sudo -u $USER tmux send-keys -t $SESS 'quit' C-m
}

function reiniciar {
	parar
	sleep 5
	iniciar
}

atualizar() {
	cd $DIR/steamcmd
	sudo -u $USER ./steamcmd.sh +runscript csgo.txt
}

consertar() {
	sudo chown -R $USER:$GROUP $DIR
}

case "$1" in
	attach)	conectar ;;
	start) iniciar ;;
	stop) parar	;;
	restart) reiniciar ;;
    update) atualizar ;;
    fix) consertar ;;
	*) echo "Uso: $0 attach|start|stop|restart|update|fix" ;;
esac

exit 0
