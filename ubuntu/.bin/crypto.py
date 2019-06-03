#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json, requests, sys

PRICE_CHANGE_PERIOD = '1h'
PRICE_CHANGE_URGENT_PERCENT = 10
API_URL = 'https://api.coinmarketcap.com/v1/ticker/{}/'
API_CONVERT = 'https://currency-api.appspot.com/api/{}/{}.json'
 
total = len(sys.argv)

if total == 2:
    coin = sys.argv[1]
    moeda = "BRL"
    sinal = moeda
elif total == 3:
    coin = sys.argv[1]
    moeda = sys.argv[2]
    sinal = moeda
elif total == 4:
    coin = sys.argv[1]
    moeda = sys.argv[2]
    sinal = sys.argv[3]
else:
    coin = "bitcoin"
    moeda = "BRL"
    sinal = moeda

r = requests.get(API_URL.format(coin))
data = json.loads(r.text)[0]
price = float(data['price_usd'])
end = '%{F-}'

# Convert
def conv(moeda,valor):
    req = requests.get(API_CONVERT.format('USD',moeda))
    taxa = req.json()['rate']
    value = valor*float(req.json()['rate'])
    return value

if price > 100: precision = 0
elif price > 0.1: precision = 2
else: precision = 6

percentChange = float(data['percent_change_' + PRICE_CHANGE_PERIOD])
#percentChangeFormat = '{}{}{:.2f}%{}'
percentChangeFormat = '{}{:.2f}%'

#if percentChange > 0: percentChangeInfo = percentChangeFormat.format('%{F#9FE697}', '', percentChange, end)
#elif percentChange == 0: percentChangeInfo = percentChangeFormat.format('%{F#CCCCCC}', '', percentChange, end)
#else: percentChangeInfo = percentChangeFormat.format('%{F#BF616A}', '', percentChange, end)
if percentChange > 0: percentChangeInfo = percentChangeFormat.format('', percentChange)
elif percentChange == 0: percentChangeInfo = percentChangeFormat.format('', percentChange)
else: percentChangeInfo = percentChangeFormat.format('', percentChange)

if moeda != "USD":
    vlr = conv(moeda,price)
else:
    vlr = price

#print("Valor em reais: R$%s" % vlr)
print(('{} {:.' + str(precision) + 'f} {}').format(sinal, vlr, percentChangeInfo))
#print("Valor em dolares: $%s").format(price)
#print(({}).format(percentChangeInfo))