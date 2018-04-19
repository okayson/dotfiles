#!/bin/bash

TARGET_DIR=$HOME/dotfiles/
LINK_DIR=$HOME/

TARGET=.vimrc
echo === $TARGET ===
ln -s $TARGET_DIR$TARGET $LINK_DIR$TARGET

TARGET=_gvimrc
echo === $TARGET ===
ln -s $TARGET_DIR$TARGET $LINK_DIR$TARGET

TARGET=.vim
echo === $TARGET ===
ln -s $TARGET_DIR$TARGET $LINK_DIR$TARGET

