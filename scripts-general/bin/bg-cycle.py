#!/usr/bin/env python3
#
# Create backgrounds for applications.
#

import sys, os, argparse, logging, subprocess
from pathlib import Path

import random, glob

## Boilerplate utils class {{{
class BoilerplateClass:
    def _deinit(self):
        self.logger.debug("deinitialising...")

    def _init_logging(self):
        self.logger = logging.getLogger(os.path.basename(sys.argv[0]))
        lh = logging.StreamHandler()
        lh.setFormatter(logging.Formatter("%(name)s: %(levelname)s: %(message)s"))
        self.logger.addHandler(lh)

    def _parse_verbosity(self):
        if self.args.verbose == 1:
            self.logger.setLevel(logging.INFO)
        elif self.args.verbose >= 2:
            self.logger.setLevel(logging.DEBUG)
        if self.args.quiet >= 1:
            # reset verbosity (to make verbose/quiet checks easier)
            self.args.verbose = 0
            self.logger.setLevel(logging.NOTSET)

    def run(self):
        """Run from CLI: parse arguments, run main, deinitialise."""
        self._init_logging()
        self._parse_args()
        self.main()
        self._deinit()

    def fail(self, msg="internal error", ret=1):
        """Exit with a message and a return code.

        Should only be used for errors -- if you want to deinitialise and exit
        safely, simply return from main.

        Suggested to use no parameters for internal functions that the user
        doesn't need to know about (which generally indicates a logic error,
        rather than an input one.)
        """
        self.logger.error(msg)
        self._deinit()
        sys.exit(ret)

    def get_shell(self, cmd, cwd=None):
        """Run a shell command, blocking execution, detaching stdin, stdout and
        stderr.

        Useful for grabbing shell command outputs, or if you want to run something
        silently and wait for it to finish.

        @param cmd command to run as an array, where each element is an argument
        @param cwd if present, directory to use as CWD
        @return the command's return code, stdout and stderr (respectively, as a
                tuple)
        """
        proc = subprocess.run(cmd, stdin=subprocess.DEVNULL,
                                   stdout=subprocess.PIPE,
                                   stderr=subprocess.PIPE,
                                   cwd=cwd)
        return proc.returncode, \
               proc.stdout.decode("utf-8", "replace").strip(), \
               proc.stderr.decode("utf-8", "replace").strip()

    def get_shell_with_input(self, cmd, stdin_in, cwd=None):
        """Run a shell command with a given string passed to stdin, blocking
        execution and detaching stdout and stderr.

        We put a newline on the end of stdin_in, because that appears to be important for
        some programs (e.g. bc). TODO though, unsure. Maybe should be an option.

        @param cmd    command to run as an array, where each element is an argument
        @param std_in string to pass to stdin
        @param cwd    if present, directory to use as CWD
        @return the command's return code, stdout and stderr (respectively, as a
                tuple)
        """
        proc = subprocess.run(cmd, input=bytes("{}\n".format(stdin_in), "utf-8"),
                                   stdout=subprocess.PIPE,
                                   stderr=subprocess.PIPE,
                                   cwd=cwd)
        return proc.returncode, \
               proc.stdout.decode("utf-8", "replace").strip(), \
               proc.stderr.decode("utf-8", "replace").strip()

    def drop_to_shell(self, cmd, cwd=None):
        """Run a shell command, blocking execution.

        Doesn't touch any pipes. Like dropping to shell during execution.

        @param cmd command to run as an array, where each element is an argument
        @param cwd if present, directory to use as CWD
        @return the command's exit code
        """
        return subprocess.run(cmd, cwd=cwd).returncode
    ## Boilerplate utils class }}}

class BGCycler(BoilerplateClass):
    DEF_IMG_DIR = Path(os.environ.get("HOME"), "proj", "media", "backgrounds")
    DEF_OUT_DIR = Path(os.environ.get("XDG_DATA_HOME"), "backgrounds")

    DEF_WIDTH = "1920"
    DEF_HEIGHT = "1080"
    DEF_BRIGHTNESS = "-81"
    DEF_CONTRAST = "-91"

    ERR_IMG_CONVERSION_FAILED = 2
    ERR_IMG_FILE_ERROR = 3

    DEF_BG_NAME = "desktop"

    ## CLI-related {{{
    def _parse_args(self):
        self.parser = argparse.ArgumentParser(
                description="Create backgrounds for applications.",
                epilog="I use a rule of contrast = brightness-10 for a nice image.")
        self.parser.add_argument("-v", "--verbose", help="be verbose", action="count", default=0)
        self.parser.add_argument("-q", "--quiet", help="be quiet (overrides -v)", action="count", default=0)
        self.parser.add_argument("-d", "--img-dir",
                help="directory to read for images")
        self.parser.add_argument("-o", "--out-dir",
                help="directory to place backgrounds in")
        self.parser.add_argument("-n", "--bg-name",
                help="background name (= filename in background directory)",
                default=BGCycler.DEF_BG_NAME)
        self.parser.add_argument("-w", "--width",
                help="width to resize images to (when required)",
                default=BGCycler.DEF_WIDTH)
        self.parser.add_argument("-u", "--height",
                help="height to resize images to (when required)",
                default=BGCycler.DEF_HEIGHT)
        self.parser.add_argument("-b", "--brightness",
                help="converted image brightness",
                default=BGCycler.DEF_BRIGHTNESS)
        self.parser.add_argument("-c", "--contrast",
                help="converted image contrast",
                default=BGCycler.DEF_CONTRAST)
        self.parser.add_argument("images", nargs="*",
                help="images to use (instead of picking randomly)")

        self.args = self.parser.parse_args()

        self.args.verbose += 1 # force some verbosity
        self._parse_verbosity()

        if self.args.img_dir is not None:
            self.img_dir = Path(self.args.img_dir)
        else:
            self.img_dir = BGCycler.DEF_IMG_DIR

        if self.args.out_dir is not None:
            self.out_dir = Path(self.args.out_dir)
        else:
            self.out_dir = BGCycler.DEF_OUT_DIR

    ## }}}

    def create_background(self, bg_name, image, brightness, contrast, width, height):
        self.logger.info("{} -> {}".format(bg_name, image))

        background_path = Path(self.out_dir, bg_name+".png")

        cmd_convert_img = ["convert", str(image), "-brightness-contrast", "{}x{}".format(brightness, contrast)]
        if width == "0" or height == "0":
            pass
        else:
            cmd_convert_img += [
                    "-gravity", "center",
                    "-crop", "{}x{}+0+0".format(width, height)]
        cmd_convert_img.append(str(background_path))
        self.logger.debug("cmd: {}".format(" ".join(cmd_convert_img)))
        ret = self.drop_to_shell(cmd_convert_img)
        if ret != 0:
            self.fail("failed converting for background {}, image: {}".format(bg_name, image), BGCycler.ERR_IMG_CONVERSION_FAILED)

    def main(self):
        """Main entrypoint after program setup."""
        imgs = [x for x in self.img_dir.glob("**/*") if x.is_file()]
        random.shuffle(imgs)
        for img in self.args.images:
            imgs.append(img)

        if len(imgs) == 0:
            self.fail("no images available", BGCycler.ERR_IMG_FILE_ERROR)

        self.create_background(self.args.bg_name, imgs.pop(), self.args.brightness, self.args.contrast, self.args.width, self.args.height)

if __name__ == "__main__":
    program = BGCycler()
    program.run()
