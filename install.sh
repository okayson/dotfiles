#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

readonly BIN_DIR=~/bin
readonly BASHRC_FILE=~/.bashrc

# === List of PPAs to add ===
readonly PPAS=(
    "ppa:neovim-ppa/unstable"
    # "ppa:another/example"  ← Add more if needed
)

# === List of packages to install ===
readonly APT_PACKAGES=(
    "software-properties-common"
    "git"
    "vim"
    "tmux"
    "global"
    "exuberant-ctags"
    "build-essential"
    "expect"  # for unbuffer
    "fd-find"
    "ripgrep"
    "bat"
    "make"
    "unzip"
    "gcc"
    "curl"
    "neovim"
    "luarocks"  # for lazy.nvim
#   "lazygit"
#   "nodejs"
#   "npm"
#   "fzf"
    # Add more packages if needed
)

readonly NPM_PACKAGES=(
    "tree-sitter-cli"
)

#--------------------------------------------------
# Register PPAs
#--------------------------------------------------
echo "[INFO] Register PPAs..."
for PPA in "${PPAS[@]}"; do
    echo "Adding $PPA..."
    sudo add-apt-repository -y "$PPA"
done

#--------------------------------------------------
# Install by apt
#--------------------------------------------------
echo "[INFO] Updating package information..."
sudo apt update

echo "[INFO] Installing/updating the following packages: ${APT_PACKAGES[*]}"
sudo apt install -y "${APT_PACKAGES[@]}"

echo "[INFO] Package installation completed."

# Check versions of installed packages
# for pkg in "${APT_PACKAGES[@]}"; do
#     if command -v "$pkg" &>/dev/null; then
#         echo "$pkg version:"
#         $pkg --version | head -n 1
#     else
#         echo "$pkg is not installed."
#     fi
# done

# Remove unused packages
sudo apt-get autoremove -y

#--------------------------------------------------
# Install by npm
#--------------------------------------------------
#echo "[INFO] Installing/updating the following npm packages: ${NPM_PACKAGES[*]}"
#for NPM_PKG in "${NPM_PACKAGES[@]}"; do
#    echo "Installing/updating $NPM_PKG..."
#    npm install -g "$NPM_PKG"
#done

#--------------------------------------------------
# Install by manualy
#--------------------------------------------------
if [ ! -d "${BIN_DIR}" ]; then
  echo "[INFO] Make ${BIN_DIR}."
  mkdir ${BIN_DIR}
fi

# Install fzf
readonly FZF_BIN_DIR=${BIN_DIR}/fzf

if [ ! -d "${FZF_BIN_DIR}" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ${FZF_BIN_DIR}
  ${FZF_BIN_DIR}/install
else
  (
    cd ${FZF_BIN_DIR} || exit 1
    git pull
  )
fi

# Install enhancd
readonly ENHANCD_BIN_DIR=${BIN_DIR}/enhancd
readonly ENHANCD_BASH_LINE="[ -f ${ENHANCD_BIN_DIR}/init.sh ] && source ${ENHANCD_BIN_DIR}/init.sh"

if [ ! -d "${ENHANCD_BIN_DIR}" ]; then
  git clone --depth 1 https://github.com/babarot/enhancd.git ${ENHANCD_BIN_DIR}
  grep -nF ${ENHANCD_BASH_LINE} ${BASHRC_FILE} >/dev/null
  if [ $? -eq 0 ]; then
    echo "[INFO] ${ENHANCD_BASH_LINE} is already exists in ${BASHRC_FILE}."
  else
    echo "${ENHANCD_BASH_LINE}">> ${BASHRC_FILE}
  fi
else
  (
    cd ${ENHANCD_BIN_DIR} || exit 1
    git pull
  )
fi

#--------------------------------------------------
# Tear down
#--------------------------------------------------
source ~/.bashrc

