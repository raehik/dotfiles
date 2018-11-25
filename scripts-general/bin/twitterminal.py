#!/usr/bin/env python3
#
# Tweet from the shell.
#
# Requires the following pip packages:
#   * simplejson
#   * twitter (NOT python-twitter, aka Python Twitter Tools)
#

import raehutils
import sys, os, argparse, logging

# twitter requires a json module
# simplejson is updated more and may be faster
# see: http://stackoverflow.com/questions/712791
import simplejson
import twitter

class Twitterminal(raehutils.RaehBaseClass):
    CREDS_FILE = os.getenv('HOME')+"/.twitterminal_creds"
    APP_CREDS_FILE = os.getenv('HOME')+"/.twitterminal_appcreds"

    ERR_ARGS = 1
    ERR_OAUTH = 2

    def __init__(self):
        self.__init_client()

    def __init_client(self):
        """Initialise the Twitter client."""
        # get application OAuth tokens
        with open(Twitterminal.APP_CREDS_FILE) as f:
            api_tokens = [line.strip() for line in f]
        if len(api_tokens) != 2:
            exit("app creds key incorrectly formatted", ERR_OAUTH)

        # get consumer OAuth tokens
        # TODO: the oauth dance if required
        #twitter.oauth_dance("twitterminal.py", api_tokens[0], api_tokens[1], Twitterminal.CREDS_FILE)
        oauth_token, oauth_secret = twitter.read_token_file(Twitterminal.CREDS_FILE)

        self.client = twitter.Twitter(auth=twitter.OAuth(oauth_token,
            oauth_secret, api_tokens[0], api_tokens[1]))

    ## CLI-related {{{
    def _parse_args(self):
        self.parser = argparse.ArgumentParser(description="Tweet from the shell.")
        self.parser.add_argument("-v", "--verbose", help="be verbose", action="count", default=0)
        self.parser.add_argument("-q", "--quiet", help="be quiet (overrides -v)", action="count", default=0)
        self.parser.add_argument("message", help="text to tweet")

        self.args = self.parser.parse_args()

        self._parse_verbosity()

        if len(self.args.message) == 0:
            exit("message needs to be longer than 0 characters", ERR_ARGS)
    ## }}}

    def main(self):
        """Main entrypoint after program initialisation."""
        self.tweet(self.args.message)

    def tweet(self, msg):
        """Tweet a message."""
        self.client.statuses.update(status=msg)

if __name__ == "__main__":
    twat = Twitterminal()
    twat.run()
