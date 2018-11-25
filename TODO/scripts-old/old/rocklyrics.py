#!/usr/bin/env python
#
# Prepend each line in a file with a fixed string.
#

import fileinput
import sys

for lyrics in sys.argv[1:]:
    for line in fileinput.input([lyrics], inplace=True):
        sys.stdout.write('[00:00:00] {l}'.format(l=line))
