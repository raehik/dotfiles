#!/usr/bin/env python3
#coding: utf-8 -*-
#
# ayy volume
#

"""
volume_better - module to show current ALSA volume.

Requires:
  * python-mpd2 (NOT python2-pyalsaaudio)
  $ pip install pyalsaaudio
  https://aur.archlinux.org/packages/python-pyalsaaudio

@author raehik
@license MIT license
"""

from alsaaudio import Mixer, ALSAAudioError
from time import time



class Py3status:
    """
    Configuration parameters:
      * format: format
      * format_mute: format when muted
      * color: colour
      * color_mute: colour when muted
      * card: ALSA soundcard
      * mixer: ALSA mixer (e.g. 'Master', 'PCM')
      * mixer_id: ALSA mixer id (?) (default 0)
      * channel: ? (default 0)

    Format can contain:
      * {volume}: current volume (integer)
      * {mixer}: name of selected ALSA mixer
    """

    # available configuration parameters
    cache_timeout = 2
    format = "{volume}%"
    format_muted = "-M-"
    color = "#6666FF"
    color_muted = "#AA0000"
    card = 0
    mixer = "Master"
    mixer_id = 0
    channel = 0

    def get_volume(self, i3s_output_list, i3s_config):
        fdict = {}
        m = Mixer(control=self.mixer, id=self.mixer_id,
            cardindex=self.card)
        if m.getmute()[self.channel] == 1:
            volume_format = self.format_muted
            volume_color = self.color_muted
        else:
            volume_format = self.format
            volume_color = self.color

        fdict["mixer"] = self.mixer
        fdict["volume"] = m.getvolume()[self.channel]

        text = volume_format

        # replace {text} with the song value for the text key
        # e.g. {artist} -> info['artist']
        for key, value in fdict.items():
            text = text.replace("{" + key + "}", str(value))

        # form response
        response = {
            "cached_until": time() + self.cache_timeout,
            "full_text": text,
            "color": volume_color
        }

        return response



if __name__ == "__main__":
    """Test this module by calling it directly."""
    from time import sleep
    x = Py3status()
    while True:
        print(x.get_volume([], {}))
        sleep(1)
