#!/bin/sh

TIM1A=$(date -u +%H)
TIM1=$((10#$TIM1A+1))
if [ $TIM1 -eq 25 ]; then TIM1=1; fi
if [ $TIM1 -eq 24 ]; then TIM1=0; fi
TIM2=$(date -u +%M)
TIM3=$(date -u +%S)
TEM=$(((((10#$TIM1)*3600 + 10#$TIM2*60 + 10#$TIM3)*100)/864))
SITX=$(($TEM / 10))
SIT=$SITX
if [ ${#SIT} -eq 1 ]; then SIT="00"$SITX; fi
if [ ${#SIT} -eq 2 ]; then SIT="0"$SITX; fi
SEC=$(($TEM - ($SITX * 10)))
echo "@"$SIT".("$SEC")"
