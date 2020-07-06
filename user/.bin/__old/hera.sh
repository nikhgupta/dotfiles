#!/bin/sh

options="2211 allow_other"

sshfs radio@artemis:/usr/local/musicas /home/lucas/sshfs/artemis $options
mc /home/lucas/sshfs/artemis
fusermount -u /home/lucas/sshfs/artemis
