#!/bin/bash

case $1 in
	bitcoin) 
		#url='https://api.coinmarketcap.com/v1/ticker/bitcoin/'
		saida=$(curl -sH 'CB-VERSION: 2015-04-08' -H 'Accept-Language: pt-br' 'https://api.coinbase.com/v2/prices/buy?currency=BRL' | jq -r '.data.amount' | LC_NUMERIC="en_US.UTF-8" awk '{printf("%.2f\n", $1)}')
	;;  

		#url='https://api.coinmarketcap.com/v1/ticker/bitcoin/'
		saida=$(curl -sH 'CB-VERSION: 2015-04-08' -H 'Accept-Language: pt-br' 'https://api.coinbase.com/v2/prices/buy?currency=BRL' | jq -r '.data.amount' | LC_NUMERIC="en_US.UTF-8" awk '{printf("%.2f\n", $1)}')

    *) 
    	saida=$(curl -sH 'Accept-encoding: gzip' 'https://www.mercadobitcoin.net/api/BTC/ticker/' | gunzip - | jq -r '.ticker.last' | awk '{printf("%.2f", $1)}')
    ;;
esac

echo "$saida"
