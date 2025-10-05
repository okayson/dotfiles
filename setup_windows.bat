@echo off

set TARGET_DIR=
cd %~dp0
set TARGET_DIR=%cd%
set LINK_DIR=%UserProfile%

set TARGET=.vimrc
echo === %TARGET% ===
mklink %LINK_DIR%\%TARGET% %TARGET_DIR%\%TARGET%

set TARGET=_gvimrc
echo === %TARGET% ===
mklink %LINK_DIR%\%TARGET% %TARGET_DIR%\%TARGET%

set TARGET=.vim
echo === %TARGET% ===
mklink /D %LINK_DIR%\%TARGET% %TARGET_DIR%\%TARGET%

rem ------------------------------------
rem XDG Base Directory Specification
rem ------------------------------------
set APP=nvim
set TARGET=.config\%APP%
echo === %TARGET% ===
rem below directory is not used.
rem mklink /D %LINK_DIR%\%TARGET% %TARGET_DIR%\%TARGET%
mklink /D %LocalAppData%\%APP% %TARGET_DIR%\.config\%APP%

pause
