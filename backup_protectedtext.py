#!/usr/bin/python3

#  Decription
#  ===========
#  Backup secrets from www.protectedtext.com to local storage
#  If file is changed, keep previous version with date postfix
#  Only backups once per day
#  Can be decrypted using `base64 -d BACKUP_FILE | openssl aes-256-cbc -d -k PASSWORD`
#  More info <http://developer.run/13>

#  Author: Dmitry (http://dmi3.net)
#  Source: https://github.com/dmi3/bin

#  Usage
#  =====
#  Run from commandline or add to cron


import urllib.request
import json
import os
import shutil
import datetime
import logging
import sys


SECRETS = ["anything"] # name of secret i.e. `https://www.protectedtext.com/` → `anything`
PATH = "/media/backup/"
SUCESS_PING_URL = "https://hchk.io/..." # https://healthchecks.io/ url
SECONDS_IN_DAY = 86400

logging.basicConfig(filename=PATH + 'manager.log',
                    level=logging.DEBUG,
                    format='%(asctime)s %(levelname)s %(message)s')


def log_except_hook(*exc_info):
    exc = "".join(traceback.format_exception(*exc_info))
    logging.critical(exc)
    failure(exc)
sys.excepthook = log_except_hook

logging.debug("Start")
for SECRET in SECRETS:
    SECRET_PATH = PATH + SECRET
    if os.path.isfile(SECRET_PATH) and (datetime.datetime.now().timestamp() - os.path.getmtime(SECRET_PATH)) < SECONDS_IN_DAY:
        logging.debug("Skipping as files were updated today")
        exit()

    r = urllib.request.urlopen("https://www.protectedtext.com/%s?action=getJSON" % SECRET)
    content = json.loads(r.read().decode("utf-8"))['eContent']

    if content == "":
        logging.debug("There no secret " + SECRET)
        exit()

    if os.path.isfile(SECRET_PATH):
        f = open(SECRET_PATH, "r")
        latest = f.read()
        f.close()
        if latest == content:
            logging.debug("No changes " + SECRET)
            continue
        shutil.move(SECRET_PATH, SECRET_PATH + datetime.datetime.now().strftime("_%d_%m_%Y"))

    with open(SECRET_PATH, "w") as f:
        f.write(content)
        logging.debug("Wrote " + SECRET)

# If app produces exception or exit(), will get error from Healthcheks
urllib.request.urlopen(SUCESS_PING_URL)
