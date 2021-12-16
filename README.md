# dotfiles

## Set up dotfiles
 
Clone the [dotfiles](https://github.com/okayson/dotfiles "dotfiles") on your home directory.
```shell
$ git clone https://github.com/okayson/dotfiles.git
```

Update submodules.

```shell
$ git submodule init
$ git submodule update
```

Run the following script to make symbolic links on your home directory.

| OS           | script                     |
|:-------------|:---------------------------|
| unix / linux | dotfiles/setup.sh          |
| windows      | dotfiles/setup_windows.bat |

If necessary, Copy local setting files to your home directory and modify it.

```shell
$ cp ~/dotfiles/local/.vimrc.local ~/
$ cp ~/dotfiles/local/_gvimrc.local ~/
$ vi .vimrc.local
# modify...
```

* `.vimrc.local` is loaded form `~/.vimrc`.
* `_gvimrc.local` is loaded form `~/_gvimrc`.


## Install software(Linux)
 
For Linux, Type:

```shell
$ cd /path/to/dotfiles
$ ./install.sh
```


## Install software(WSL)

It requires some software to make vim easier to user on WSL. 
Put these software in a directory that is set `Path` of windows enviroment variable.

_Note: It is recommended that you make `%UserProfile%\bin` and set it in the `Path`._

### win32yank

`win32yank` is used to yank and put the text to the Windows clipboard.  
See `.vimrc` for how to use.  

_equalsraf/win32yank_
[https://github.com/equalsraf/win32yank](https://github.com/equalsraf/win32yank)
[Release](https://github.com/equalsraf/win32yank/releases)

### zenhan

`zenhan` is used to set IM `OFF` When leaving `insert-mode` and `command-line-mode`.

_iuchim/zenhan_
[https://github.com/iuchim/zenhan](https://github.com/iuchim/zenhan)
[Release](https://github.com/iuchim/zenhan/releases)


