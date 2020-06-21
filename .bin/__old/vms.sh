#!/usr/bin/env bash
#
# Arquivo: vms.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 01-04-2018 16:31:02
# Última alteração: 01-04-2018 16:48:14

rodando=$(VBoxManage list runningvms)
todas=$(VBoxManage list vms)

for vm in $todas; do
	echo $vm | grep -oP "Guest OS"
done

dialog --title 'Perfil' --menu 'Escolha o perfil da instalação:' 0 0 0 mínima 'Instala o mínimo' completa     'Instala tudo' customizada  'Você escolhe'


#vm=$(dialog --title "$titulo" --inputbox "Opções Adicionais" 8 40 "-p ${porta} -o allow_other" 3>&1 1>&2 2>&3)