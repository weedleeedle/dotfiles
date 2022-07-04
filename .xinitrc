#!/bin/sh
#xinput --map-to-output 'Melfas LGDisplay Incell Touch' eDP1

#THEME VARIABLE
export THEME="red"

#config directory
export XDG_CONFIG_HOME="/home/viperzer0/.config"

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
ln -s $XDG_CONFIG_HOME/rofi/config-$THEME.rasi $XDG_CONFIG_HOME/rofi/config.rasi
#Load terminal colors and stuff
xrdb .Xresources-$THEME
#START APPLICATIONS
#Keyboard stuff
fcitx5 -d
#Sets media control keys/backlight keys
xbindkeys
#Pscircle background. Should be able to just be ignored if not using I think?
/home/viperzer0/.scripts/pscircle-$THEME.sh &
#Some other applications we want to start
udiskie --tray &
xscreensaver &
autorandr -c 
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
#Start awesome!
exec /usr/bin/awesome -c /home/viperzer0/.config/awesome/rc.lua >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
