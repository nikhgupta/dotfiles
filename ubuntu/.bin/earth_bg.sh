#!/bin/sh
#
# earth_bg.sh - Papel de parede com luz do sol e nuvens sobre a terra em tempo real.
#
# Criado em: 			30-08-2016 16:02:20 AMT
# Última alteração:		30-08-2016 16:02:43 AMT
#
# Por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Cron:
# 10 */1 * * * /bin/sh /home/lucas/bin/earth_bg.sh
#

wget -q -U "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)" http://static.die.net/earth/mercator/1600.jpg -O ${HOME}/.earth_bg.jpg
feh --bg-fill ${HOME}/.earth_bg.jpg
