#!/usr/bin/env bash
#
# ---------------------------------------------------------------------
#
#   Summary:     Print various color codes in the terminal
#   Author:      Nikhil Gupta
#   Description: This script echoes a bunch of color codes to the
#                terminal to demonstrate what's available.  Each line is
#                the color code of one forground color, out of 17
#                (default + 16 escapes), followed by a test use of that
#                color on all nine background colors (default + 8 escapes).
#   Usage:       colortest
#
# ---------------------------------------------------------------------
#

# Run other scripts
perl $(dirname $0)/color-spaces.perl
bash $(dirname $0)/color-lines.sh
bash $(dirname $0)/color-columns.sh
