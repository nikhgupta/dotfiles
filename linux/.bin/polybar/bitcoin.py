#!/usr/bin/python3

import os, math, ccxt, datetime, time

try:
  creds = {"apiKey": os.environ["BINANCE_API_KEY"], "secret": os.environ["BINANCE_SECRET"]}
  b = ccxt.binance(creds)
  tickers, balances = b.fetch_tickers(), b.fetch_balance()

  btc_rate = float(tickers['BTC/USDT']['last'])
  balances = {x['asset']: float(x['locked'])+float(x['free']) for x in balances["info"]["balances"]}
  balances = {k: v for k,v in balances.items() if v > 0}
  tickers = {k[:-4]: float(v['last']) for k,v in tickers.items() if k[-3:] == "BTC"}
  summary = [((k, v, tickers[k]*v if k in tickers else (v if k=="BTC" else 0))) for k,v in balances.items()]
  summary = sorted(summary, key=lambda x: x[-1], reverse=True)
  total_btc = math.fsum([k[2] for k in summary])
  total_usd = total_btc*btc_rate

  print(" %0.8f $ %0.2f" % (total_btc, total_usd))
except Exception as e:
  pass
