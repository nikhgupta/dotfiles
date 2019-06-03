#!/bin/sh

options="-p 2222 -o allow_other"

sshfs root@hefesto:/usr/local/musicas /home/lucas/sshfs/hefesto $options
mc /home/lucas/audio /home/lucas/sshfs/hefesto
fusermount -u /home/lucas/sshfs/hefesto
