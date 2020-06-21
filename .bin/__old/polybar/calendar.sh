#!/bin/bash

case $1 in
    short)
        echo $(date +'%d/%m')
    ;;
    full)
        echo $(date +'%d/%m/%Y')
    ;;
esac


