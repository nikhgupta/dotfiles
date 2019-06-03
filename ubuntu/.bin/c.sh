#!/bin/bash
#
#   This file echoes a bunch of color codes to the 
#   terminal to demonstrate what's available.  Each 
#   line is the color code of one forground color,
#   out of 17 (default + 16 escapes), followed by a 
#   test use of that color on all nine background 
#   colors (default + 8 escapes).
#

  for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
    do echo -en "\033[$BG  \033[0m";
  done
