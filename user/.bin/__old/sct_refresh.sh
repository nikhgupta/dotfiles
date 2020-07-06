#!/bin/sh
# 
# sct_refresh.sh: Create and Refresh a SC Trans playlist
#
# Developed by Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
# Based on "Dytut" work:
# http://forums.winamp.com/showpost.php?p=1806538&postcount=6
#
# Suggested cronjob: */5 * * * * /bin/sh /home/shoutcast/bin/sct_refresh.sh
#  

# Vars
TRANS_PID=$(pidof sc_trans)
TRANS_FIND=$(which find)
TRANS_KILL=$(which kill)
TRANS_CHOWN=$(which chown)
TRANS_PATH="/usr/local/musicas/"
TRANS_LIST="/home/shoutcast/lista.lst"
TRANS_USER="shoutcast"
TRANS_GROUP="shoutcast"

# DONT CHANGE BELOW

# Create playlist
$TRANS_FIND $TRANS_PATH -iname "*.mp3" > $TRANS_LIST

# Reload new playlist
$TRANS_KILL -SIGUSR1 $TRANS_PID

# turn shuffle on/off
# $TRANS_KILL -s USR2 $TRANS_PID

# Change permissions
$TRANS_CHOWN ${TRANS_USER}:${TRANS_GROUP} $TRANS_LIST
