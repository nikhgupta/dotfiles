#!/bin/bash

cat ${HOME}/.config/polybar/cores/amarelo > ${HOME}/.config/polybar/config
cat ${HOME}/.config/polybar/principal >> ${HOME}/.config/polybar/config

~/.config/polybar/launch.sh
