#!/bin/sh
for arquivo in $(ls *.webp)
do
	saida="${arquivo%.*}"
  	dwebp "$arquivo" -o "${saida}.png"
	if [ $? == 0 ]; then
		mv $arquivo ~/.local/share/Trash/
	fi
done
