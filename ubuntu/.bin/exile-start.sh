#!/bin/bash
#
# ARMA3 Exile Mod Server Start Script
#
# Created by sistematico.
#

#=======================================================================
#========               CONFIGURATION PARAMETERS                ========
#======== MUST BE EDITED MANUALLY TO FIT YOUR SYSTEM PARAMETERS ========
#=======================================================================

USERNAME="steam" # This user *MUST* exist on the system.
EXILE_DIR="/var/lib/${USERNAME}/arma3" # Change to your path...
NAME="exile" # You can use any name here, your server, or clan...
TMUX_SESSION="exile" # You can use any name here.
CONFIGFOLDER="${EXILE_DIR}/${NAME}"
CONFIG="${NAME}/config.cfg" # Remember to move config files from @exileserver/*.cfg to YOUR_INSTANCE_NAME/!
CFG="${NAME}/basic.cfg" # Remember to move config files from @exileserver/*.cfg to YOUR_INSTANCE_NAME/!
BEPATH="${EXILE_DIR}/battleye"
LOG_DIR="${CONFIGFOLDER}/logs"
PORT=2302
PIDFILE="${CONFIGFOLDER}/${PORT}.pid"

if [ -f ${PIDFILE} ]; then
	RUNNING=1
	PID=$(cat ${PIDFILE} > /dev/null)
else
	RUNNING=0
fi

SERVICE="arma3server"
MODS="@exile"
SERVERMOD="@exileserver"
#CPU_COUNT=2

# Some common options
# -ip=0.0.0.0
# -port=2302 (default)
# -mod=@exile;kart;mark;heli;
# -servermod=@exileserver
# -config=C:\Arma\Server\@exileserver\config.cfg
# -cfg=C:\Arma\Server\@exileserver\basic.cfg
# -name=INSTANCE
# -profiles=INSTANCE
# -log
# -nolog
# -world=empty
# -nosplash
# -nosound
# -nopause
# -malloc=system -malloc=tbbmalloc
# -autoinit
OPTIONS="-port=${PORT} -pid=${PIDFILE} -name=${NAME} -profiles=${NAME} -cfg=${CFG} -config=${CONFIG} -mod=${MODS} -servermod=${SERVERMOD} -nopause -nosound -nosplash -autoinit"

#=======================================================================
# CONFIG END
#=======================================================================

TMUX=$(which tmux)

[ ! -x "$TMUX" ] && echo "Tmux not found" >&2 && exit 1

if [ ! -d "$LOG_DIR" ]; then
    echo "${LOG_DIR} not found. Creating..."
    mkdir -p $LOG_DIR
fi

exile_start() {
    if [ ! -f $EXILE_DIR/$SERVICE ]
    then
        echo "$SERVICE not found! Stopping..."
        sleep 1
        exit
    else
        if  [ ${RUNNING} -eq 1 ];
        then
            echo "$SERVICE is already running!"
        else
            echo "Starting $SERVICE..."
            cd $EXILE_DIR

            if [ "${2}" == "-silent" ]; then
                su ${USERNAME} -c "${TMUX} new-session -d -s ${TMUX_SESSION} \"./${SERVICE} ${OPTIONS} > ${LOG_DIR}/exile.log 2> ${LOG_DIR}/errors.log\""
            else
                su ${USERNAME} -c "${TMUX} new-session -d -s ${TMUX_SESSION} \"./${SERVICE} ${OPTIONS} 2> ${LOG_DIR}/errors.log | tee ${LOG_DIR}/exile.log\""
            fi

            echo "Searching Process ${SERVICE}..."
            sleep 8

            if pgrep -u $USERNAME -f $SERVICE > /dev/null
            then
                echo "$SERVICE is now running."
				RUNNING=1
            else
                echo "Error! Could not start $SERVICE!"
				RUNNING=0
            fi
        fi
    fi
}

exile_stop() {
    if [ ${RUNNING} -eq 1 ];
    then
        echo "Stopping ${SERVICE}..."
        su $USERNAME -c "$TMUX kill-session -t $TMUX_SESSION"
        $TMUX kill-session -t $TMUX_SESSION
        killall -9 $SERVICE
    else
        echo "$SERVICE is stopped."
    fi

    if [ -f ${PIDFILE} ]; then
        rm -f ${PIDFILE}
    fi
}

exile_status() {
    if [ -f ${PIDFILE} ]; then
        PID=$(cat ${PIDFILE})
        echo "Server is running (PID=${PID})..."
    else
        echo "Server not running..."
        exit 0
    fi
}

exile_fix() {
	cd $EXILE_DIR
	echo "Setting Permissions..."
	chown -R $USERNAME:$USERNAME /home/$USERNAME
	# Fix: http://www.exilemod.com/topic/6054-linux-dedicated-server-setup-guide-debian-7/?do=findComment&comment=28274
	echo "Fix Uppercase..."
	find @exile/ -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \;
	find @exileserver/ -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \;
}

case "$1" in
    start)
        exile_start
    ;;

    stop)
        exile_stop
    ;;

    restart)
        exile_stop
		sleep 1
        exile_start
    ;;

    status)
        exile_status
    ;;

    attach)
        su $USERNAME -c "$TMUX at -t $TMUX_SESSION"
    ;;

    fix)
        exile_fix
    ;;

    *)
        echo "$0 (start|stop|restart|status|attach|fix)"
        exit 1
    ;;
esac

exit 0
