#!/usr/bin/env python3
#
# Short description of the program/script's operation/function.
#

import sys
import argparse

FILENAME = sys.argv[0]



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
    print(FILENAME + ": " + message, file=pipe)

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



import json
import requests

host = "al-420.local:8080"
req_create = "/post/create.json"
url_create = "http://" + host + req_create

login = "raehik"
#api_key = ""
password_hash=""

data = {
    "login": login,
    "password_hash": password_hash,
    "post[tags]": "shia labeouf dreams tumblr elemut",
    }

req = requests.post(url_create, data=data, files={
        "post[file]": open("/home/raehik/test4.jpg", "rb")
        }
    )

print(req.text)
print(req.status_code)
