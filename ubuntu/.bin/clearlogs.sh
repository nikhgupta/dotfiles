#!/bin/sh

if [ $UID = 0 ]; then
	journalctl --flush --rotate
	journalctl --vacuum-size=1K
	journalctl --verify
else
	if sudo true; then
    	sudo journalctl --flush --rotate
    	sudo journalctl --vacuum-size=1K
    	sudo journalctl --verify
	else
		echo "Necessita de permissões de super-usuário."
	fi
fi
