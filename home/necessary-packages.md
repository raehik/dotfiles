# All

openssh : Vital for most all usage cases
ntp     : Just to run 1 command once:
            ntpd -qg ; hwclock -w
          But it's useful enough to keep.
vim     : Editor of choice
zsh     : Shell of choice (bash will suffice, however)
tmux    : Vital for administration
git     : Vital for grabbing stuff

(these are all installed by default by my arch-setup scripts)


# Booting

grub : The bootloader (suggested to install by arch-setup, because most
       installs i.e. those w/o another disk in the machine will require it)


## Multi-booting

os-prober : Reasonable automatic prober for GRUB


# Physical access/Desktop

## X

### Base

xorg-server         : Necessary for all graphical programs (framebuffer sux)
xorg-xrdb           : "X server resource database utility" - load .Xresources
xorg-xrandr         : Set size etc. of screen (+ multi-screen setup?)
xorg-xinit          : Run .xinit on startup
xorg-xset           : For xset b off (in .xinitrc)
xf86-video-intel,
xf86-video-ati,
xf86-video-nouveau  : Depends on your chipset/graphics card
i3-wm               : Window manager of choice
i3status            : Nice status bar for i3
dmenu               : Necessary for launching apps in i3
rxvt-unicode        : Terminal emulator of choice
firefox             : Pretty much no other choice for a decent browser
(web fonts? defo need some...)


### Fonts

terminus-font : Best font
ttf-sazanami : CJK support


### Multimedia & games

#### Images

sxiv or feh : I dunno yet! feh doesn't support GIFs, so I'm not trying it until
              I have an issue with sxiv.
imagemagick : Great image tool, CLI interface/editing much better than GIMP.


#### Audio & Music

alsa-utils  : ALSA is already installed, but this includes alsamixer
mpd         : Decent and -very- flexible music player
(vs cmus:  Fast & responsive, nice layout, but more limited (e.g. no icecast)
ncmpcpp     : Good + highly configurable MPD client

NOT mplayer : Get mplayer2 from its git repo :

    git clone git://git.mplayer2.org/mplayer2-build.git

Requires base-devel and yasm, possibly others.


## Interoperability (i.e. working with Windows)

ntfs-3g : allows read/write access to NTFS filesystems


## Other

markdown    : <-- (Markdown.pl, not discount or anything)
