#!/bin/sh
#
# hextogpl.sh
# Um script para criar paletas do Agave usando cores hexadecimais.
#
# Exemplo de uso: hextogpl.sh #000000 Preto
# Créditos: https://stackoverflow.com/a/7253786
#
# Dica de paleta
# https://github.com/chriskempson/tomorrow-theme

timestamp=$(date +%s)

if [[ $EUID -eq 0 ]]; then
	paleta="/usr/share/agave/palettes/Custom-${timestamp}.gpl"
else
	paleta="/tmp/Custom-${timestamp}.gpl"
fi

nome="Custom ${timestamp}"

cat > $paleta <<EOL
GIMP Pallete
Name: ${nome}
Columns: 0
#
EOL

while :
do
	read -p "Digite o hexadecimal da cor (digite fim para sair): " cor desc
	if [[ "$cor" == "fim" ]]; then
		break
	fi

	if [[ ${cor:0:1} == "#" ]]; then
		hexinput=$(echo "$cor" | cut -c 2- | tr "[:lower:]" "[:upper:]")
	else
		hexinput=$(echo "$cor" | tr "[:lower:]" "[:upper:]")  # uppercase-ing
	fi

	a=`echo $hexinput | cut -c-2`
	b=`echo $hexinput | cut -c3-4`
	c=`echo $hexinput | cut -c5-6`

	r=`echo "ibase=16; $a" | bc`
	g=`echo "ibase=16; $b" | bc`
	b=`echo "ibase=16; $c" | bc`


	rgba="${r} ${g} ${b} ${desc}"

	echo "$rgba" >> $paleta
done

echo "Arquivo de paletas salvo em $paleta"

exit 0
