#!/bin/sh
LOG="/root/uso.log"
DATA='date +"%d-%m-%Y %H:%m:%S"'
echo >> $LOG
echo "Data: $DATA" 
echo "-------------------- INICIO --------------------" >> $LOG
#ps aux | sort -r -k 3,3 | head -n 10
ps -eo pcpu,pid,user,args | sort -k 1 -r | head -6
echo "--------------------- FIM ----------------------" >> $LOG
