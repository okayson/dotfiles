#!/bin/bash

readonly BIN_DIR=~/bin
readonly BASHRC_FILE=~/.bashrc

if [ ! -d "${BIN_DIR}" ]; then
  echo "Make ${BIN_DIR}."
  mkdir ${BIN_DIR}
fi

#--------------------------------------------------
# Install by apt
#--------------------------------------------------
sudo apt update
if [ $? != 0 ]; then
  echo "Abort installing."
  exit 1
fi

sudo apt install git -y
sudo apt install vim -y
sudo apt install tmux -y
sudo apt install global -y
sudo apt install exuberant-ctags -y
sudo apt install silversearcher-ag -y
sudo apt install build-essential -y
sudo apt install expect -y              # for unbuffer
sudo apt install fd-find -y
sudo apt install ripgrep -y
sudo apt install bat -y

#--------------------------------------------------
# Install fzf
#--------------------------------------------------
if [ ! -d "${BIN_DIR}/fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ${BIN_DIR}/fzf
  if [ $? -eq 0 ]; then
    ${BIN_DIR}/fzf/install
  else
    echo "Failed to install fzf."
  fi
fi

#--------------------------------------------------
# Install enhancd
#--------------------------------------------------
if [ ! -d "${BIN_DIR}/enhancd" ]; then
  git clone --depth 1 https://github.com/b4b4r07/enhancd ${BIN_DIR}/enhancd
  if [ $? -eq 0 ]; then
	  echo "" >> ${BASHRC_FILE}
	  echo "[ -f ${BIN_DIR}/enhancd/init.sh ] && source ${BIN_DIR}/enhancd/init.sh" >> ${BASHRC_FILE}
  else
    echo "Failed to install enhancd."
  fi
fi

#--------------------------------------------------
# Tear down
#--------------------------------------------------
source ~/.bashrc

