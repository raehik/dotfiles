raehik's dotfiles
=================

Stored using stow.


Installation
------------

TODO

`EDIT_*` files will very likely require some other configuration. Search for
EDIT in them to find the important lines more quickly.


Structure
---------

  * `~/.assets`: things which change when I use my computers but should be the
    same across all, if possible

TODO etc.


dconf installation
------------------

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
