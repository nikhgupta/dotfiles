#!/usr/bin/env bash
# Summary: Converts colors from RGB to hexadecimal values and vice versa.
# Usage: color-converter ff0000, color-converter 255 255 0 or
# color-converter "#ffcc00"
#
# Feel free to contribute in any way at:
# http://github.com/majjoha/color-converter

# Check that a value is in range 0-255.
valueInRange() {
  if [[ $1 =~ ^([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$ ]]; then
    return 0
  else
    return 1
  fi
}

# Convert a color in RGB to a hexadecimal value.
rgbToHex() {
  if valueInRange $1 && valueInRange $2 && valueInRange $3; then
    printf "rgb($1, $2, $3) -> #%02X%02X%02X\n" $1 $2 $3
  else
    rangeError
  fi
}

# Darken a RGB color by percentage
darkenRgb() {
  red=$(bc <<< "$1 + $4")
  green=$(bc <<< "$2 + $4")
  blue=$(bc <<< "$3 + $4")

  if [[ $(bc <<< "$red < 0") == 1 ]]; then
    red=0
  elif [[ $(bc <<< "$red > 255") == 1 ]]; then
    red=255
  fi

  if [[ $(bc <<< "$green < 0") == 1 ]]; then
    green=0
  elif [[ $(bc <<< "$green > 255") == 1 ]]; then
    green=255
  fi

  if [[ $(bc <<< "$blue < 0") == 1 ]]; then
    blue=0
  elif [[ $(bc <<< "$blue > 255") == 1 ]]; then
    blue=255
  fi

  printf "rgb($1, $2, $3) -> rgb($red, $green, $blue)\n"
}

# Convert a hexadecimal color to RGB.
hexToRgb() {
  if [[ ${1:0:1} == "#" ]]; then
    color=${1:1}
  else
    color=$1
  fi
  if ! [[ $color =~ ^[0-9A-Fa-f]{6}$ ]]; then
    rangeError
  else
    a=${color:0:2}
    b=${color:2:2}
    c=${color:4:2}
    printf "#$color -> rgb(%d, %d, %d)\n" 0x${a} 0x${b} 0x${c} 
  fi
}

inputError() {
  echo "Bad input format. You should apply an argument like ff0000 or 255 255 0."
  exit 1
}

rangeError() {
  echo "Range input error. The input provided was out of range."
  exit 1
}

# Determine if we should run rgbToHex, hexToRgb or simply throw an error.
if [[ "$#" == 3 ]]; then
  rgbToHex $1 $2 $3
elif [[ "$#" == 1 ]]; then
  hexToRgb $1
elif [[ "$#" == 4 ]]; then
  darkenRgb $1 $2 $3 $4
else
  inputError
fi
