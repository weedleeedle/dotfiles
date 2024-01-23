#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \w]\$ '
if [ -f ~/.bash_alias ]; then
. ~/.bash_alias
fi
export PATH=$PATH:$HOME/.local/bin:$HOME/.scripts:$HOME/.dotnet/tools:$HOME/.cargo/bin

export GLEAMVIZ_ROOT="/home/viperzer0/GLEAMviz-data"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/viperzer0/GLEAMviz/libs"

export GLEAMVIZ_INSTALLDIR="/home/viperzer0/GLEAMviz"

export WORKON_HOME=$HOME/.virtualenvs

export EDITOR=nvim

source /usr/bin/virtualenvwrapper.sh

#Not needed? Don't remember what this is for
#eval $(gnome-keyring-daemon --start)
#export SSH_AUTH_SOCK

INSTALLED_VERSION=`pacman -Qi linux | awk -F ':' '/^Version/ {print $2;}' | tr -d ' '`
RUNNING_VERSION=`uname -r | sed 's/-/./'`
[ $INSTALLED_VERSION != $RUNNING_VERSION ] && echo "New Kernel version available!"
#Set LS colors
eval "$(dircolors $DOTFILES/.dircolors)"
echo `python $HOME/Code/linuxSays/script.py -p`
