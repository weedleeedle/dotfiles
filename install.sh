#!/bin/bash
# Apply all symbolic links to where they're supposed to go
SOURCE_DIR=$(pwd)
CONFIG_DIR=$HOME/.config
mkdir -p $CONFIG_DIR

ln -sv $SOURCE_DIR/awesome $CONFIG_DIR/awesome
ln -sv $SOURCE_DIR/nvim $CONFIG_DIR
ln -sv $SOURCE_DIR/.vimrc ~/.vimrc
ln -sv $SOURCE_DIR/.bash_alias ~/.bash_alias
ln -sv $SOURCE_DIR/.bashrc ~/.bashrc
ln -sv $SOURCE_DIR/.gitconfig ~/.gitconfig
ln -sv $SOURCE_DIR/.gtkrc ~/.gtkrc
ln -sv $SOURCE_DIR/.XCompose ~/.XCompose
ln -sv $SOURCE_DIR/.xinitrc ~/.xinitrc
ln -sv $SOURCE_DIR/.scripts ~/.scripts
ln -sv $SOURCE_DIR/alacritty $CONFIG_DIR/alacritty

# Make dir for rofi theme
mkdir $CONFIG_DIR/rofi
