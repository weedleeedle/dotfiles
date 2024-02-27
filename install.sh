#!/bin/bash
# Apply all symbolic links to where they're supposed to go
SOURCE_DIR=$(pwd)
ln -sv $SOURCE_DIR/autorandr ~/.config
ln -sv $SOURCE_DIR/awesome ~/.config
ln -sv $SOURCE_DIR/cmus ~/.config
ln -sv $SOURCE_DIR/nvim ~/.config
ln -sv $SOURCE_DIR/.vimrc ~/.vimrc
ln -sv $SOURCE_DIR/.bash_alias ~/.bash_alias
ln -sv $SOURCE_DIR/.bashrc ~/.bashrc
ln -sv $SOURCE_DIR/.gitconfig ~/.gitconfig
ln -sv $SOURCE_DIR/.gtkrc ~/.gtkrc
ln -sv $SOURCE_DIR/.XCompose ~/.XCompose
ln -sv $SOURCE_DIR/.xinitrc ~/.xinitrc
ln -sv $SOURCE_DIR/.scripts ~/.scripts

# Make dir for rofi theme
mkdir ~/.config/rofi
