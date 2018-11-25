#!/usr/bin/env python3
#
# Short description of the program/script's operation/function.
#

import sys
import argparse
import email
import re
import os

FILENAME = sys.argv[0]

target_from = re.compile(r"<?(noreply@deliveroo.co.uk)>?")
target_subject = re.compile(r"Orders delivered on (\d{4}-\d{2}-\d{2})")
outdir = "{}/{}".format(os.environ["HOME"], "life/work/2017-01-24-deliveroo/orders")

"""Argparse override to print usage to stderr on argument error."""
class ArgumentParserUsage(argparse.ArgumentParser):
    def error(self, message):
        sys.stderr.write("error: %s\n" % message)
        self.print_help(sys.stderr)
        sys.exit(2)

# Logging {{{
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
# }}}

parser = ArgumentParserUsage(description="Description of the program's function (identical if you'd like).")

# add arguments
parser.add_argument("-v", "--verbose", help="be verbose",
                    action="store_true")
parser.add_argument("indir",
                    help="directory to check for matching files (emails) in")

# parse arguments
args = parser.parse_args()

# force verbosity
args.verbose = True


def is_target_email(filename):
    try:
        with open(filename) as f:
            try:
                msg = email.message_from_file(f)
            except UnicodeDecodeError:
                log("don't know why but we can't read non-UTF-8 encoded files, skipping")
                return False
            if target_from.match(msg["from"]):
                s_match = target_subject.match(msg["subject"])
                if s_match:
                    return s_match.group(1)
    except FileNotFoundError:
        error("file " + filename + " does not exist", 1)

    return False

def save_email_text_to_file(filename, outfile):
    # before anything, if outfile already exists, back out and assume we already
    # processed this file
    if os.path.exists(outfile):
        log("outfile " + outfile + " already exists, assuming already saved...")
        return True

    try:
        with open(filename, "r") as f:
            msg = email.message_from_file(f)
            if msg.is_multipart():
                # only expecting non-multipart, so back out
                error(filename + " is a multipart message, backing out", 2)
            for part in msg.walk():
                if msg.get_content_type() != "text/plain":
                    # text/plain only please
                    error(filename + " main part not text/plain", 3)

                # finally, get the content
                msg_body = msg.get_payload(decode=True).decode("utf-8")
                with open(outfile, "w") as f_out:
                    f_out.write(msg_body)

    except FileNotFoundError:
        error("file " + filename + " does not exist", 1)

# we need an existing directory
if not os.path.isdir(args.indir):
    error(args.inpath + " is not a directory", 4)
if not os.path.isdir(outdir):
    error(args.outpath + " is not a directory", 4)

for f in os.listdir(args.indir):
    cur_file = "{}/{}".format(args.indir, f)
    if os.path.isfile(cur_file):
        email_date = is_target_email(cur_file)
        if email_date:
            save_email_text_to_file(cur_file, "{}/{}-orders.txt".format(outdir, email_date))
