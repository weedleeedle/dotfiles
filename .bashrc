#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \w]\$ '
if [ -f ~/.bash_alias ]; then
. ~/.bash_alias
fi

#Not needed? Don't remember what this is for
#eval $(gnome-keyring-daemon --start)
#export SSH_AUTH_SOCK

#exec /usr/bin/virtualenvwrapper.sh

INSTALLED_VERSION=`pacman -Qi linux-lts | awk -F ':' '/^Version/ {print $2;}' | tr -d ' '`
RUNNING_VERSION=`uname -r | sed 's/-lts//'`
[ $INSTALLED_VERSION != $RUNNING_VERSION ] && echo "New Kernel version available!"
#Set LS colors
eval "$(dircolors $DOTFILES/.dircolors)"
#echo `python $HOME/Code/linuxSays/script.py -p`


