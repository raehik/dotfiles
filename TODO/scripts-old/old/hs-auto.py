#!/usr/bin/env python3
#
# Short description of the program/script's operation/function.
#

import sys
import os
import argparse
import urllib.request as ur
from urllib.error import URLError
import xml.etree.ElementTree as eltree
import re
import subprocess
import time

FILENAME = sys.argv[0]
match_strings = [ re.compile(r"\[HorribleSubs\] Boku dake ga Inai Machi.*1080p", re.IGNORECASE),
                  re.compile(r"\[HorribleSubs\] Dimension W.*1080p", re.IGNORECASE),
                ]
cache_file = os.environ["HOME"] + "/.cache/hs-autodl"
dl_dir = os.environ["HOME"] + "/watch"
rss_link = "http://www.nyaa.se/?page=rss&term=horriblesubs"



"""Argparse override to print usage to stderr on argument error."""
class ArgumentParserUsage(argparse.ArgumentParser):
    def error(self, message):
        sys.stderr.write("error: %s\n" % message)
        self.print_help(sys.stderr)
        sys.exit(2)

"""Print usage and exit depending on given exit code."""
def usage(exit_code):
    if exit_code == 0:
        pipe = sys.stdout
    else:
        # if argument was non-zero, print to STDERR instead
        pipe = sys.stderr

    parser.print_help(pipe)
    sys.exit(exit_code)

"""Log a message to a specific pipe (defaulting to stdout)."""
def log_message(message, pipe=sys.stdout):
    print("[{}] hs-auto: ".format(time.strftime("%F %T")) + message, file=pipe)

"""If verbose, log an event."""
def log(message):
    if not args.verbose:
        return
    log_message(message)

"""Log an error. If given a 2nd argument, exit using that error code."""
def error(message, exit_code=None):
    log_message("error: " + message, sys.stderr)
    if exit_code:
        sys.exit(exit_code)



parser = ArgumentParserUsage(description="Description of the program's function (identical if you'd like).")

# add arguments
parser.add_argument("-v", "--verbose", help="be verbose",
                    action="store_true")

# parse arguments
args = parser.parse_args()

# force verbosity for now
args.verbose = True


while True:
    log("Starting check...")
    got_rss = False
    while not got_rss:
        try:
            with ur.urlopen(rss_link) as page:
                data = page.read()
            got_rss = True
        except:
            log_message("connection error, retrying in 30 minutes")
            time.sleep(1800)

    feed = eltree.fromstring(data)
    for item in feed.iter("item"):
        title = item.find("title").text
        if any(match_str.search(title) for match_str in match_strings):
            log("Matched: " + title)
            with open(cache_file, "r") as f:
                seen_links = f.read().split("\n")
            if title in seen_links:
                log("title cached, not downloading: " + title)
            else:
                log("downloading title " + title)
                link = item.find("link").text
                subprocess.call(["curl", "-JO", link], cwd=dl_dir)

                log("adding title to cache file")
                with open(cache_file, "a") as f:
                    f.write(title + "\n")
        else:
            #log("No match: " + title)
            pass

    log("Check finished, waiting 2 hrs")
    time.sleep(7200)
