#!/bin/sh

#THEME VARIABLE
export THEME="space"

#config directory
export XDG_CONFIG_HOME="/home/viperzer0/.config"
export DOTFILES="/home/viperzer0/.dotfiles"

#Some default stuff apparently
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if [[ -n "`which luarocks 2>/dev/null`" ]]; then
    eval `luarocks path --bin`
fi

#Set rofi config theme
rm $XDG_CONFIG_HOME/rofi/config.rasi
ln -s $DOTFILES/rofi/config-$THEME.rasi $XDG_CONFIG_HOME/rofi/config.rasi
#Load terminal colors and stuff
xrdb $DOTFILES/Xresources/.Xresources-$THEME
#START APPLICATIONS
#Keyboard stuff
fcitx5 -d
#Sets media control keys/backlight keys
xbindkeys
#Some other applications we want to start
udiskie --tray &
xscreensaver &
autorandr -c 
xcompmgr &
#Start awesome!
exec /usr/bin/awesome -c /home/viperzer0/.config/awesome/rc.lua >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
