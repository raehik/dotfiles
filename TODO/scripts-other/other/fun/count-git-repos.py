#!/usr/bin/env python3
#
# Count number of Git repositories recursively from current working dir.
#

import sys
import os
import subprocess
import random
import argparse

FILENAME = sys.argv[0]

start_dir = os.getcwd()
unwanted_dirs = [".git"]
MAX_REPOS_TO_PRINT = 10

FNULL = open(os.devnull, "w")

def get_shell(args, cwd):
    """Run a shell command, returning the output and error code."""
    was_successful = False

    proc = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=FNULL, cwd=cwd)
    out, err = proc.communicate()

    if proc.returncode == 0:
        was_successful = True

    return out.decode("utf-8").strip(), was_successful

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



# prepare count display
print("Count: 0", end="", flush=True)

git_dirs = []
all_dirs = os.walk(start_dir)
for d in all_dirs:
    # speed up by not checking certain directories (e.g. '.git')
    for d2 in unwanted_dirs:
        if d2 in d[1]:
            d[1].remove(d2)
    git_dir, is_git_dir = get_shell(["git", "rev-parse",
        "--show-toplevel", ], d[0])
    if is_git_dir:
        if not git_dir in git_dirs:
            git_dirs.append(git_dir)

            # clear line
            print("\r\033[K", end="")

            #
            print("Count: {}".format(len(git_dirs)), end="", flush=True)

# done, clean up line
print()

# print repos, but neatly -- if there are too many, we'll print a random
# selection
if len(git_dirs) > MAX_REPOS_TO_PRINT:
    print("You have a lot of repos! Here is a selection:")
    repos_to_print = random.sample(git_dirs, MAX_REPOS_TO_PRINT)
else:
    print("These are all we found:")
    repos_to_print = git_dirs

for repo in repos_to_print:
    repo = repo.replace(start_dir, ".")
    print(" * {}".format(repo))
