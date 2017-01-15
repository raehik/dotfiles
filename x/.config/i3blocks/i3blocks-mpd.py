#!/usr/bin/env python3
#
# MPD i3blocks thing.
#
# Requires Python 3 and python-mpd2 (pip install python-mpd2).
# Requires mpc for click events.
#

import sys
import os
import subprocess

from mpd import (MPDClient, CommandError, ConnectionError)
from socket import error as SocketError

host = "localhost"
port = "6600"

ORANGE = "#AA5500"
GREY = "#555555"
BLUE = "#6666FF"

# Prefixes all full/short outputs, no matter what status.
prefix_str = "♬  "

text_stop = "<stopped>"
text_off = "<off>"

color_play = ORANGE
color_pause = GREY
color_stop = GREY
color_off = GREY

def run_command(args):
    """Run a command, returning the output and a boolean value
    indicating whether the command failed or not."""
    was_successful = True

    proc = subprocess.Popen(args, stdout=subprocess.PIPE)
    out, err = proc.communicate()

    if proc.returncode != 0:
        was_successful = False

    return out.decode("utf-8").strip(), was_successful

def check_pre_mouse_events():
    block_button = os.environ.get("BLOCK_BUTTON")
    if block_button == "3": # right click
        run_command(["mpc", "toggle"])
    elif block_button == "2": # middle click
        run_command(["mpc", "next"])
    elif block_button == "4": # scroll up
        run_command(["mpc", "volume", "+4"])
    elif block_button == "5": # scroll down
        run_command(["mpc", "volume", "-4"])

def check_transforming_mouse_events(full_text, short_text, color, exit_code):
    SECS_IN_MIN = 60
    new_full_text = full_text
    block_button = os.environ.get("BLOCK_BUTTON")
    if block_button == "1": # left click
        s_elapsed = round(float(client.status()["elapsed"]))
        s_len = round(float(song["time"]))
        s_c_m, s_c_s = divmod(s_elapsed, SECS_IN_MIN)
        s_m, s_s = divmod(s_len, SECS_IN_MIN)
        new_full_text += \
              " [{0}:{1:02d}/{2}:{3:02d}]".format(
                s_c_m, s_c_s, s_m, s_s)

    return new_full_text, short_text, color

def output_and_exit(full_text, short_text, color, exit_code=0):
    """Print output for i3blocks."""
    if exit_code == 0:
        # no errors & we want to check transforming mouse events
        full_text, short_text, color = check_transforming_mouse_events(
                full_text, short_text, color, exit_code)
    elif exit_code == -1:
        # no errors but we don't want to check transforming mouse events
        # don't be exiting with a fail code
        exit_code = 0
        pass
    else:
        # errors were encountered, but we don't do anything special except exit
        # with the error code
        pass
    print(prefix_str + full_text)
    print(prefix_str + short_text)
    print(color)

    sys.exit(exit_code)


# run non-transforming button checks
check_pre_mouse_events()

# try to connect to an MPD instance on the specified socket
client = MPDClient()
try:
    client.connect(host=host, port=port)
except ConnectionRefusedError:
    output_and_exit(text_off, text_off, color_off, -1)

# we connected, get some song info
song = client.currentsong()
status = client.status()["state"]
if status == "play":
    color = color_play
elif status == "pause":
    color = color_pause
elif status == "stop":
    # if we're stopped, exit before trying to get info
    output_and_exit(text_stop, text_stop, color_stop, -1)

# add artist if available, else nothing
song_full = ""
try:
    song_full += "{} - ".format(song["artist"])
except KeyError:
    pass

# add title if available, else filename
song_title = ""
try:
    song_title = song["title"]
except KeyError:
    song_title += os.path.basename(song["file"])
song_full += song_title

output_and_exit(song_full, song_title, color)
