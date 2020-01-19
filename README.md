# dotfiles

## Installation
 
Clone the [dotfiles](https://github.com/okayson/dotfiles "dotfiles") on your home directory.

    git clone https://github.com/okayson/dotfiles.git

Update submodules.

    git submodule init
    git submodule update

Run the following script to make symbolic links on your home directory.

| OS           | script                     |
|:-------------|:---------------------------|
| unix / linux | dotfiles/setup.sh          |
| windows      | dotfiles/setup_windows.bat |

If necessary, Copy local setting files to your home directory and modify it.

    cp ~/dotfiles/local/.vimrc.local ~/
    cp ~/dotfiles/local/_gvimrc.local ~/
	vi .vimrc.local
	# modify...

*.vimrc.local* is loaded form *~/.vimrc*.  
*_gvimrc.local* is loaded form *~/_gvimrc*.

