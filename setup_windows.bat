@echo off

set TARGET_DIR=
cd %~dp0
set TARGET_DIR=%cd%
cd ../
set LINK_DIR=%cd%
cd %TARGET_DIR%

set TARGET=.vimrc
echo === %TARGET% ===
mklink %LINK_DIR%\%TARGET% %TARGET_DIR%\%TARGET%

set TARGET=_gvimrc
echo === %TARGET% ===
mklink %LINK_DIR%\%TARGET% %TARGET_DIR%\%TARGET%

set TARGET=.vim
echo === %TARGET% ===
mklink /D %LINK_DIR%\%TARGET% %TARGET_DIR%\%TARGET%

set TARGET=.emacs.d
echo === %TARGET% ===
mklink /D %LINK_DIR%\%TARGET% %TARGET_DIR%\%TARGET%

pause