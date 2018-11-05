# raehik's dotfiles
Stored using `stow`.

## Installation

    stow -t ~ <config folder>

`EDIT_*` files will very likely require some other configuration. Search for
EDIT in them to find the important lines more quickly.

## Requirements
Some parts of my dotfiles call other programs, or expect certain services to be
available. I like to use lots of small programs, so if you're using an old or
poorly-supported OS, you may not find them easily, or may have to build them
from source. That's fine, but sometimes it's hard to find missing dependencies
in the first place.

For that reason, where possible, generic requirements are stored inline in
config files (as comments). These are just guidelines for finding the correct
package to install: some might be GitHub repos, others Pacman packages, others
exact program names (that may come packaged under a utility collection)..

To find all requirements:

```sh
ag -o "REQ: .*$"
```

### Non-requirements
Usually though, configuration can be safely done without encountering any
problems. A requirement will only be noted if its correct execution depends on
the program referred to.

Where options are available, such as choice of window manager, as long as the
option isn't hardcoded (i.e. it's in a variable) then no requirement will be
added. *(Really it's just for those little/background programs.)*

### systemd user services
For every service in `~/.config/systemd/user` you want to enable:

    systemctl --user enable <file>
    systemctl --user start <file>

## Structure
  * `~/.assets`: things which change when I use my computers but should be the
    same across all, if possible

TODO etc.

## dconf installation
dconf is a low-level GNOME configuration tool which stores key-value pairs for
different programs together in a **single binary file** (`/.config/dconf/user`).
Instead of providing a base binary file, I load an edited text dump using `dconf
load` during installation. To do this yourself:

```sh
$ dconf dump /
[org/example-application]
key=value
...
$ dconf dump / > dconf.cfg
$ vim dconf.cfg
$ dconf reset -f / # resets everything
$ dconf load / < dconf.cfg
```

During install, only `dconf load` is done, so as to not delete other settings.
If you'd like to start anew, follow the instructions above.
