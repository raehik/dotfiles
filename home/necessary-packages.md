# All

openssh : Vital for most all usage cases
ntp : Just to run 1 command once, then you can remove:
    ntpd -qg ; hwclock -w
vim : Editor of choice
zsh : Shell of choice (bash will suffice)
tmux : Vital for administration
git : Vital for grabbing stuff

(these are installed by my arch-setup scripts)


# Primary disk

grub : The bootloader (suggested to install by arch-setup, because most
       installs i.e. those w/o another disk in the machine will require it)


# Multi-booting

os-prober : Reasonable automatic prober for GRUB


# Physical access/Desktop

## X

### Base

xorg-server : Necessary for all graphical programs (framebuffer sux)
(xorg-intel?)
xorg-xrdb   (is this with xorg-server?)
xorg-xrandr (is this with xorg-server?)
i3-wm
i3status
rxvt-unicode
firefox
(web fonts? defo need some...)


### Fonts

terminus-font : Best font
ttf-sazanami : CJK support


### Multimedia & games

#### Images

sxiv or feh : I dunno yet! feh doesn't support GIFs, so I'm not trying it until
              I have an issue with sxiv.
imagemagick : Great image tool. Command-line editing much better than GIMP.


#### Music

mpd :       Decent and -very- flexible music player
(vs cmus :  Fast & responsive, nice layout, but more limited (e.g. no icecast)
ncmpcpp :   Good + highly configurable MPD client


#### Video

NOT mplayer : Get mplayer2 from its git repo :

    git clone git://git.mplayer2.org/mplayer2-build.git


### Other

markdown : <-- (Markdown.pl, not discount or anything)
