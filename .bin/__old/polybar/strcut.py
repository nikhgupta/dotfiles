#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Script feito por Lucas Saliés Brum
# Com base em:
# https://www.reddit.com/r/i3wm/comments/3qfpg7/i3blocks_im_trying_to_fix_this_error_could_not/
# https://github.com/8carlosf/dotfiles/blob/master/bin/strcut.py

# Número máximo de caracteres
max = 90

while True:
	try:
		s = str(input())
		if (len(s) > max):
			#s = s[:49] + '...' + s[-50:]  começo...fim
			s = s[:max] + '...'
		print(s)

	except ValueError:
		print("Erro redução da string...")
		continue
	else:
		break
