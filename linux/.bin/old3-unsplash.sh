#!/bin/bash
#
# Script para alterar o papel de parede e o background do lightdm
# com uma imagem aleatória de unsplash.com
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em: 20/12/2017 19:27:31 
# Última Atualização: 25/12/17 00:17:21
# Evaluate: ! date +"%d/%m/%y %H:%M:%S"

which xdpyinfo >/dev/null 2>&1 || { echo >&2 "O programa xdpyinfo não está instalado. Abortando."; exit 1; }
which file >/dev/null 2>&1 || { echo >&2 "O programa file não está instalado. Abortando."; exit 1; }

nome="unsplash-$(date +'%Y-%m-%d').jpg"
dir="${HOME}/img/wallpapers/unsplash"
dirl="/usr/share/backgrounds/lightdm"
rand=$(shuf -i 1000-9999 -n 1)
x=$(xdpyinfo | awk -F '[ x]+' '/dimensions:/{print $3}')
y=$(xdpyinfo | awk -F '[ x]+' '/dimensions:/{print $4}')
max=1

function excesso {
    tamanho=$(du -cm "$1" | tail -1 | grep -o '[0-9]*')
    caminho=$(ls -t1 "$1" | tail -1)
    maximo=$(($2*1024))

    if [ $3 ]; then
        superuser=$3
    fi    
    
    if [ $tamanho -gt $maximo ]; then    
        echo "Resumo:"
        echo "Tamanho: $tamanho"
        echo "Maximo: $max"
        echo "Imagem a ser removida: $caminho" 
        echo "$superuser rm -f $caminho"
    fi
}

function lightdm_unsplash {
    if sudo true; then

        if [ -f ~/.unsplash ]; then
            arquivo=$(cat ~/.unsplash)
        else
            arquivo=$(ls -t1 "$dir" | tail -1)
            if [ ! -f $arquivo ]; then
                unsplash
            fi
        fi

        if [ -f /etc/lightdm/lightdm-gtk-greeter.conf ]; then 
            [ ! -d $dirl ] && sudo mkdir -p $dirl
            
            sudo cp $arquivo $dirl
            nome=$(basename $arquivo)
            
            if [ ! -f /etc/lightdm/lightdm-gtk-greeter-${data}.conf ]; then 
                sudo cp /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter-${data}.conf
            fi

            if grep -q '^#background' /etc/lightdm/lightdm-gtk-greeter.conf; then
                echo "A linha #background= existe!"
                nome_lightdm=$(echo "${dirl}/${nome}" | sed 's/\//\\\//g')
                sudo sed -i "0,/^#background.*/s//background=${nome_lightdm}/" /etc/lightdm/lightdm-gtk-greeter.conf
            fi

            if grep -q '^background' /etc/lightdm/lightdm-gtk-greeter.conf; then
                echo "A linha background= existe!"
                nome_lightdm=$(echo "${dirl}/${nome}" | sed 's/\//\\\//g')
                sudo sed -i "0,/^background.*/s//background=${nome_lightdm}/" /etc/lightdm/lightdm-gtk-greeter.conf
            fi

            excesso $dirl $max root
        fi
    fi
}

function unsplash {

    [ ! -d $dir ] && mkdir -p $dir
    arquivo=$dir/${nome}.jpg

    if [ ! -f $1 ]; then
        curl -L -s "https://unsplash.it/${x}/${y}?random" > /tmp/${nome}.jpg

        while : ; do
            if [ -f $arquivo ]; then
                i=$(($i+1))
                arquivo=$dir/$nome-${i}.jpg
                echo "Existe, renomeando para ${arquivo}..."
            else
                break
            fi
        done        
    fi

    [ ! -f $arquivo ] && [ -f $1 ] && cp $1 $arquivo

    if [ -f $arquivo ]; then
        if [ "$DESKTOP_SESSION" == "mate" ]; then 
            gsettings set org.mate.background picture-filename "$arquivo"
        elif [ "$DESKTOP_SESSION" == "i3" ]; then
            which feh >/dev/null 2>&1 && { feh --bg-fill "$arquivo"; }
        fi  
        excesso $dir $max root
    fi  

    echo $arquivo > ~/.unsplash
}

if [ "$1" != "-u" ]; then
    if [ -f ~/.unsplash ]; then
        unsplash $(cat ~/.unsplash)
    else
       unsplash
       lightdm_unsplash
    fi
else
    unsplash
    lightdm_unsplash
fi



