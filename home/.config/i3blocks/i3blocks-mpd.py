#!/usr/bin/env python
#
# MPD i3blocks thing.
#

import sys
import os
import subprocess

from mpd import (MPDClient, CommandError, ConnectionError)
from socket import error as SocketError

host = "localhost"
port = "6600"

BROWN = "#AA5500"
GREY = "#555555"
BLUE = "#6666FF"

tag = "♬  "

text_play = tag + "{artist}{name}"
text_pause = text_play
text_stop = "<{0}stopped>".format(tag)
text_off = "<{0}off>".format(tag)

color_play = BROWN
color_pause = GREY
color_stop = GREY
color_off = GREY
color_error = GREY

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
        track_num = int(client.currentsong()["track"])
        disc_num = int(client.currentsong()["disc"])
        s_len = round(float(song["time"]))
        s_c_m, s_c_s = divmod(s_elapsed, SECS_IN_MIN)
        s_m, s_s = divmod(s_len, SECS_IN_MIN)
        new_full_text += \
              " [{0}:{1:02d}/{2}:{3:02d}]".format(
                s_c_m, s_c_s, s_m, s_s) \
            + " [{0}-{1:02d}]".format(
                disc_num, track_num)

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
    print(full_text)
    print(short_text)
    print(color)

    sys.exit(exit_code)



    # now check for mouse events
    check_mouse_events()

    # aaaand we're done
    sys.exit(exit_code)



# run non-transforming button checks
check_pre_mouse_events()

# try to connect to an MPD instance on the specified socket
client = MPDClient()
try:
    client.connect(host=host, port=port)
except ConnectionRefusedError:
    text = text_off
    color = color_off
    output_and_exit(text_off, text_off, color_off, -1)

# we connected, get some song info
song = client.currentsong()
status = client.status()["state"]
#self.insert_part(self.form_part(self.text_off, self.color_error))

if status == "play":
    text = text_play
    color = color_play
elif status == "pause":
    text = text_pause
    color = color_pause
elif status == "stop":
    # if we're stopped, exit before trying to get info
    text = text_stop
    color = color_stop
    output_and_exit(text, text, color, -1)

# get info about song (to use in formatting)
info = {}
info["file"] = os.path.basename(song["file"])

try:
    info["artist"] = song["artist"] + " - "
except KeyError:
    # song has no artist set, so none
    info["artist"] = ""

try:
    info["title"] = song["title"]
    info["name"] = song["title"]
except KeyError:
    # song has no title set, so use filename instead
    info["title"] = ""
    info["name"] = info["file"]

# replace format parts with actual values
# e.g. {artist} -> info["artist"]
for key, value in info.items():
    text = text.replace("{" + key + "}", value)

# done, output and exit
output_and_exit(text, info["name"], color)
