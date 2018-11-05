# raehik's dotfiles
Stored using `stow`.

## Installation

    stow -t ~ <config folder>

`EDIT_*` files will very likely require some other configuration. Search for
EDIT in them to find the important lines more quickly.

## Dependencies
### General
Not tied to any one OS. *(But I do use Arch Linux, so my `--version`s are very
up-to-date.)*

  * Unix-like OS
  * Filesystem that supports symlinks
  * Git
  * systemd

### Specified
To find all dependencies in a given package (or overall if run in root):

```sh
ag -o "REQ: .*$"
```

Because these dotfiles aren't tied to a specific OS, dependencies are stored as
generic guidelines for finding the correct package to install: some might be
GitHub repos, others Pacman packages, others exact program names (that may come
packaged under a utility collection).

Where possible, dependencies are stored inline in config files (as comments), so
it should be clear why something is required.

### Not a big deal
You shouldn't have to worry too much about dependencies:

  * Most software configuration either doesn't expect any other software, or is
    tightly enough coupled that the user basically must have the dependency if
    they run it.
  * I try to gracefully skip things if a dependency isn't present.
  * A dependency will only be noted if its correct execution depends on the
    program referred to.
  * If my dotfiles provide some sort of option, or store the program in a
    generically-named variable, it's not considered a dependency.
  * Config files don't depend on themselves (`i3/config` doesn't require i3).

Most dependencies are concentrated in the X package, for various keybinds and
programs. Really it's just for those little background programs and scripts.

### systemd user services
Some systemd user services come pre-configured to be enabled. All systemd user
services are found at `~/.config/systemd/user` if you want to check it out.

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
