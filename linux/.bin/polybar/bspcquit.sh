#!/bin/bash

for window_id in $(bspc query -W); do
  bspc window $window_id -c
done
