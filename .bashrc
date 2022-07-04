#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
alias ls='ls --color=auto'
PS1='[\u@\h \w]\$ '
if [ -f ~/.bash_alias ]; then
. ~/.bash_alias
fi
export PATH=$PATH:$HOME/.local/bin:$HOME/.scripts:$HOME/.dotnet/tools

export GLEAMVIZ_ROOT="/home/viperzer0/GLEAMviz-data"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/viperzer0/GLEAMviz/libs"

export GLEAMVIZ_INSTALLDIR="/home/viperzer0/GLEAMviz"

export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

#Not needed? Don't remember what this is for
#eval $(gnome-keyring-daemon --start)
#export SSH_AUTH_SOCK

#Set LS colors
eval "$(dircolors $DOTFILES/.dircolors)"

