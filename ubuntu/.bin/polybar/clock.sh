#!/bin/bash

case $1 in
    1)
        echo $(date +'%H:%M')
    ;;
    2)
        echo $(date +'%H:%M:%S')
    ;;
esac


