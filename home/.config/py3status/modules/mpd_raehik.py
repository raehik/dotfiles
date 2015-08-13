#!/usr/bin/env python3
#coding: utf-8 -*-
#
# ayy mpd
#

"""
mpd - module to show information from mpd in your i3bar.
Requires
    - python-mpd2 (NOT python2-mpd2)
    # pip install python-mpd2

@author shadowprince
@author raehik
@license Eclipse Public License
"""

import re
from mpd import (MPDClient, CommandError)
from socket import error as SocketError
from time import time
import os



class Py3status:
    """
    Configuration parameters:
        - format : indicator text format
        - host : mpd host
        - max_width : if text length will be greater - it'll shrink it
        - password : mpd password
        - port : mpd port

    Format of result string can contain:
        Track information:
        {artist}, {title}, {name}
    """

    # available configuration parameters
    cache_timeout = 2
    color_play = "#AA5500"
    color_stop = "#555555"
    color_pause = color_stop
    color_off = color_stop
    color_error = "#FF0000"
    format_play = "♬  {artist}{name}"
    format_pause = format_play
    format_stop = "<♬  stopped>"
    format_off = "<♬  off>"
    host = "localhost"
    max_width = 120
    password = None
    port = "6600"

    def __init__(self):
        self.text = ""

    def __response(self):
        response = {
            "cached_until": time() + self.cache_timeout,
            "full_text": self.text
        }

        if self.color:
            response["color"] = self.color

        return response

    def current_track(self, i3s_output_list, i3s_config):
        self.color = None
        # try to connect, with a password if specified
        try:
            client = MPDClient()
            client.connect(host=self.host, port=self.port)
            if self.password:
                client.password(self.password)
        except SocketError:
            # TODO: MPD probably isn't running
            self.text = self.format_off
            self.color = self.color_off
            return self.__response()
        except CommandError:
            # wrong password or so (?)
            self.text = "MPD: failed to authenticate!"
            self.color = self.color_error
            # but we did connect, so we have to disconnect
            client.disconnect()
            return self.__response()

        # get song & status info
        song = client.currentsong()
        status = client.status()["state"]


        # get information about song to use in formatting
        info = {}
        try:
            info["artist"] = song["artist"] + " - "
        except KeyError:
            # song doesn't have an artist set, so none :(
            info["artist"] = ""
            pass

        try:
            info["title"] = song["title"]
            info["name"] = song["title"]
        except KeyError:
            # song doesn't have a title set, so use filename
            info["title"] = ""
            info["name"] = os.path.basename(song['file'])

        info["file"] = os.path.basename(song['file'])

        # set colour & format based on MPD status
        if status == "play":
            self.color = self.color_play
            song_format = self.format_play
        elif status == "pause":
            self.color = self.color_pause
            song_format = self.format_pause
        elif status == "stop":
            self.color = self.color_stop
            song_format = self.format_stop

        text = song_format

        # replace {text} with the song value for the text key
        # e.g. {artist} -> info['artist']
        for key, value in info.items():
            text = text.replace("{" + key + "}", value)

        # crop text to fit to a width, if specified
        if len(text) > self.max_width:
            self.text = text[-self.max_width-3:] + "..."
        else:
            self.text = text

        return self.__response()



if __name__ == "__main__":
    """Test this module by calling it directly."""
    from time import sleep
    x = Py3status()
    while True:
        print(x.current_track([], {}))
        sleep(1)
