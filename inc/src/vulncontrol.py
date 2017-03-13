#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from sys import exit
from datetime import datetime
from urllib.parse import urlparse, urlencode
from urllib.request import urlopen
from urllib.error import HTTPError
from json import loads
import argparse

__author__ = 'Amet13'

today = datetime.now().strftime('%Y-%m-%d')

# Arguments parsing
parser = argparse.ArgumentParser()
parser.add_argument('-d', default=today, dest='DATE')
parser.add_argument('-m', default='0', dest='MINCVSS')
parser.add_argument('-t', default='', dest='TOKENID', nargs=2)

namespace = parser.parse_args()

try:
    token = namespace.TOKENID[0]
    telegramid = namespace.TOKENID[1]
except(IndexError):
    token = ''
    telegramid = ''

date = namespace.DATE
mincvss = namespace.MINCVSS

year = date.split('-')[0]
month = date.split('-')[1]

turl = 'https://api.telegram.org/bot'
tfull = '{0}{1}/sendMessage'.format(turl, token)

ids = []
cves = []
tcves = []
# Maximum rows for one product
numrows = 30

feedlink = 'https://www.cvedetails.com/json-feed.php'
source = open('products.txt', 'r')

# Getting product IDs from file
for line in source:
    if not line.startswith('#') and line.strip():
        parsed = urlparse(line)
        path = parsed[2]
        pathlist = path.split('/')
        ids.append(pathlist[2])

source.close()

# Get JSON for out products by date
try:
    for x in ids:
        # Link example:
        # https://www.cvedetails.com/json-feed.php?product_id=47&year=2017&month=02
        link = '{0}?product_id={1}&month={2}&year={3}&cvssscoremin={4}&numrows={5}' \
            .format(feedlink, x, month, year, mincvss, numrows)

        # Going to URL and get JSON
        getjson = urlopen(link)
        jsonr = getjson.read()
        for y in range(0, numrows):
            try:
                jp = loads(jsonr.decode('utf-8'))[y]
                if jp['publish_date'] == date:
                    result = '{0} {1} {2}' \
                        .format(jp['cve_id'], jp['cvss_score'], jp['url'])
                    tresult = 'CVSS: {0} URL: {1}' \
                        .format(jp['cvss_score'], jp['url'])
                    # Keep results in arrays
                    cves.append(result)
                    tcves.append(tresult)
            except(IndexError):
                break
except(ValueError, KeyError, TypeError):
    print('JSON format error')

# Getting data for Telegram
tdata = '{0} report:\n{1}'.format(date, '\n'.join(tcves))
tparams = urlencode({'chat_id': telegramid, 'text': tdata}).encode('utf-8')
if len(cves) == 0:
    print('There are no available vulnerabilities at ' + date)
    exit(0)
else:
    print('\n'.join(cves))
    if token == '' or telegramid == '':
        print('Telegram alert are not sent')
        exit(1)
    else:
        try:
            urlopen(tfull, tparams)
            print('Telegram alert are sent')
            exit(2)
        except(HTTPError):
            print('Telegram alert are not sent, check your token and ID')
            exit(3)