#!/bin/bash

options="-p 2211 -o allow_other"

os=$(dialog --menu "OS info" 10 40 3 "Linux" "" "Solaris" "" "HPUX" "" 3>&1 1>&2 2>&3)

#sshfs radio@artemis:/usr/local/musicas /home/lucas/sshfs/artemis $options
#mc /home/lucas/audio /home/lucas/sshfs/artemis
#fusermount -u /home/lucas/sshfs/artemis


echo $os
