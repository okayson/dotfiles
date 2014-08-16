set TARGET_DIR=~/dotfiles/
set LINK_DIR=~/

set TARGET=.vimrc
echo === %TARGET% ===
ln -s $TARGET_DIR$TARGET $LINK_DIR$TARGET

set TARGET=_gvimrc
echo === %TARGET% ===
ln -s $TARGET_DIR$TARGET $LINK_DIR$TARGET

set TARGET=.vim
echo === %TARGET% ===
ln -s $TARGET_DIR$TARGET $LINK_DIR$TARGET


set TARGET=.emacs.d
echo === %TARGET% ===
ln -s $TARGET_DIR$TARGET $LINK_DIR$TARGET
