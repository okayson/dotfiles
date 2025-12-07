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
if [ ! -d "${BIN_DIR}/fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ${BIN_DIR}/fzf
  ${BIN_DIR}/fzf/install
fi

# Install enhancd
if [ ! -d "${BIN_DIR}/enhancd" ]; then
  git clone --depth 1 https://github.com/b4b4r07/enhancd ${BIN_DIR}/enhancd
  echo "" >> ${BASHRC_FILE}
  echo "[ -f ${BIN_DIR}/enhancd/init.sh ] && source ${BIN_DIR}/enhancd/init.sh" >> ${BASHRC_FILE}
fi

#--------------------------------------------------
# Tear down
#--------------------------------------------------
source ~/.bashrc

