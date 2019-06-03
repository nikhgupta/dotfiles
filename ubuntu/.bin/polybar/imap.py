#!/usr/bin/python

import imaplib, sys

# Comente
from imapcfg import *
# Descomente e preencha
#login = ["SEU_LOGIN","LOGIN2"]
#senha = ["SUA_SENHA","SENHA2"]
#host = ["host1","host2"]

params = len(sys.argv)

if params > 1:
    if sys.argv[1] == 1:
        l = login[0]
        s = senha[0]
        h = host[0]
    if sys.argv[1] == 2:
        l = login[1]
        s = senha[1]
        h = host[1]
else:
    l = login[0]
    s = senha[0]
    h = host[0]

obj = imaplib.IMAP4_SSL(h, 993)
obj.login(l, s)
obj.select()
mensagens = len(obj.search(None, 'unseen')[1][0].split())

if mensagens > 0:
	print(mensagens)
