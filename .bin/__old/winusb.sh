#!/bin/sh

apps=( "mkfs.ntfs" "ms-sys" )

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

if [ "$(id -u)" != "0" ]; then
	echo "Este script precisa rodar como root."
	exit 1
fi

if [ ! "$2" ]; then
	echo
	echo "Uso: $0 [iso] [device]"
	echo "Exemplo: $0 /tmp/windows.iso /dev/sdb"
	echo
	exit 1
fi

mkfs.ntfs -f ${2}1
ms-sys -7 ${2}
mkdir -p /mnt/usb /mnt/iso
mount -o loop ${1} /mnt/iso
mount ${2}1 /mnt/usb
cp -r /mnt/iso/* /mnt/usb/
sync && sync
