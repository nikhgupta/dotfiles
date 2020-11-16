#!/usr/bin/env python2.7
#-*- coding: utf-8 -*-
# pipe.alfredworkflow, v1.1
# Robin Breathe, 2013-2017

from __future__ import unicode_literals
from __future__ import print_function

import alfred
import json, sys, os

from fnmatch import fnmatch
from os import path
from time import strftime

DEFAULT_MAX_RESULTS=9
DEFAULT_ALIAS_TERMINATOR="@@@"
ALIASES_FILE="aliases.json"
BUILTINS_FILE="builtins.json"

def fetch_aliases(_path):
    file = path.join(alfred.work(volatile=False), _path)
    if not path.isfile(file):
        return {}
    return json.load(open(file, 'r'))

def write_aliases(_dict, _path):
    file = path.join(alfred.work(volatile=False), _path)
    json.dump(_dict, open(file, 'w'), indent=4, separators=(',', ': '))

def define_alias(_dict, definition, alias_file):
    if '=' in definition:
        (alias, pipe) = definition.split('=', 1)
    else:
        (alias, pipe) = (definition, '')

    terminator = os.getenv("alias_terminator", DEFAULT_ALIAS_TERMINATOR);

    if not alias:
        return alfred.xml([alfred.Item(
            attributes = {'valid': 'no'},
            title = "alias NAME=ARBITRARY-ONE-LINER",
            subtitle = "Terminate ONE-LINER with '{0}' to save or 'NAME={0}' to delete alias".format(terminator),
            icon = 'icon.png'
        )])

    if pipe and pipe == terminator:
        _dict.pop(alias, None)
        write_aliases(_dict, alias_file)
        return alfred.xml([alfred.Item(
            attributes = {'valid': 'no', 'autocomplete': ''},
            title = "alias {0}={1}".format(alias, pipe),
            subtitle = 'Alias deleted! TAB to continue',
            icon = 'icon.png'
        )])


    if pipe and pipe.endswith(terminator):
        pipe = pipe[:-len(terminator)]
        _dict[alias] = pipe
        write_aliases(_dict, alias_file)
        return alfred.xml([alfred.Item(
            attributes = {'valid': 'no', 'autocomplete': alias},
            title = "alias {0}={1}".format(alias, pipe),
            subtitle = 'Alias saved! TAB to continue',
            icon = 'icon.png'
        )])
    
    return alfred.xml([alfred.Item(
        attributes = {'valid': 'no'},
        title = "alias {0}={1}".format(alias, pipe),
        subtitle = 'Terminate with {0} to save'.format(terminator),
        icon = 'icon.png'
    )])

def exact_alias(_dict, query):
    pipe = _dict[query]
    return alfred.xml([alfred.Item(
        attributes = {'uid': 'pipe:{}'.format(pipe), 'arg': pipe},
        title = pipe,
        subtitle = '(expanded alias)',
        icon = 'icon.png'
    )])

def match_aliases(_dict, query):
    results = []
    for (alias, pipe) in _dict.iteritems():
        if (pipe != query) and fnmatch(alias, '{}*'.format(query)):
            results.append(alfred.Item(
                attributes = {'uid': 'pipe:{}'.format(pipe) , 'arg': pipe, 'autocomplete': pipe},
                title = pipe,
                subtitle = '(alias: {})'.format(alias),
                icon = 'icon.png'
            ))
    return results

def fetch_builtins(_path):
    return json.load(open(_path, 'r'))

def match_builtins(_dict, query):
    results = []
    for (pipe, desc) in _dict.iteritems():
        if fnmatch(pipe, '*{}*'.format(query)) or fnmatch(desc, '*{}*'.format(query)):
            results.append(alfred.Item(
                attributes = {'uid': 'pipe:{}'.format(pipe) , 'arg': pipe, 'autocomplete': pipe},
                title = pipe,
                subtitle = '(builtin: {})'.format(desc),
                icon = 'icon.png'
            ))
    return results

def verbatim(query):
    return alfred.Item(
        attributes = {'uid': 'pipe:{}'.format(query), 'arg': query},
        title = query,
        subtitle = None,
        icon = 'icon.png'
    )

def complete():
    query = sys.argv[1]

    max_results = int(os.getenv('max_results', DEFAULT_MAX_RESULTS))
    load_builtins = bool(os.getenv('builtins_file', "yes") == "yes")

    aliases = fetch_aliases(ALIASES_FILE)
    builtins = load_builtins and fetch_builtins(BUILTINS_FILE) or {}

    if query.startswith('alias '):
        return define_alias(aliases, query[6:], ALIASES_FILE)

    results = []

    if query not in builtins:
        results.append(verbatim(query))

    for matches in (
        match_aliases(aliases, query),
        match_builtins(builtins, query)
    ):
        results.extend(matches)

    return alfred.xml(results, maxresults=max_results)

if __name__ == '__main__':
    print(complete())
