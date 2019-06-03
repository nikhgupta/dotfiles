#!/bin/bash
#
# unsplash_bg.sh - Baixa uma imagem do site unsplash.com
# salva e define como papel de parede.
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em:           09-04-2016 08:44:09 AMT
# Última alteração em: 30-08-2016 12:32:04 AMT 

# Modo 0 sobreescreve as imagens, modo 1 salva
modo=0
path="${HOME}/tmp/unsplash"

if [ "$DESKTOP_SESSION" == "openbox" ]; then
	apps=( "wget" "xrandr" "feh" ) 
else
	apps=( "wget" "xrandr" ) 
fi

for app in ${apps[@]} 
do
	which $app 1> /dev/null 2> /dev/null
	if [ $? != 0 ]; then
		echo
		echo "O aplicativo $app não foi encontrado."
		echo "Abortando..."
		echo
		exit 1
	fi
done

if [ "$1" == "--restore" ]; then
	if [ -f ${HOME}/.wallpaper ]; then
	
		if [ "$DESKTOP_SESSION" == "mate" ]; then
			gsettings set org.mate.background picture-filename "$(cat ${HOME}/.wallpaper)"
		elif [ "$DESKTOP_SESSION" == "gnome" ]; then
			gsettings set org.gnome.desktop.background picture-uri "file://$(cat ${HOME}/.wallpaper)"
		else
			feh --bg-fill "$(cat ${HOME}/.wallpaper)"
		fi	

		exit 0
	else
		echo "Nenhum papel de parede salvo."
		exit 1
	fi
fi

if [ ! -d $path ]; then
	echo "O diretório $path não existe, deseja criar? [s/N]"
	read resposta
	
	if [ "$resposta" == "s" ]; then
		mkdir -p $path
	else
		echo "Saindo..."
		exit 0
	fi
	
fi

if [ $modo == 1 ] || [ "$1" == "--keep" ]; then
	imagem="${path}/unsplash-$(date +%d%m%y-%H%M%S).jpg"
else 
	imagem="${path}/unsplash.jpg"
fi

altura=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)                 
largura=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)                
endereco="https://unsplash.it/${altura}/${largura}/?random"

# Baixa o papel de parede
wget "$endereco" -O "$imagem" >/dev/null 2>&1

# Troca o papel de parede
if [ "$DESKTOP_SESSION" == "mate" ]; then
	gsettings set org.mate.background picture-filename "$imagem"
elif [ "$DESKTOP_SESSION" == "gnome" ]; then
	gsettings set org.gnome.desktop.background picture-uri "file://$imagem"
else
	feh --bg-fill "$imagem"
fi

# Grava o path da imagem em um arquivo de texto
echo ${imagem} > ${HOME}/.wallpaper
