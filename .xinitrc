#!/bin/sh
xinput --map-to-output 'Melfas LGDisplay Incell Touch' eDP1
#xmodmap ~/.capless
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
#Keyboard stuff
fcitx5 -d
#set in /etc/X11/xorg.conf.d/00-keyboard.conf instead
#setxkbmap -option compose:caps
xbindkeys
export THEME="red"
export XDG_CONFIG_HOME="/home/viperzer0/.config"
rm $XDG_CONFIG_HOME/rofi/config.rasi
ln -s $XDG_CONFIG_HOME/rofi/config-$THEME.rasi $XDG_CONFIG_HOME/rofi/config.rasi
#Background script
/home/viperzer0/.scripts/pscircle-$THEME.sh &
udiskie --tray &
xscreensaver &
xrdb .Xresources-$THEME
#cadence-session-start -s >> ~/.cache/cadence/stdout 2>> ~/.cache/awesome/stderr
#For some reason this helps
#pulseaudio -D
#sleep 2
#killall pulseaudio
#pulseaudio --kill
#sleep 2
#pulseaudio -D
autorandr -c 
/home/viperzer0/.scripts/map-wacom.sh &
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
exec /usr/bin/awesome -c /home/viperzer0/.config/awesome/rc.lua >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
