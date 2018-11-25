#!/usr/bin/env python3
#
# Shortlink expander.
#

import sys

shortlinks = {
    "wikipedia": "http://en.wikipedia.org/wiki/",
    "github": "https://github.com/",
}

if len(sys.argv) < 3:
    print("error: not enough arguments (expected 2)")
    sys.exit(1)

link = sys.argv[1]

matches = [k for k, v in shortlinks.items() if k.startswith(link)]

if len(matches) > 1:
    print("error: not specific enough")
    sys.exit(2)
elif len(matches) < 1:
    print("error: no shortlink for that link")
    sys.exit(3)
else:
    print(shortlinks[matches[0]] + sys.argv[2])
