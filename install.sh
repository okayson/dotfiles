#!/bin/bash

this_file=$(cd $(dirname $0); pwd)
bin_dir=~/bin
bashrc_file=~/.bashrc

function has() {

  type "$1" >/dev/null 2>&1

}

if [ ! -d "${bin_dir}" ]; then
  echo "Make ${bin_dir}."
  mkdir ${bin_dir}
fi

#--------------------------------------------------
# Install by apt
#--------------------------------------------------
sudo apt install git -y
sudo apt install vim -y
sudo apt install tmux -y
sudo apt install global -y
sudo apt install exuberant-ctags -y
sudo apt install silversearcher-ag -y
sudo apt install build-essential -y

#--------------------------------------------------
# Install fzf
#--------------------------------------------------
if [ ! -d "${bin_dir}/fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ${bin_dir}/fzf
  if [ $? -eq 0 ]; then
    ${bin_dir}/fzf/install
  else
    echo "Failed to install fzf."
  fi
fi

#--------------------------------------------------
# Install enhancd
#--------------------------------------------------
if [ ! -d "${bin_dir}/enhancd" ]; then
  git clone --depth 1 https://github.com/b4b4r07/enhancd ${bin_dir}/enhancd
  if [ $? -eq 0 ]; then
	  echo "" >> ${bashrc_file}
	  echo "[ -f ${bin_dir}/enhancd/init.sh ] && source ${bin_dir}/enhancd/init.sh" >> ${bashrc_file}
  else
    echo "Failed to install enhancd."
  fi
fi

#--------------------------------------------------
# Tear down
#--------------------------------------------------
source ~/.bashrc

