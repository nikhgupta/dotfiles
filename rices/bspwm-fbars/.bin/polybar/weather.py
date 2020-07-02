#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import requests
import datetime

# Comente a linha abaixo!!!
# from weathercfg import *

# Descomente e preencha (http://openweathermap.org/help/city_list.txt)
CITY = "1269515"
# Faça uma conta em https://home.openweathermap.org/users/sign_up e copia sua API aqui...
#API_KEY = "SUA_API_KEY"
API_KEY = os.environ['OPENWEATHERMAP_API_KEY']
UNITS = "Metric"
UNIT_KEY = "C"

try:
    REQ = requests.get("http://api.openweathermap.org/data/2.5/weather?id={}&appid={}&units={}".format(CITY, API_KEY, UNITS))
    if REQ.status_code == 200:
        CURRENT = REQ.json()["weather"][0]["description"].capitalize()
        VELOCIDADE = REQ.json()["wind"]["speed"]
        #DIRECAO = REQ.json()["wind"]["deg"]
        PRESSAO = REQ.json()["main"]["pressure"]
        #VISIBILIDADE = REQ.json()["visibility"]
        HUMIDADE = REQ.json()["main"]["humidity"]
        ID = int(float(REQ.json()["weather"][0]["id"]))
        TEMP = int(float(REQ.json()["main"]["temp"]))
        HOUR = datetime.datetime.now().hour

        #for k, v in REQ.json().iteritems():
        #    print k, v

        #if DIRECAO > 270 and DIRECAO <= 45:
        #    DIRECAO = "norte"
        #elif DIRECAO > 45 and DIRECAO <= 135:
        #    DIRECAO = "norte"
        #elif DIRECAO > 135 and DIRECAO <= 225:
        #    DIRECAO = "sul"
        #elif DIRECAO > 225 and DIRECAO <= 270:
        #    DIRECAO = "oeste"

        if ID >= 200 and ID <= 232:
            ICON = ""
        elif ID == 300:
            ICON = ""
        elif ID == 501 or ID == 500 or ID == 520:
            ICON = ""
        elif ID == 521:
            ICON = ""
        elif ID >= 310 and ID <= 531:
            ICON = ""
        elif ID >= 600 and ID <= 622:
            ICON = ""
        elif ID >= 701 and ID <= 761:
            ICON = ""
        elif ID >= 801 and ID <= 804:
            if HOUR >= 6 and HOUR <= 19:
                ICON = ""
            else:
                ICON = ""
        elif ID >= 900 and ID <= 902 or ID >= 957 and ID <= 962:
            ICON = ""
        elif ID == 903 or ID == 906:
            ICON = ""
        elif ID == 904:
            ICON = ""
        elif ID == 905 or ID >= 951 and ID <= 956:
            ICON = ""
        else:
            if HOUR >= 6 and HOUR <= 19:
                ICON = ""
            else:
                ICON = ""
        #print("%%{F#FFF}%s %%{F-}%s  %i°%s  %s%%  %s  %skm/h  %shPa " % (ICON, CURRENT, TEMP, UNIT_KEY, HUMIDADE, DIRECAO, VELOCIDADE, PRESSAO)) # Icon with description
        print("%%{F#FFF}%s %%{F-}%s  %i°%s  %s%%  %skm/h  %shPa " % (
            ICON, CURRENT, TEMP, UNIT_KEY, HUMIDADE, VELOCIDADE, PRESSAO)) # Icon with description

except requests.exceptions.RequestException:  # This is the correct syntax
    print("Recuperando condições do clima.") # Icon with description
