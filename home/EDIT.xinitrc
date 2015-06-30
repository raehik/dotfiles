#!/bin/sh
#
# xinitrc tells xinit and startx what programs to start up.
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Set keyboard layout
setxkbmap -layout gb

# Set primary X output
#xrandr --output eDP1 --primary

# Turn off all X system bells (PC speaker beeps)
# (note: doesn't affect tty beeps - see your shell rc file (i.e. ~.zshrc))
xset b off

# Set brightness to half to conserve power
# Only for laptops (or those sorts of displays I guess)
#xbacklight -set 50 -time 0

# If .Xresources is present, load it
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# IBus biz
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx

# Set up second monitor
#xrandr --output VGA1 --auto --right-of eDP1

# Start up compositor (just used for vsync for now)
compton --vsync opengl &

# Start up pasystray (comes in handy)
pasystray &

# Set desktop background
sh ~/.fehbg &

# Start keylogger
xinput-keylog &

# Start window manager (must be final command!)
exec i3
