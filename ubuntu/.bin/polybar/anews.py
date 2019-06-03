#!/usr/bin/python
# Depends on python-feedparser
# Read Arch Linux RSS news;
#!/bin/python
# -*- coding: utf-8 -*-

import feedparser
from subprocess import call
import re
import textwrap

icone = ""

try:
    d = feedparser.parse("https://www.archlinux.org/feeds/news/")
    for f in range(0,1):
        print("%s %s" % (icone, d.entries[f].title))
        xy = d.entries[f].title
except:
    print("%{F#66ffffff} Impossível recuperar as notícias.%{F-}")