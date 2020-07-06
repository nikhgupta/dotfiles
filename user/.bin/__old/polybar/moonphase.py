#!/usr/bin/python2
# -*- coding: utf-8 -*-
"""
moonphase.py - Calculate Lunar Phase
Author: Sean B. Palmer, inamidst.com
Cf. http://en.wikipedia.org/wiki/Lunar_phase#Lunar_phase_calculation
"""

import math, decimal, datetime, sys

dec = decimal.Decimal
params = len(sys.argv)

def position(now=None):
   if now is None:
      now = datetime.datetime.now()

   diff = now - datetime.datetime(2001, 1, 1)
   days = dec(diff.days) + (dec(diff.seconds) / dec(86400))
   lunations = dec("0.20439731") + (days * dec("0.03386319269"))

   return lunations % dec(1)

def phase(pos):
   index = (pos * dec(8)) + dec("0.5")
   index = math.floor(index)
   return {
      0: "@",
      1: "I",
      2: "G",
      3: "D",
      4: "0",
      5: "V",
      6: "T",
      7: "Q"
   }[int(index) & 7]

def phasen(pos):
   index = (pos * dec(8)) + dec("0.5")
   index = math.floor(index)
   return {
      0: "Lua Nova",
      1: "Lua Crescente",
      2: "Quarto Crescente",
      3: "Lua Gibosa",
      4: "Lua Cheia",
      5: "Lua Balsâmica",
      6: "Quarto Minguante",
      7: "Lua Minguante"
   }[int(index) & 7]

def main():
   pos = position()
   phasename = phase(pos)
   phas = phasen(pos)
   roundedpos = round(float(pos), 3)
   if params > 1:
       print "%s, (%s)" % (phas, roundedpos)
   else:
       print "%s" % (phasename)       

if __name__=="__main__":
   main()
